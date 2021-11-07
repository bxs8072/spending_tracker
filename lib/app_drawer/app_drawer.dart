import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:uchiha_saving/api/auth.dart';
import 'package:uchiha_saving/models/person.dart';

class AppDrawer extends StatelessWidget {
  final Person person;
  const AppDrawer({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.menu),
            ),
            pinned: true,
            title: Text(
              "Savings",
              style: GoogleFonts.lato(),
            ),
            foregroundColor:
                ThemeProvider.controllerOf(context).currentThemeId == "dark"
                    ? Colors.white
                    : Colors.black,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () {
                  Auth().signOut();
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(FontAwesome.dollar),
                  title: Text(
                    "Goal",
                    style: GoogleFonts.lato(),
                  ),
                ),
                ListTile(
                  leading: Icon(FontAwesome5.money_bill),
                  title: Text(
                    "Transactions",
                    style: GoogleFonts.lato(),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.bookmark),
                  title: Text(
                    "Bookmarks",
                    style: GoogleFonts.lato(),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "Profile",
                    style: GoogleFonts.lato(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
