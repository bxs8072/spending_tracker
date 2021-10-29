const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

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
        console.log("Transaction Update", snapshot.id);
        const userId = context.params.userId;
        const transactionId = context.params.transactionId;

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


// exports.onCreateFollower = functions.firestore
//     .document("/Followers/{userId}/Followers/{followerId}")
//     .onCreate(async (snapshot, context) => {
//         console.log("Follower Created", snapshot.id);
//         const userId = context.params.userId;
//         const followerId = context.params.followerId;

//         // 1) Create followed users posts ref
//         const followedUserPostsRef = admin
//             .firestore()
//             .collection("Posts")
//             .doc(userId)
//             .collection("userPosts");

//         // 2) Create following user's timeline ref
//         const timelinePostsRef = admin
//             .firestore()
//             .collection("Timeline")
//             .doc(followerId)
//             .collection("timelinePosts");

//         // 3) Get followed users posts
//         const querySnapshot = await followedUserPostsRef.get();

//         // 4) Add each user post to following user's timeline
//         querySnapshot.forEach(doc => {
//             if (doc.exists) {
//                 const postId = doc.id;
//                 const postData = doc.data();
//                 timelinePostsRef.doc(postId).set(postData);
//             }
//         });
//     });

// exports.onDeleteFollower = functions.firestore
//     .document("/Followers/{userId}/Followers/{followerId}")
//     .onDelete(async (snapshot, context) => {
//         console.log("Follower Deleted", snapshot.id);

//         const userId = context.params.userId;
//         const followerId = context.params.followerId;

//         const timelinePostsRef = admin
//             .firestore()
//             .collection("Timeline")
//             .doc(followerId)
//             .collection("timelinePosts")
//             .where("user.uid", "==", userId);

//         const querySnapshot = await timelinePostsRef.get();
//         querySnapshot.forEach(doc => {
//             if (doc.exists) {
//                 doc.ref.delete();
//             }
//         });
//     });

// // when a post is created, add post to timeline of each follower (of post owner)
// exports.onCreatePost = functions.firestore
//     .document("/Posts/{userId}/userPosts/{postId}")
//     .onCreate(async (snapshot, context) => {
//         const postCreated = snapshot.data();
//         const userId = context.params.userId;
//         const postId = context.params.postId;

//         // 1) Get all the followers of the user who made the post
//         const userFollowersRef = admin
//             .firestore()
//             .collection("Followers")
//             .doc(userId)
//             .collection("Followers");

//         const querySnapshot = await userFollowersRef.get();
//         // 2) Add new post to each follower's timeline
//         querySnapshot.forEach(doc => {
//             const followerId = doc.id;

//             admin
//                 .firestore()
//                 .collection("Timeline")
//                 .doc(followerId)
//                 .collection("timelinePosts")
//                 .doc(postId)
//                 .set(postCreated);
//         });
//     });

// exports.onUpdatePost = functions.firestore
//     .document("/Posts/{userId}/userPosts/{postId}")
//     .onUpdate(async (change, context) => {
//         const postUpdated = change.after.data();
//         const userId = context.params.userId;
//         const postId = context.params.postId;

//         // 1) Get all the followers of the user who made the post
//         const userFollowersRef = admin
//             .firestore()
//             .collection("Followers")
//             .doc(userId)
//             .collection("Followers");

//         const querySnapshot = await userFollowersRef.get();
//         // 2) Update each post in each follower's timeline
//         querySnapshot.forEach(doc => {
//             const followerId = doc.id;

//             admin
//                 .firestore()
//                 .collection("Timeline")
//                 .doc(followerId)
//                 .collection("timelinePosts")
//                 .doc(postId)
//                 .get()
//                 .then(doc => {
//                     if (doc.exists) {
//                         doc.ref.update(postUpdated);
//                     }
//                 });
//         });
//     });

// exports.onDeletePost = functions.firestore
//     .document("/Posts/{userId}/userPosts/{postId}")
//     .onDelete(async (snapshot, context) => {
//         const userId = context.params.userId;
//         const postId = context.params.postId;

//         // 1) Get all the followers of the user who made the post
//         const userFollowersRef = admin
//             .firestore()
//             .collection("Followers")
//             .doc(userId)
//             .collection("Followers");

//         const querySnapshot = await userFollowersRef.get();
//         // 2) Delete each post in each follower's timeline
//         querySnapshot.forEach(doc => {
//             const followerId = doc.id;

//             admin
//                 .firestore()
//                 .collection("Timeline")
//                 .doc(followerId)
//                 .collection("timelinePosts")
//                 .doc(postId)
//                 .get()
//                 .then(doc => {
//                     if (doc.exists) {
//                         doc.ref.delete();
//                     }
//                 });
//         });
//     });


// exports.onCreateNotification = functions.firestore
//     .document("/Notifications/{userId}/Notifications/{activityFeedItem}")
//     .onCreate(async (snapshot, context) => {
//         console.log("Activity Feed Item Created", snapshot.data());

//         // 1) Get user connected to the feed
//         const userId = context.params.userId;

//         const userRef = admin.firestore().doc(`Users/${userId}`);
//         const doc = await userRef.get();

//         // 2) Once we have user, check if they have a notification token; send notification, if they have a token
//         const androidNotificationToken = doc.data().androidNotificationToken;
//         const createdActivityFeedItem = snapshot.data();
//         if (androidNotificationToken) {
//             sendNotification(androidNotificationToken, createdActivityFeedItem);
//         } else {
//             console.log("No token for user, cannot send notification");
//         }

//         function sendNotification(androidNotificationToken, activityFeedItem) {
//             let body;

//             // 3) switch body value based off of notification type
//             switch (activityFeedItem.type) {
//                 case "comment":
//                     body = `${activityFeedItem.userWhoLike.username} replied: ${activityFeedItem.commentData
//                         }`;
//                     break;
//                 case "like":
//                     body = `${activityFeedItem.userWhoLike.username} liked your post`;
//                     break;
//                 case "following":
//                     body = `${activityFeedItem.userWhoLike.username} started following you`;
//                     break;
//                 default:
//                     break;
//             }

//             // 4) Create message for push notification
//             const message = {
//                 notification: { body },
//                 token: androidNotificationToken,
//                 data: { recipient: userId }
//             };

//             // 5) Send message with admin.messaging()
//             admin
//                 .messaging()
//                 .send(message)
//                 .then(response => {
//                     // Response is a message ID string
//                     console.log("Successfully sent message", response);
//                 })
//                 .catch(error => {
//                     console.log("Error sending message", error);
//                 });
//         }
//     });