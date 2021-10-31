const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.onCreateTransaction = functions.firestore
    .document("/Transactions/{userId}/Transactions/{transactionId}")
    .onCreate(async (snapshot, context) => {
        console.log("Transaction Created", snapshot.id);
        const userId = context.params.userId;
        const transactionId = context.params.transactionId;

        const userRef = admin.firestore()
            .collection("Users")
            .doc(userId);

        const transactionRef = admin.firestore()
            .collection("Transactions")
            .doc(userId)
            .collection("Transactions")
            .doc(transactionId);

        const transactionDocSnapshot = await transactionRef.get();
        const userDocSnapshot = await userRef.get();

        let transaction = transactionDocSnapshot.data();
        let user = userDocSnapshot.data();

        if (transaction.transactionType == "expense") {
            userRef.update({
                balance: user.balance - transaction.amount,
            });
        } else {
            userRef.update({
                balance: user.balance + transaction.amount,
            });
        }

    });

exports.onUpdateTransaction = functions.firestore
    .document("/Transactions/{userId}/Transactions/{transactionId}")
    .onUpdate(async (change, context) => {
        const userId = context.params.userId;

        const transactionId = context.params.transactionId;
        console.log("Transaction Update", transactionId);

        const transactionBefore = change.before.data();
        const transactionAfter = change.after.data();

        const userRef = admin.firestore()
            .collection("Users")
            .doc(userId);


        const userDocSnapshot = await userRef.get();

        let user = userDocSnapshot.data();

        if (transactionBefore.transactionType == "expense" && transactionAfter.transactionType == "income") {
            userRef.update({
                balance: user.balance + transactionAfter.amount,
            });
        } else if (transactionBefore.transactionType == "income" && transactionAfter.transactionType == "expense") {
            userRef.update({
                balance: user.balance - transactionAfter.amount,
            });
        }

        if (transactionBefore.amount != transactionAfter.amount) {
            userRef.update({
                balance: user.balance + transactionBefore.amount - transactionAfter.amount,
                //5000 + 500 - 700 if after > before
                //5000 + 500 -300
            });
        }
    });

exports.onDeleteTransaction = functions.firestore
    .document("/Transactions/{userId}/Transactions/{transactionId}")
    .onUpdate(async (snapshot, context) => {
        console.log("Transaction Deleted", snapshot.id);
        const userId = context.params.userId;
        const transactionId = context.params.transactionId;

        const userRef = admin.firestore()
            .collection("Users")
            .doc(userId);

        const transactionRef = admin.firestore()
            .collection("Transactions")
            .doc(userId)
            .collection("Transactions")
            .doc(transactionId);

        const transactionDocSnapshot = await transactionRef.get();
        const userDocSnapshot = await userRef.get();

        let transaction = transactionDocSnapshot.data();
        let user = userDocSnapshot.data();

        if (transaction.transactionType == "expense") {
            userRef.update({
                balance: user.balance + transaction.amount,
            });
        } else {
            userRef.update({
                balance: user.balance - transaction.amount,
            });
        }

    });


exports.onUserUpdate = functions.firestore
    .document("/Users/{userId}")
    .onUpdate(async (change, context) => {
        const userId = context.params.userId;
        console.log("Balance Update", userId);

        const userAfter = change.after.data();


        // See documentation on defining a message payload.
        const userRef = await admin.firestore()
            .collection("Users")
            .doc(userId).get();

        const androidNotificationToken = userRef.data().androidNotificationToken;

        const message = {
            notification: {
                title: "Low Balance",
                body: "Your balance is below $200",
            },
            token: androidNotificationToken,
            data: {
                title: "Low Balance",
                body: "Your balance is below $200",
            }
        };

        if (userAfter.balance < 200.00) {
            admin.messaging().send(message)
                .then((response) => {
                    console.log(message)
                    admin.firestore().collection("Notifications").doc().set({
                        title: "Low Balance",
                        content: "Your balance is below $200",
                    });


                    console.log('Successfully sent message:', response);
                })
                .catch((error) => {
                    console.log('Error sending message:', error);
                })
        }

    });