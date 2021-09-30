import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uchiha_saving/models/category.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/models/spend.dart';
import 'package:uchiha_saving/pages/transaction_page/add_transaction_ui.dart';
import 'package:uchiha_saving/tools/custom_navigator.dart';
import 'package:uchiha_saving/tools/get_random_color.dart';

class TransactionPage extends StatelessWidget {
  final Person person;
  const TransactionPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseFirestore.instance
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
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
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
                List<Spend> _list = snapshot.data!.docs
                    .map((e) => Spend.fromDynamic(e))
                    .toList();
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, i) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        leading: Icon(_list[i].category.iconData),
                        isThreeLine: true,
                        dense: true,
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(
                          _list[i].title,
                          style: GoogleFonts.lato(
                            fontSize: _size.height * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Intl().date('MMM dd', 'en_US').format(
                                    _list[i].createdAt.toDate(),
                                  ),
                              style: GoogleFonts.lato(
                                fontSize: _size.height * 0.022,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _list[i].description,
                              style: GoogleFonts.lato(
                                fontSize: _size.height * 0.022,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        trailing: Text(
                          _list[i].spendType == 1
                              ? "+ "
                              : "- " +
                                  "\$${_list[i].amount.toStringAsFixed(2)}",
                          style: GoogleFonts.lato(
                            fontSize: _size.height * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }, childCount: _list.length),
                );
              }),
        ],
      ),
    );
  }
}
