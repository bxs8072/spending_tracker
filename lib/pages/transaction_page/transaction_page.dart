import 'package:cloud_firestore/cloud_firestore.dart' as fr;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uchiha_saving/models/category.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/models/transaction.dart';
import 'package:uchiha_saving/pages/transaction_page/add_transaction_ui.dart';
import 'package:uchiha_saving/pages/transaction_page/transaction_builder.dart';
import 'package:uchiha_saving/tools/custom_navigator.dart';

class TransactionPage extends StatelessWidget {
  final Person person;
  const TransactionPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await fr.FirebaseFirestore.instance
              .collection("Categories")
              .doc(person.id)
              .collection("Categories")
              .get()
              .then((val) {
            customNavigator(
                context,
                AddTransactionsUI(
                  person: person,
                  categoryList: val.docs
                      .map((e) => Category.fromDocumentSnapshot(e))
                      .toList(),
                ));
          });
        },
        child: Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Transactions"),
            pinned: true,
          ),
          StreamBuilder<fr.QuerySnapshot>(
              stream: fr.FirebaseFirestore.instance
                  .collection("Transactions")
                  .doc(person.id)
                  .collection("Transactions")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                List<Transaction> _list = snapshot.data!.docs
                    .map((e) => Transaction.fromDynamic(e))
                    .toList();
                return TransactionBuilder(
                  person: person,
                  transactionList: _list,
                  transactionIdList:
                      snapshot.data!.docs.map((e) => e.id).toList(),
                  key: key,
                );
              }),
        ],
      ),
    );
  }
}
