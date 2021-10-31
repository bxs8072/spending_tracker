import 'package:cloud_firestore/cloud_firestore.dart' as fr;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/models/transaction.dart';
import 'package:uchiha_saving/pages/transaction_page/bloc/transaction_page_bloc.dart';
import 'package:uchiha_saving/pages/transaction_page/bloc/transaction_page_model.dart';
import 'package:uchiha_saving/pages/transaction_page/components/transaction_page_categories_picker.dart';
import 'package:uchiha_saving/pages/transaction_page/components/transaction_page_date_picker.dart';
import 'package:uchiha_saving/pages/transaction_page/select_category_ui.dart';
import 'package:uchiha_saving/pages/transaction_page/transaction_builder.dart';
import 'package:uchiha_saving/tools/custom_navigator.dart';
import 'package:uchiha_saving/uis/chart_ui/chart_ui.dart';
import 'package:uchiha_saving/uis/transactions_search_ui/transactions_search_ui.dart';

// ignore: must_be_immutable
class TransactionPage extends StatelessWidget {
  final Person person;
  TransactionPage({Key? key, required this.person}) : super(key: key);

  TransactionPageBloc _bloc = TransactionPageBloc();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: StreamBuilder<TransactionPageModel>(
          initialData: TransactionPageModel(
            startDate: DateTime(DateTime.now().year, DateTime.now().month),
            endDate: DateTime.now(),
          ),
          stream: _bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  customNavigator(
                    context,
                    SelectCategoryUI(person: person),
                  );
                },
                backgroundColor:
                    ThemeProvider.controllerOf(context).currentThemeId == "dark"
                        ? Colors.white
                        : Colors.black,
                child: Icon(Icons.add,
                    color: ThemeProvider.controllerOf(context).currentThemeId ==
                            "dark"
                        ? Colors.black
                        : Colors.white),
              ),
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    title: Text(
                      "Transactions",
                    ),
                    expandedHeight: MediaQuery.of(context).size.height * 0.1,
                    backgroundColor: Colors.transparent,
                    foregroundColor:
                        ThemeProvider.controllerOf(context).currentThemeId ==
                                "dark"
                            ? Colors.white
                            : Colors.black,
                    actions: [
                      IconButton(
                        onPressed: () {
                          customNavigator(
                            context,
                            TransactionSearchUI(person: person),
                          );
                        },
                        icon: Icon(
                          Icons.search,
                          size: MediaQuery.of(context).size.height * 0.04,
                        ),
                      ),
                    ],
                  ),

                  // SliverToBoxAdapter(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return ChartUI(
                  //           person: person,
                  //           key: key,
                  //         );
                  //       }));
                  //     },
                  //     child: Card(
                  //       child: Container(
                  //         height: _size.height * 0.3,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  SliverToBoxAdapter(child: SizedBox(height: 15)),
                  StreamBuilder<fr.QuerySnapshot>(
                      stream: snapshot.data!.category?.title == ""
                          ? fr.FirebaseFirestore.instance
                              .collection("Transactions")
                              .doc(person.id)
                              .collection("Transactions")
                              .where("createdAt",
                                  isGreaterThanOrEqualTo: fr.Timestamp.fromDate(
                                      snapshot.data!.startDate!))
                              .where("createdAt",
                                  isLessThanOrEqualTo: fr.Timestamp.fromDate(
                                      DateTime(
                                          snapshot.data!.endDate!.year,
                                          snapshot.data!.endDate!.month,
                                          snapshot.data!.endDate!.day + 1)))
                              .orderBy("createdAt", descending: true)
                              .snapshots()
                          : fr.FirebaseFirestore.instance
                              .collection("Transactions")
                              .doc(person.id)
                              .collection("Transactions")
                              .where("createdAt",
                                  isGreaterThanOrEqualTo: fr.Timestamp.fromDate(
                                      snapshot.data!.startDate!))
                              .where("createdAt",
                                  isLessThanOrEqualTo: fr.Timestamp.fromDate(
                                      DateTime(snapshot.data!.endDate!.year, snapshot.data!.endDate!.month, snapshot.data!.endDate!.day + 1)))
                              .where("category.title", isEqualTo: snapshot.data!.category?.title)
                              .orderBy("createdAt", descending: true)
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
                        if (_list.isEmpty) {
                          return SliverToBoxAdapter(
                              child: Center(
                            child: Column(
                              children: [
                                SizedBox(height: _size.height * 0.2),
                                Text(
                                  "Cannot find any transactions\n😐😐😐",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    fontSize: _size.height * 0.023,
                                  ),
                                ),
                              ],
                            ),
                          ));
                        }

                        return TransactionBuilder(
                          person: person,
                          transactionList: _list,
                          transactionIdList:
                              snapshot.data!.docs.map((e) => e.id).toList(),
                          key: key,
                        );
                      }), //
                ],
              ),
              bottomNavigationBar: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverToBoxAdapter(
                        child: TransactionPageDatePicker(
                            person: person,
                            transactionPageModel: snapshot.data!,
                            bloc: _bloc),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 15)),
                      TransactionPageCategoriesPicker(
                          person: person,
                          transactionPageModel: snapshot.data!,
                          bloc: _bloc),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
