import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/models/transaction.dart';
import 'package:uchiha_saving/tools/custom_navigator.dart';
import 'package:uchiha_saving/uis/line_chart_ui/line_chart_ui.dart';
import 'package:uchiha_saving/uis/pie_chart_ui/pie_chart_bloc.dart';
import 'package:uchiha_saving/uis/pie_chart_ui/pie_chart_by_category.dart';
import 'package:uchiha_saving/uis/pie_chart_ui/pie_chart_ui.dart';

class TransactionPieChartCard extends StatefulWidget {
  final Person person;
  const TransactionPieChartCard({Key? key, required this.person})
      : super(key: key);

  @override
  _TransactionPieChartCardState createState() =>
      _TransactionPieChartCardState();
}

class _TransactionPieChartCardState extends State<TransactionPieChartCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                customNavigator(
                  context,
                  LineChartUI(
                    person: widget.person,
                    key: widget.key,
                  ),
                );
              },
              child: Column(
                children: [
                  Icon(
                    Icons.graphic_eq,
                    size: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text("Line Graph")
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                customNavigator(
                  context,
                  PieChartUI(
                    person: widget.person,
                    key: widget.key,
                  ),
                );
              },
              child: Column(
                children: [
                  Icon(
                    Icons.pie_chart,
                    size: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text("Pie Chart")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
