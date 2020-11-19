const functions = require('firebase-functions');
const bodyParser = require('body-parser');
const cors = require('cors');
const express = require('express');
const admin = require('firebase-admin');
admin.initializeApp();

const stripe = require('stripe')(functions.config().stripe.secret);

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

  //console.log(req.body.cat);

  req.body.items.forEach(item => {
    docID_list.push(item.docID);
    quantity_list.push(item.quantity);
  });

  console.log(generateCartItem("brok", 54, 43));

  var db = admin.firestore().collection("products").where(admin.firestore.FieldPath.documentId(), "in", docID_list).get().then(snapshot => {
    console.log("burp")
    
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
      var amount = String(doc.get('price')).replace(".", "");
      var product_name = String(doc.get('imagetext'));  
      line_item_list.push(generateCartItem(product_name, amount, 1));
    });

    console.log(line_item_list);
    return stripe.checkout.sessions.create({
    payment_method_types: ['card'],
    line_items: line_item_list,
    mode:'payment',
    success_url: 'https://yoursite.com/success.html',
    cancel_url: 'https://example.com/cancel',
    });
  }).then(session => {
    res.json({id: session.id});
  }).catch(reason =>{
    res.send(reason);
  });
});

exports.test = functions.https.onRequest(test);
exports.payment = functions.https.onRequest(app);

function monthDiff(dateFrom, dateTo) {
  return dateTo.getMonth() - dateFrom.getMonth() + 
    (12 * (dateTo.getFullYear() - dateFrom.getFullYear()));
}

exports.onOrderCreated = functions.firestore
.document('/users/{userId}/orders/{orderId}')
.onCreate((snap, context) => {
  const userId = context.params.userId
  const orderId = context.params.orderId
  console.log('New order' + orderId + ' for user ' + userId);

  const curPurchaseDate = snap.get('date').toDate();
  console.log(curPurchaseDate);
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

