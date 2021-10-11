import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:uchiha_saving/models/category.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/pages/transaction_page/bloc/transaction_page_bloc.dart';
import 'package:uchiha_saving/pages/transaction_page/bloc/transaction_page_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fr;

class TransactionPageCategoriesPicker extends StatelessWidget {
  final Person person;
  final TransactionPageModel transactionPageModel;
  final TransactionPageBloc bloc;
  TransactionPageCategoriesPicker(
      {Key? key,
      required this.person,
      required this.transactionPageModel,
      required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<fr.QuerySnapshot>(
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
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: SelectFormField(
                  type: SelectFormFieldType.dropdown,
                  decoration: InputDecoration(
                    label: Text("  Category"),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    suffix: IconButton(
                      onPressed: () {
                        bloc.update(
                          startDate: transactionPageModel.startDate,
                          endDate: transactionPageModel.endDate,
                          category:
                              Category(iconData: Icons.ac_unit, title: ""),
                        );
                      },
                      icon: Icon(
                        Icons.clear,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    // isDense: true,
                    isCollapsed: true,
                    border: OutlineInputBorder(),
                  ),
                  items: _catList
                      .map((e) => <String, dynamic>{
                            "value": json.encode(e.toMap),
                            "label": e.title,
                            "icon": Icon(e.iconData),
                          })
                      .toList(),
                  onChanged: (val) {
                    bloc.update(
                      startDate: transactionPageModel.startDate,
                      endDate: transactionPageModel.endDate,
                      category: Category.fromDynamic(
                        json.decode(val),
                      ),
                    );
                  },
                  onSaved: (val) {
                    bloc.update(
                      startDate: transactionPageModel.startDate,
                      endDate: transactionPageModel.endDate,
                      category: Category.fromDynamic(
                        json.decode(val!),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        });
  }
}
