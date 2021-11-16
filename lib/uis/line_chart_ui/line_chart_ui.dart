import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/models/transaction.dart';
import 'package:uchiha_saving/uis/line_chart_ui/data.dart';

class LineChartUI extends StatefulWidget {
  final Person person;
  const LineChartUI({Key? key, required this.person}) : super(key: key);

  @override
  _LineChartUIState createState() => _LineChartUIState();
}

class _LineChartUIState extends State<LineChartUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          title: ChartTitle(text: 'Half yearly sales analysis'),
          // Enable legend
          legend: Legend(isVisible: true),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<Map<String, dynamic>, String>>[
            LineSeries<Map<String, dynamic>, String>(
                dataSource: getList()
                  ..sort((a, b) => a["day"].compareTo(b["day"])),
                xValueMapper: (Map<String, dynamic> transaction, _) =>
                    transaction["day"].toString(),
                yValueMapper: (Map<String, dynamic> transaction, _) =>
                    transaction["amount"],
                name: 'Amount',
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true))
          ]),
    );
  }
}
