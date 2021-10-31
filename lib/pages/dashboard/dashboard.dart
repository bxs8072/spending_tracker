import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/pages/dashboard/components/dashboard_app_bar.dart';
import 'package:uchiha_saving/pages/dashboard/components/dashboard_balance_card.dart';
import 'package:uchiha_saving/pages/dashboard/components/dashboard_recent_activities.dart';
import 'package:uchiha_saving/pages/dashboard/components/dashboard_target_card.dart';
import 'package:uchiha_saving/pages/dashboard/components/quote_of_the_day.dart';

class Dashboard extends StatefulWidget {
  final Person person;
  Dashboard({Key? key, required this.person}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          DashboardAppBar(person: widget.person, key: widget.key),
          DashboardBalanceCard(key: widget.key, person: widget.person),
          // QuoteOfTheDay(person: widget.person, key: widget.key),

          SliverToBoxAdapter(
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    height: _size.height * 0.3,
                    child: Text("Comparison Line Chart"),
                  ),
                ),
              ),
            ),
          ),
          DashboardRecentActivity(person: widget.person, key: widget.key),
          DashboardTargetCard(person: widget.person, key: widget.key),
        ],
      ),
    );
  }
}
