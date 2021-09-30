import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart' as fr;
import 'package:flutter/material.dart';
import 'package:uchiha_saving/models/category.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/models/transaction.dart';
import 'package:uchiha_saving/pages/transaction_page/add_transaction_ui.dart';
import 'package:uchiha_saving/pages/transaction_page/bloc/transaction_page_bloc.dart';
import 'package:uchiha_saving/pages/transaction_page/bloc/transaction_page_model.dart';
import 'package:uchiha_saving/pages/transaction_page/transaction_builder.dart';
import 'package:uchiha_saving/tools/custom_navigator.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:select_form_field/select_form_field.dart';

// ignore: must_be_immutable
class TransactionPage extends StatelessWidget {
  final Person person;
  TransactionPage({Key? key, required this.person}) : super(key: key);

  TransactionPageBloc _bloc = TransactionPageBloc();

  Category? category;

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
      body: StreamBuilder<TransactionPageModel>(
          initialData: TransactionPageModel(
            startDate: DateTime(DateTime.now().year, DateTime.now().month),
            endDate: DateTime.now(),
          ),
          stream: _bloc.stream,
          builder: (context, snapshot) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text("Transactions"),
                  pinned: true,
                ),
                StreamBuilder<fr.QuerySnapshot>(
                    stream: fr.FirebaseFirestore.instance
                        .collection("Categories")
                        .doc(person.id)
                        .collection("Categories")
                        .snapshots(),
                    builder: (context, catSnapshot) {
                      if (!catSnapshot.hasData) {
                        return SliverToBoxAdapter();
                      } else {
                        List<Category> _catList = catSnapshot.data!.docs
                            .map((e) => Category.fromDocumentSnapshot(e))
                            .toList();
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: SelectFormField(
                              type: SelectFormFieldType.dropdown,
                              labelText: "Category",
                              items: _catList
                                  .map((e) => <String, dynamic>{
                                        "value": json.encode(e.toMap),
                                        "label": e.title,
                                        "icon": Icon(e.iconData),
                                      })
                                  .toList(),
                              onChanged: (val) {
                                _bloc.update(
                                  startDate: snapshot.data?.startDate,
                                  endDate: snapshot.data?.endDate,
                                  category: Category.fromDynamic(
                                    json.decode(val),
                                  ),
                                );
                              },
                              onSaved: (val) {
                                _bloc.update(
                                  startDate: snapshot.data?.startDate,
                                  endDate: snapshot.data?.endDate,
                                  category: Category.fromDynamic(
                                    json.decode(val!),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }
                    }),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Flexible(
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DateTimePicker(
                              type: DateTimePickerType.date,
                              dateMask: 'd MMM, yyyy',
                              initialValue: snapshot.data!.startDate.toString(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                              icon: Icon(Icons.event),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                label: Text("Start Date"),
                              ),
                              onChanged: (val) {
                                _bloc.update(
                                  startDate: DateTime.parse(val),
                                  endDate: snapshot.data?.endDate,
                                  category: snapshot.data?.category,
                                );
                              },
                              validator: (val) {
                                return null;
                              },
                              onSaved: (val) {
                                _bloc.update(
                                  startDate: DateTime.parse(val!),
                                  endDate: snapshot.data?.endDate,
                                  category: snapshot.data?.category,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        child: Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DateTimePicker(
                              type: DateTimePickerType.date,
                              dateMask: 'd MMM, yyyy',
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                label: Text("End Date"),
                              ),
                              initialValue: snapshot.data!.endDate.toString(),
                              firstDate: snapshot.data!.startDate,
                              lastDate: DateTime(DateTime.now().year + 1),
                              icon: Icon(Icons.event),
                              onChanged: (val) {
                                print(val);
                                _bloc.update(
                                  endDate: DateTime.parse(val),
                                  startDate: snapshot.data?.startDate,
                                  category: snapshot.data?.category,
                                );
                              },
                              onSaved: (val) {
                                print(val);
                                _bloc.update(
                                  endDate: DateTime.parse(val!),
                                  startDate: snapshot.data?.startDate,
                                  category: snapshot.data?.category,
                                );
                              },
                              validator: (val) {
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<fr.QuerySnapshot>(
                    stream: fr.FirebaseFirestore.instance
                        .collection("Transactions")
                        .doc(person.id)
                        .collection("Transactions")
                        .where("createdAt",
                            isGreaterThanOrEqualTo: fr.Timestamp.fromDate(
                                snapshot.data!.startDate!))
                        .where("createdAt",
                            isLessThanOrEqualTo: fr.Timestamp.fromDate(DateTime(
                                snapshot.data!.endDate!.year,
                                snapshot.data!.endDate!.month,
                                snapshot.data!.endDate!.day + 1)))
                        .where("category.title",
                            isEqualTo: snapshot.data!.category?.title)
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
                      print(_list.length);
                      return TransactionBuilder(
                        person: person,
                        transactionList: _list,
                        transactionIdList:
                            snapshot.data!.docs.map((e) => e.id).toList(),
                        key: key,
                      );
                    }),
              ],
            );
          }),
    );
  }
}
