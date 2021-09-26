import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/screens/create_account_screen/create_account_screen.dart';
import 'package:uchiha_saving/screens/home_screen/components/bottom_navigation_bar_item_list.dart';

class HomeScreen extends StatefulWidget {
  final Person person;
  const HomeScreen({Key? key, required this.person}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
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
          return CreateAccountScreen(key: widget.key, person: widget.person);
        } else {
          return Scaffold(
            body: Center(
              child: Text("Account Found"),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavigationBarList,
              currentIndex: _index,
              selectedItemColor: selectedColor(_index),
              elevation: 20,
              type: BottomNavigationBarType.shifting,
              onTap: (index) {
                setState(() {
                  _index = index;
                });
              },
            ),
          );
        }
      },
    );
  }
}
