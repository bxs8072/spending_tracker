import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:uchiha_saving/models/category.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/pages/transaction_page/bloc/transaction_page_bloc.dart';
import 'package:uchiha_saving/pages/transaction_page/bloc/transaction_page_model.dart';
import 'package:uchiha_saving/tools/categories_list.dart';

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
                  category: Category(iconData: Icons.ac_unit, title: ""),
                );
              },
              icon: Icon(
                Icons.clear,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            // isDense: true,
            isCollapsed: true,
            border: OutlineInputBorder(),
          ),
          items: categoryList
              .map((e) => <String, dynamic>{
                    "value": e.title,
                    "label": e.title,
                    "icon": Icon(e.iconData),
                  })
              .toList(),
          onChanged: (val) {
            bloc.update(
              startDate: transactionPageModel.startDate,
              endDate: transactionPageModel.endDate,
              category: categoryList.firstWhere(
                  (element) => element.title == json.decode(val)["value"]),
            );
          },
          onSaved: (val) {
            bloc.update(
              startDate: transactionPageModel.startDate,
              endDate: transactionPageModel.endDate,
              category: categoryList.firstWhere(
                  (element) => element.title == json.decode(val!)["value"]),
            );
          },
        ),
      ),
    );
  }
}
