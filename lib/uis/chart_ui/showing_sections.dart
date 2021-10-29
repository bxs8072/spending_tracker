import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:uchiha_saving/models/transaction.dart';
import 'package:uchiha_saving/uis/chart_ui/color_by_category.dart';

List<PieChartSectionData> showingSections(
    int touchedIndex, List<Transaction> list, double sum) {
  return List.generate(list.length, (index) {
    bool isTouched = index == touchedIndex;
    double fontSize = isTouched ? 25.0 : 16.0;
    double radius = isTouched == true ? 60.0 : 50.0;
    return PieChartSectionData(
      color: colorByCategory(list[index].category),
      value: list[index].amount / sum,
      title: list[index].category.title,
      radius: radius,
      titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff)),
    );
  });
}
