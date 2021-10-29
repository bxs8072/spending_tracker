import 'package:cloud_firestore/cloud_firestore.dart' as fr;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:uchiha_saving/models/category.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/models/transaction.dart';
import 'package:uchiha_saving/uis/chart_ui/color_by_category.dart';
import 'package:uchiha_saving/uis/chart_ui/indicator.dart';
import 'package:uchiha_saving/uis/chart_ui/showing_sections.dart';

class ChartUI extends StatefulWidget {
  final Person person;

  ChartUI({Key? key, required this.person}) : super(key: key);

  @override
  State<ChartUI> createState() => _ChartUIState();
}

class _ChartUIState extends State<ChartUI> {
  List<Transaction> _list = [
    Transaction(
      amount: 1200.99,
      category: Category(iconData: Icons.home, title: "Home"),
      createdAt: fr.Timestamp.now(),
      description: "Home Fix",
      priority: 2,
      title: "Home Fix",
      transactionType: TransactionType.expense,
    ),
    Transaction(
      amount: 1500.00,
      category: Category(iconData: Icons.work, title: "Work"),
      createdAt: fr.Timestamp.now(),
      description: "Salary",
      priority: 3,
      title: "Salary",
      transactionType: TransactionType.income,
    ),
    Transaction(
      amount: 30.99,
      category: Category(
          iconData: Icons.emoji_transportation, title: "Transportation"),
      createdAt: fr.Timestamp.now(),
      description: "Transportation",
      priority: 3,
      title: "Gas Fill",
      transactionType: TransactionType.expense,
    ),
    Transaction(
      amount: 150.00,
      category: Category(iconData: Icons.local_grocery_store, title: "Grocery"),
      createdAt: fr.Timestamp.now(),
      description: "Bought FOods",
      priority: 3,
      title: "Walmart Grocery",
      transactionType: TransactionType.expense,
    ),
  ];
  int touchedIndex = -1;

  double sum() {
    double total = 0;
    _list.forEach((e) {
      total += e.amount;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Charts"),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: AspectRatio(
              aspectRatio: 1.3,
              child: Card(
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections(
                              touchedIndex,
                              _list,
                              sum(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _list
                          .map((e) => Indicator(
                                color: colorByCategory(e.category),
                                text: e.category.title,
                                isSquare: false,
                              ))
                          .toList(),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
