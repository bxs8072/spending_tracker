import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uchiha_saving/api/auth.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/pages/articles_page/articles_page.dart';
import 'package:uchiha_saving/pages/dashboard/dashboard.dart';
import 'package:uchiha_saving/pages/profile_page/profile_page.dart';
import 'package:uchiha_saving/pages/savings_page/savings_page.dart';
import 'package:uchiha_saving/pages/transaction_page/transaction_page.dart';
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

  List<Widget> pages(Person person) => [
        Dashboard(person: person, key: widget.key),
        TransactionPage(person: person, key: widget.key),
        ArticlesPage(person: person, key: widget.key),
        SavingsPage(person: person, key: widget.key),
        ProfilePage(person: person, key: widget.key),
      ];

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
        } else {
          if (!snapshot.data!.exists) {
            return CreateAccountScreen(key: widget.key, person: widget.person);
          } else {
            Person _person = Person.fromDocumentSnapshot(snapshot.data!);
            return Scaffold(
              body: pages(_person)[_index],
              bottomNavigationBar: BottomNavigationBar(
                items: bottomNavigationBarList,
                currentIndex: _index,
                selectedItemColor: selectedColor(context),
                elevation: 20,
                type: BottomNavigationBarType.shifting,
                unselectedItemColor: Colors.grey,
                onTap: (index) {
                  setState(() {
                    _index = index;
                  });
                },
              ),
            );
          }
        }
      },
    );
  }
}
