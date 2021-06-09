const functions = require('firebase-functions');
const bodyParser = require('body-parser');
const cors = require('cors');
const express = require('express');
const admin = require('firebase-admin');
const { debug } = require('firebase-functions/lib/logger');
admin.initializeApp();

const stripe = require('stripe')(functions.config().stripe.secret);
const stripeTest = require('stripe')(functions.config().stripe_test.secret);

//=================================================================================
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

function generateCheckoutItem(priceId, itemQuantity) {
  return {
    price: priceId,
    quantity: itemQuantity,
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

  var docID_list = [];
  var quantity_list = [];
  var req_data = JSON.parse(req.body);

  req_data.items.forEach(item => {
    docID_list.push(item.docID);
    quantity_list.push(item.quantity);
  });


  admin.firestore().collection("products").where(admin.firestore.FieldPath.documentId(), 'in', docID_list).get().then(snapshot => {
    console.log("firestore retrieved");
    
    var line_item_list = [];
    
    var counter = 0;
    snapshot.forEach(doc => {
      counter = counter + 1;
      var priceId = String(doc.get('onetimePriceId')); 
      line_item_list.push(generateCheckoutItem(priceId, 1));
    });

    var projectId;
    if (req_data.projectName != null) {
      projectId = String(req_data.projectName);
    } else {
      projectId = "deprecated app";
    }

    
    return stripe.checkout.sessions.create({
        payment_intent_data: {
          setup_future_usage: 'off_session',
        },
        client_reference_id: projectId,
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



//=================================================================================

const payment_1_1 = express();
payment_1_1.use(bodyParser.json());
payment_1_1.use(cors({ origin: true }));


payment_1_1.post('/', async (req, res) => {

  var docID_list = [];
  var quantity_list = [];
  var req_data = JSON.parse(req.body);

  req_data.items.forEach(item => {
    docID_list.push(item.docID);
    quantity_list.push(item.quantity);
  });

  const totalPurchaseTrees = req_data.totalTrees;
  const totalPurchaseCoins = req_data.totalCoins;
  const userIdTemp = req_data.userId;
  const paymentMode = req_data.mode;


  admin.firestore().collection("products").where(admin.firestore.FieldPath.documentId(), 'in', docID_list).get().then(snapshot => {
    console.log("firestore retrieved");
    
    var line_item_list = [];
    
    var counter = 0;
    snapshot.forEach(doc => {
      counter = counter + 1;
      var priceId = String(doc.get('onetimePriceId')); 
      line_item_list.push(generateCheckoutItem(priceId, 1));
    });

    var projectId;
    if (req_data.projectName != null) {
      projectId = String(req_data.projectName);
    } else {
      projectId = "deprecated app";
    }

    
    return stripe.checkout.sessions.create({
        payment_intent_data: {
          setup_future_usage: 'off_session',
        },
        client_reference_id: projectId,
        payment_method_types: ['card'],
        line_items: line_item_list,
        mode:'payment',
        payment_intent_data: {
          metadata: {
            totalTrees: totalPurchaseTrees,
            totalCoins: totalPurchaseCoins,
            userId: userIdTemp,
            mode: paymentMode
          },
        },
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



//=================================================================================

const existingCustomerSub_1_1 = express();
existingCustomerSub_1_1.use(bodyParser.json());
existingCustomerSub_1_1.use(cors({ origin: true }));


existingCustomerSub_1_1.post('/', async (req, res) => {
  var docID_list = [];
  var quantity_list = [];
  
  var req_data = JSON.parse(req.body);

  req_data.items.forEach(item => {
    docID_list.push(item.docID);
    quantity_list.push(item.quantity);
  });

  var customerIdClient = String(req_data.customerIdClient);
  const totalPurchaseCoins = req_data.totalCoins;
  const totalPurchaseTrees = req_data.totalTrees;
  const userIdTemp = req_data.userId;
  const paymentMode = req_data.mode;
  console.log("customer id is ========= " + customerIdClient);



  admin.firestore().collection("products").where(admin.firestore.FieldPath.documentId(), 'in', docID_list).get().then(snapshot => {
    console.log("firestore retrieved");
    
    var line_item_list = [];
    
    var counter = 0;
    snapshot.forEach(doc => {
      counter = counter + 1;
      var priceId = String(doc.get('monthlyPriceId'));
      line_item_list.push(generateCheckoutItem(priceId, 1));
    });

    var projectIdClient;
    if (req_data.projectId != null) {
      projectIdClient = String(req_data.projectId);
    } else {
      projectIdClient = "deprecated app";
    }

    var projectTitleClient;
    if (req_data.projectTitle != null) {
      projectTitleClient = String(req_data.projectTitle);
    } else {
      projectTitleClient = "deprecated app";
    }

    console.log("name ===== " + projectTitleClient);
    
    

    stripe.checkout.sessions.create({
      subscription_data:{
        metadata: 
        {
          projectId : projectIdClient,
          projectTitle: projectTitleClient,
          totalTrees: totalPurchaseTrees,
          totalCoins: totalPurchaseCoins,
          userId: userIdTemp,
          mode: paymentMode
        },
      },
      payment_method_types: ['card'],
      line_items: line_item_list,
      customer: customerIdClient,
      mode:'subscription',
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


//=================================================================================

const newCustomerSub_1_1 = express();
newCustomerSub_1_1.use(bodyParser.json());
newCustomerSub_1_1.use(cors({ origin: true }));


newCustomerSub_1_1.post('/', async (req, res) => {

  var docID_list = [];
  var quantity_list = [];
  var req_data = JSON.parse(req.body);

  

  req_data.items.forEach(item => {
    docID_list.push(item.docID);
    quantity_list.push(item.quantity);
  });

  var userIdTemp = String(req_data.userId);
  const totalPurchaseTrees = req_data.totalTrees;
  const totalPurchaseCoins = req_data.totalCoins;
  const paymentMode = req_data.mode;

  console.log("user id is ========= " + req_data.userId);


  admin.firestore().collection("products").where(admin.firestore.FieldPath.documentId(), 'in', docID_list).get().then(snapshot => {
    //console.log(snapshot.get("price"));
    console.log("firestore retrieved");
    
    var line_item_list = [];
    
    var counter = 0;
    snapshot.forEach(doc => {
      counter = counter + 1;
      var priceId = String(doc.get('monthlyPriceId'));
      line_item_list.push(generateCheckoutItem(priceId, 1));
    });


    var projectIdClient;
    if (req_data.projectId != null) {
      projectIdClient = String(req_data.projectId);
    } else {
      projectIdClient = "deprecated app";
    }

    var projectTitleClient;
    if (req_data.projectTitle != null) {
      projectTitleClient = String(req_data.projectTitle);
    } else {
      projectTitleClient = "deprecated app";
    }

    console.log("name ===== " + projectTitleClient);

    
    
    return stripe.customers.create({
      description: "todo: insert more descriptive customer info here"
    }).then(customer => {
      console.log(customer.id);
      updateCustomer(customer.id, userIdTemp);
      stripe.checkout.sessions.create({
        subscription_data:{
          metadata: 
          {
            projectId : projectIdClient,
            projectTitle: projectTitleClient,
            totalTrees: totalPurchaseTrees,
            totalCoins: totalPurchaseCoins,
            userId: userIdTemp
          },
        },
        payment_method_types: ['card'],
        line_items: line_item_list,
        customer: customer.id,
        mode:'subscription',
        success_url: 'https://yoursite.com/success.html',
        cancel_url: 'https://example.com/cancel',
      }).then(session => {
        console.log(line_item_list);
        console.log("response given");
        res.json({id: session.id});        
      });
    });
  }).catch(reason =>{
    console.log(reason);
    res.send(reason);
  });
});

//=================================================================================

async function updateCustomer(_customerId, userId) {
  admin.firestore().collection('users').doc(userId).update({
    customerId: _customerId
  });
}



//=================================================================================


const getSubscriptionList = express();
getSubscriptionList.use(bodyParser.json());
getSubscriptionList.use(cors({ origin: true }));


getSubscriptionList.post('/', async (req, res) => {
  var req_data = JSON.parse(req.body);
  //var req_data = JSON.parse(req.body);
  var customerIdClient = String(req_data.customerIdClient);
  console.log(customerIdClient);

  return stripe.subscriptions.list(
    {
      customer: customerIdClient
    }).then(subList => {
      res.json(subList);
  }).catch(reason =>{
    console.log(reason);
    res.send(reason);
  });
});


//=================================================================================
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

//=================================================================================
const listUserSubscriptions = express();
listUserSubscriptions.use(bodyParser.json());
listUserSubscriptions.use(cors({ origin: true }));


listUserSubscriptions.post('/', async (req, res) => {
  return stripe.subscriptions.list({
    customer: req.customerId
  });
});

//=================================================================================
const cancelSubscription = express();
cancelSubscription.use(bodyParser.json());
cancelSubscription.use(cors({ origin: true }));


cancelSubscription.post('/', async (req, res) => {
  var req_data = JSON.parse(req.body);
  //var req_data = JSON.parse(req.body);
  var cancelledSubId = String(req_data.cancelledSubId);
  console.log(cancelledSubId);

  return stripe.subscriptions.del(
    String(cancelledSubId)
    ).then(cancelledResponse => {
      res.json(cancelledResponse);
  }).catch(reason =>{
    console.log(reason);
    res.send(reason);
  });
});


//=================================================================================
const testPayment = express();
testPayment.use(bodyParser.json());
testPayment.use(cors({ origin: true }));


testPayment.post('/', async (req, res) => {
  var docID_list = [];
  var quantity_list = [];
  var req_data = JSON.parse(req.body);

  req_data.items.forEach(item => {
    docID_list.push(item.docID);
    quantity_list.push(item.quantity);
  });

  admin.firestore().collection("products").where(admin.firestore.FieldPath.documentId(), 'in', docID_list).get().then(snapshot => {
    console.log("firestore retrieved");
    
    var line_item_list = [];
    
    var counter = 0;
    snapshot.forEach(doc => {
      counter = counter + 1;
      var amount = String(Number.parseFloat(doc.get('price')).toFixed(2)).replace(".", "");
      var product_name = String(doc.get('imagetext'));  
      line_item_list.push(generateCartItem(product_name, amount, 1));
    });

    var projectId;
    if (req_data.projectName != null) {
      projectId = String(req_data.projectName);
    } else {
      projectId = "deprecated app";
    }

    
    return stripeTest.checkout.sessions.create({
        payment_intent_data: {
          setup_future_usage: 'off_session',
        },
        client_reference_id: projectId,
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

//=================================================================================

//To find the different in months not including days
function monthDiff(dateFrom, dateTo) {
  return dateTo.getMonth() - dateFrom.getMonth() + 
    (12 * (dateTo.getFullYear() - dateFrom.getFullYear()));
}

//=================================================================================

//This function is called whenever an order is created after a stripe payment is succesful
// note: this does not include subscriptions
exports.onOrderCreated = functions.firestore
.document('/users/{userId}/orders/{orderId}')
.onCreate((snap, context) => {

  // get information on the order and user
  const userId = context.params.userId
  const orderId = context.params.orderId

  // get the date of the purchase
  const curPurchaseDate = snap.get('date').toDate();


  return admin.firestore().collection('users').doc(userId).get().then(snapshot => {
    
    // get all the current user statistics
    const prevTotalMonths = snapshot.get('totalMonths');
    const prevConsecutiveMonths = snapshot.get('consecutiveMonths');
    const prevTotalTrees = snapshot.get('totalTrees');
    const prevTreesThisMonth = snapshot.get('treesThisMonth');

    // get the last date of purchase
    const prevPurchaseDate = snapshot.get('prevMonthOfPurchase').toDate();

    // get coin amounts
    var prevCoinsAllTime = snapshot.get('coinsAllTime');
    var prevCoinsCurrentAmount = snapshot.get('coinsCurrentAmount');
    
    console.log("status of the nan:" + isNaN(parseInt(prevCoinsAllTime)));
    if (isNaN(parseInt(prevCoinsAllTime)) || isNaN(parseInt(prevCoinsCurrentAmount))) {
      console.log("Error: Deprecated app: coins are not calculated, coin amounts will be zero");
      prevCoinsAllTime = 0;
      prevCoinsCurrentAmount = 0;
    }

    var newOrderCoinCount = snap.get('coincount');

    // If new order does not have any coin counts then set it to 0
    // in order to prevent a NaN
    if (typeof(newOrderCoinCount) === 'undefined') {
      newOrderCoinCount = 0;
    }
    

    // calculate the difference in months between last and current purchase
    const difference = monthDiff(prevPurchaseDate, curPurchaseDate);

    
    
    // CASE 1: last purchase was last month
    //    if the difference is 1 then update total stats
    //    update consecutive stats
    //    current stats get only this purchase values
    if (difference == 1) {
      return admin.firestore().collection('users').doc(userId).update({
        consecutiveMonths: prevConsecutiveMonths + 1, 
        prevMonthOfPurchase: snap.get('date'),
        totalMonths: prevTotalMonths + 1,
        treesThisMonth: snap.get('trees'),
        totalTrees: prevTotalTrees + snap.get('trees'),
        coinsAllTime: prevCoinsAllTime + newOrderCoinCount,
        coinsCurrentAmount: prevCoinsCurrentAmount + newOrderCoinCount
      });
    
    // CASE 2: last purchase was more than 1 month away
    //    if the difference is greater than 1 only update "total" stats
    //    reset consecutive stats
    //    current stats get only this purchase values
    } else if (difference > 1) {
      return admin.firestore().collection('users').doc(userId).update({
        consecutiveMonths: 1, 
        prevMonthOfPurchase: snap.get('date'),
        totalMonths: prevTotalMonths + 1,
        treesThisMonth: snap.get('trees'),
        totalTrees: prevTotalTrees + snap.get('trees'),
        coinsAllTime: prevCoinsAllTime + newOrderCoinCount,
        coinsCurrentAmount: prevCoinsCurrentAmount + newOrderCoinCount
      });

    // CASE 3: purchase is this month
    //    if the difference is 0 then update total stats
    //    keep consecutive stats
    //    current stats get updated
    } else if (difference == 0) {
      return admin.firestore().collection('users').doc(userId).update({
        prevMonthOfPurchase: snap.get('date'),
        treesThisMonth: prevTreesThisMonth + snap.get('trees'),
        totalTrees: prevTotalTrees + snap.get('trees'),
        coinsAllTime: prevCoinsAllTime + newOrderCoinCount,
        coinsCurrentAmount: prevCoinsCurrentAmount + newOrderCoinCount
      });
    }
  });
  console.log(snapshot.data());
  
});

//=================================================================================

const endpoint = express();
endpoint.use(bodyParser.json());
endpoint.use(cors({ origin: true }));

endpoint.post('/', (req, res) => {
  req_data = JSON.parse(req.rawBody.toString());
  console.log("TOTAL TREES: " + req_data.data.object.metadata.totalTrees);
  console.log("TOTAL COINS: " + req_data.data.object.metadata.totalCoins);
  console.log("USER ID: " + req_data.data.object.metadata.userId);

  var description = req_data.data.object.description;

  if (description == "Subscription update") {
    return res.send();
  }

  
  var totalTrees = req_data.data.object.metadata.totalTrees;
  var totalCoins = req_data.data.object.metadata.totalCoins;
  var userId = req_data.data.object.metadata.userId;
  var paymentDate = admin.firestore.Timestamp.fromDate(new Date());
  
  if (typeof(totalCoins) === 'undefined') {
    return res.send();
  }

  var subscriptionOrder = {
    coincount: Number.parseInt(totalCoins),
    trees: Number.parseFloat(totalTrees),
    date: paymentDate,
    paymentType: "onetime"
  };

  return admin.firestore().collection('users').doc(userId).collection('orders').add(subscriptionOrder).then(oki => {res.send();});
  
});



//=================================================================================


const subscriptionEndpoint = express();
subscriptionEndpoint.use(bodyParser.json());
subscriptionEndpoint.use(cors({ origin: true }));

subscriptionEndpoint.post('/', (req, res) => {
  req_data = JSON.parse(req.rawBody.toString());
  console.log("TOTAL TREES: " + req_data.data.object.lines.data[0].metadata.totalTrees);
  console.log("TOTAL COINS: " + req_data.data.object.lines.data[0].metadata.totalCoins);
  console.log("USER ID: " + req_data.data.object.lines.data[0].metadata.userId);

  var totalTrees = req_data.data.object.lines.data[0].metadata.totalTrees;
  var totalCoins = req_data.data.object.lines.data[0].metadata.totalCoins;
  var userId = req_data.data.object.lines.data[0].metadata.userId;
  var paymentDate = admin.firestore.Timestamp.fromDate(new Date());

  if (typeof(totalCoins) === 'undefined') {
    return res.send();
  }

  var subscriptionOrder = {
    coincount: Number.parseInt(totalCoins),
    trees: Number.parseFloat(totalTrees),
    date: paymentDate,
    paymentType: "subscription"
  };

  return admin.firestore().collection('users').doc(userId).collection('orders').add(subscriptionOrder).then(oki => {res.send();});
});

//=================================================================================

const getCards = express();
getCards.use(bodyParser.json());
getCards.use(cors({ origin: true }));

getCards.post('/', (req, res) => {
  var req_data = JSON.parse(req.body);
  var userId = req_data.userId;
  console.log("userId is: " + userId);
  
  var cardList = {
  }
  
  userCardArr = [];
  finalCardArr = [];
  
  var curDate = new Date();
  var curYear = curDate.getFullYear();
  var curMonth = curDate.getMonth() + 1;
  
  
  var key = curYear.toString() + curMonth.toString().padStart(2, '0');
  
  return admin.firestore().collection("users").doc(userId).collection("cards").doc(key).get().then(snapshot => {
    var ex = snapshot.data();
    
    
    for (var userkey in ex) {
      var cardObject = ex[userkey]
      var entry = {
        category: userkey,
        date: (cardObject["date"]).toDate(),
      }
      userCardArr.push(entry);
    }
    
    //console.log("key is: " + key);
    return admin.firestore().collection("cards").doc(key).get().then(snapshot2 => {
      var ex2 = snapshot2.data();
      //console.log(ex2);
      var unlockedIndexes = new Map();
      var metadataUserCardDb = ex2["metadata"];
      
      // numKeys is not including metadata so it's minus 1
      // TODO: need to determine if this value should be set in metadata
      // I think that should be done when we have json auto gen scripts
      // to upload the cards to the database
      var numKeys = Object.keys(ex2).length - 1;
      
      for (var i = 1; i <= numKeys; i++) {
        unlockedIndexes.set(i, false);
      }
      
      for (var i = 0; i < userCardArr.length; i++) {
        var cardKey = userCardArr[i]["category"];
        var cardObject = ex2[cardKey];
        unlockedIndexes.set(parseInt(cardObject["cardIndex"]), true);
        var entry = {
          imageLink: cardObject["imageLink"],
          date: userCardArr[i]["date"],
          extraInfo: cardObject["extraInfo"],
          description: cardObject["description"],
          cardIndex: cardObject["cardIndex"]
        }
        finalCardArr.push(entry);
      }
      
      // for (let [key, value] of unlockedIndexes.entries()) {
        //   console.log(key + ' = ' + value)
        // }
        
        for (var i = 1; i <= numKeys; i++) {
          if (!unlockedIndexes.get(i)) {
            var entry = {
              imageLink: "empty",
              date: new Date(0, 0, 0, 0, 0, 0, 0),
              extraInfo: "empty",
              description: "empty",
              cardIndex: i
            }
            finalCardArr.push(entry);
          }
        }
        
        //console.log("number of keys are: " + numKeys);
        //console.log(finalCardArr);
        res.send(
          {
            cardList:finalCardArr,
            totalCards:numKeys,
            metadata:metadataUserCardDb
          }
          );
        });
        //console.log(ex);
      }).catch(reason =>  {
        console.log(reason);
        res.send(reason);
      });
    });
    
    
    
//=================================================================================
    
const testCards = express();
testCards.use(bodyParser.json());
testCards.use(cors({ origin: true }));

testCards.post('/', (req, res) => {
  //var req_data = JSON.parse(req.body);
  //var userId = req.body.userId;
  var cardList = {
  }
  
  card_arr = [];
  
  var curDate = new Date();
  var curYear = curDate.getFullYear();
  var curMonth = curDate.getMonth() + 1;
  
  var key = curYear.toString() + curMonth.toString().padStart(2, '0');
  
  return admin.firestore().collection("cards").doc(key).get().then(snapshot => {
    //var ex = (snapshot.data()["Air Travel (round trip)"]["date"]).toDate();
    var ex = snapshot.data();
    
    for (var key in ex) {
      if (key.toString() != "metadata"){
        var cardObject = ex[key]
        var entry = {
          imageLink: cardObject["imageLink"],
          date: (cardObject["date"]).toDate(),
          extraInfo: cardObject["extraInfo"],
          description: cardObject["description"],
          cardIndex: cardObject["cardIndex"]
        }
        card_arr.push(entry);
      }
    }
    //console.log(ex);
    res.send({cardList:card_arr});
  }).catch(reason => {
    console.log(reason);
    res.send(reason);
  });
  
});
    
    
//=================================================================================    
const cardActivation = express();
cardActivation.use(bodyParser.json());
cardActivation.use(cors({ origin: true }));

cardActivation.post('/', (req, res) => {
  req_data = JSON.parse(req.rawBody.toString());  
  var cardList = {
  }
  
  card_arr = [];
  
  var curDate = new Date();
  var curYear = curDate.getFullYear();
  var curMonth = curDate.getMonth() + 1;
  
  var key = curYear.toString() + curMonth.toString().padStart(2, '0');
  
  return admin.firestore().collection("cards").doc(key).get().then(snapshot => {
    //var ex = (snapshot.data()["Air Travel (round trip)"]["date"]).toDate();
    var ex = snapshot.data();
    
    for (var key in ex) {
      console.log(key);
      if (key != "metadata"){
        var cardObject = ex[key]
        var entry = {
          imageLink: cardObject["imageLink"],
          date: (cardObject["date"]).toDate(),
          extraInfo: cardObject["extraInfo"],
          description: cardObject["description"],
          cardIndex: cardObject["cardIndex"]
        }
        card_arr.push(entry);
        
      }
    }
    //console.log(ex);
    res.send({cardList:card_arr});
  }).catch(reason => {
    console.log(reason);
    res.send(reason);
  });
  
});

//=================================================================================

exports.cardActivation = functions.https.onRequest(cardActivation);
exports.testPayment = functions.https.onRequest(testPayment);
exports.customer_creation = functions.https.onRequest(customer_creation);
exports.test = functions.https.onRequest(test);
exports.payment = functions.https.onRequest(app);
exports.existingCustomerSub_1_1 = functions.https.onRequest(existingCustomerSub_1_1);
exports.newCustomerSub_1_1 = functions.https.onRequest(newCustomerSub_1_1);
exports.getSubscriptionList = functions.https.onRequest(getSubscriptionList);
exports.listUserSubscriptions = functions.https.onRequest(listUserSubscriptions);
exports.cancelSubscription = functions.https.onRequest(cancelSubscription);
exports.payment_1_1 = functions.https.onRequest(payment_1_1);
exports.testCards = functions.https.onRequest(testCards);
exports.subscriptionEndpoint = functions.https.onRequest(subscriptionEndpoint);
exports.endpoint = functions.https.onRequest(endpoint);
exports.getCards = functions.https.onRequest(getCards);