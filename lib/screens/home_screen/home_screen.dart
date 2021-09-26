import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uchiha_saving/api/auth.dart';
import 'package:uchiha_saving/models/person.dart';

class HomeScreen extends StatefulWidget {
  final Person person;
  const HomeScreen({Key? key, required this.person}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Auth().signOut();

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(widget.person.id)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.data!.exists) {
          return Text("Create Account");
        } else {
          return Scaffold(
            body: Center(
              child: Text("Account Found"),
            ),
          );
        }
      },
    );
  }
}
