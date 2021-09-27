import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/tools/get_random_color.dart';

class DashboardAppBar extends StatelessWidget {
  final Person person;
  const DashboardAppBar({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return SliverAppBar(
      pinned: true,
      floating: true,
      forceElevated: true,
      stretch: true,
      snap: true,
      leading: Container(
        height: _size.height * 0.22,
        width: _size.height * 0.22,
        child: FlareActor("assets/animations/Dragon.flr",
            animation: "Untitled", color: getRandomColor(context)),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Entypo.bell),
        ),
      ],
    );
  }
}
