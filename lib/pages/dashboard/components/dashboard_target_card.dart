import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uchiha_saving/models/person.dart';

class DashboardTargetCard extends StatelessWidget {
  final Person person;
  const DashboardTargetCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "GOALS",
                    style: GoogleFonts.lato(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: Icon(
                        Entypo.target,
                        size: _size.height * 0.08,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: Text(
                          "Easily save for goals like vacations, cars or educations.",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 2),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Create Goal",
                      style: GoogleFonts.lato(
                        fontSize: _size.height * 0.020,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
