import 'package:flutter/material.dart';
import 'package:uchiha_saving/models/category.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fr;
import 'package:uchiha_saving/pages/dashboard/components/add_balance_ui.dart';
import 'package:uchiha_saving/pages/transaction_page/add_transaction_ui.dart';
import 'package:uchiha_saving/tools/custom_navigator.dart';

class SelectCategoryAddBalanceUI extends StatelessWidget {
  final Person person;
  const SelectCategoryAddBalanceUI({Key? key, required this.person})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<fr.QuerySnapshot>(
          stream: fr.FirebaseFirestore.instance
              .collection("Categories")
              .doc(person.id)
              .collection("Categories")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Category> _items = snapshot.data!.docs
                .map((e) => Category.fromDocumentSnapshot(e))
                .toList();
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text("Select Category"),
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      return ListTile(
                        leading: Icon(_items[i].iconData),
                        title: Text(_items[i].title),
                        onTap: () {
                          customNavigatorAndReplace(
                              context,
                              AddBalanceUI(
                                person: person,
                                category: _items[i],
                              ));
                        },
                      );
                    },
                    childCount: _items.length,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
