const functions = require('firebase-functions');
const bodyParser = require('body-parser');
const cors = require('cors');
const express = require('express');
const admin = require('firebase-admin');
admin.initializeApp();

const stripe = require('stripe')(functions.config().stripe);

//============================================================
const test = express();
test.use(cors({ origin: true }));

function generateCartItem(item_name, item_amount, item_quantity) {
  return {
    price_data: {
      currency: "usd",
      product_data: {
        name: String(item_name)
      },
      unit_amount: item_amount
    }, 
    quantity: item_quantity,
  }
}

test.post('/', async (req, res) => {

  //var req_data = JSON.parse(req.body);

  //var stuff = req_data.items;
  var docID_list = [];
  var quantity_list = [];

  // console.log("checking...");
  req.body.items.forEach(item => {
    docID_list.push(item.docID);
    quantity_list.push(item.quantity);
    console.log(item.docID);
  });

  //console.log(generateCartItem("brok", 54, 43));

  var db = admin.firestore().collection("products").where(admin.firestore.FieldPath.documentId(), "in", docID_list).get().then(snapshot => {
    //console.log("burp")
    
    snapshot.forEach(doc => {
      console.log(doc.data());
    });
    //console.log(snapshot.get("price"));
    //console.log(snapshot);
    res.json({"cat": "burger"});
  }).catch(reason => {
    console.log(reason);
    res.send(reason);
  })
  res.json({"fe":"fe"})
  

});

//============================================================
const app = express();
app.use(bodyParser.json());
app.use(cors({ origin: true }));


app.post('/', async (req, res) => {
  //console.log(req.body);
  // var db = admin.firestore();
  // const snapshot = db.collection("products").doc("1muLD6D3Q5Fl3INH9Zm4").get();
  // snapshot.forEach(doc => {
  //   console.log(doc.id, '=>', doc.data());
  // });
  var docID_list = [];
  var quantity_list = [];
  var req_data = JSON.parse(req.body);
  // console.log(req_data.docID);
  // console.log(req_data.quantity);
  // console.log(req_data.items);

  req_data.items.forEach(item => {
    docID_list.push(item.docID);
    quantity_list.push(item.quantity);
  });

  // console.log(docID_list);
  // console.log(quantity_list);

  admin.firestore().collection("products").where(admin.firestore.FieldPath.documentId(), 'in', docID_list).get().then(snapshot => {
    //console.log(snapshot.get("price"));
    console.log("firestore retrieved");
    
    var line_item_list = [];
    
    var counter = 0;
    snapshot.forEach(doc => {
      counter = counter + 1;
      var amount = String(Number.parseFloat(doc.get('price')).toFixed(2)).replace(".", "");
      var product_name = String(doc.get('imagetext'));  
      line_item_list.push(generateCartItem(product_name, amount, 1));
    });

    //const paymentMethods = getPaymentMethods(req_data.customer);
    //console.log(paymentMethods);

    // return stripe.paymentMethods.list({
    //     customer: String(req_data.customer),
    //     type: 'card',
    //   });
    // }).then(result => {
    //   console.log(result);
    //   res.send(result);
    // });
    
    //console.log(line_item_list);

    
    return stripe.checkout.sessions.create({
        payment_intent_data: {
          setup_future_usage: 'off_session',
        },
        payment_method_types: ['card'],
        line_items: line_item_list,
        mode:'payment',
        success_url: 'https://yoursite.com/success.html',
        cancel_url: 'https://example.com/cancel',
      }).then(session => {
        console.log(line_item_list);
        console.log("response given");
        res.json({id: session.id});        
      });
  }).catch(reason =>{
    console.log(reason);
    res.send(reason);
  });
});

async function getPaymentMethods(customerId) {
  return
}

async function createPayment(itemsToPurchase, custoemrId) {}


//============================================================
const customer_creation = express();
customer_creation.use(bodyParser.json());
customer_creation.use(cors({ origin: true }));

customer_creation.post('/', async (req, res) => {
  var req_data = JSON.parse(req.body);

  console.log(req_data);

  const customer = await stripe.customers.create({
    id: String(req_data.customer),
  });
})

exports.customer_creation = functions.https.onRequest(customer_creation);
exports.test = functions.https.onRequest(test);
exports.payment = functions.https.onRequest(app);



//To find the different in months not including days
function monthDiff(dateFrom, dateTo) {
  return dateTo.getMonth() - dateFrom.getMonth() + 
    (12 * (dateTo.getFullYear() - dateFrom.getFullYear()));
}

//Function that is called when order is created
exports.onOrderCreated = functions.firestore
.document('/users/{userId}/orders/{orderId}')
.onCreate((snap, context) => {
  const userId = context.params.userId
  const orderId = context.params.orderId
  //console.log('New order' + orderId + ' for user ' + userId);

  const curPurchaseDate = snap.get('date').toDate();
  //console.log(curPurchaseDate);
  // const date = orderData.date;

  return admin.firestore().collection('users').doc(userId).get().then(snapshot => {
    const prevPurchaseDate = snapshot.get('prevMonthOfPurchase').toDate();
    const prevTotalMonths = snapshot.get('totalMonths');
    const prevConsecutiveMonths = snapshot.get('consecutiveMonths');
    const prevTotalTrees = snapshot.get('totalTrees');
    const prevTreesThisMonth = snapshot.get('treesThisMonth');
    const difference = monthDiff(prevPurchaseDate, curPurchaseDate);

    if (difference == 1) {
      return admin.firestore().collection('users').doc(userId).update({
        consecutiveMonths: prevConsecutiveMonths + 1, 
        prevMonthOfPurchase: snap.get('date'),
        totalMonths: prevTotalMonths + 1,
        treesThisMonth: snap.get('trees'),
        totalTrees: prevTotalTrees + snap.get('trees')
      });
    } else if (difference > 1) {
      return admin.firestore().collection('users').doc(userId).update({
        consecutiveMonths: 1, 
        prevMonthOfPurchase: snap.get('date'),
        totalMonths: prevTotalMonths + 1,
        treesThisMonth: snap.get('trees'),
        totalTrees: prevTotalTrees + snap.get('trees')
      });
    } else if (difference == 0) {
      return admin.firestore().collection('users').doc(userId).update({
        prevMonthOfPurchase: snap.get('date'),
        treesThisMonth: prevTreesThisMonth + snap.get('trees'),
        totalTrees: prevTotalTrees + snap.get('trees')
      });
    }
  });
  console.log(snapshot.data());
  
});


