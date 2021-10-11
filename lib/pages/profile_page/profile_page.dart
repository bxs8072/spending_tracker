import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:uchiha_saving/api/auth.dart';
import 'package:uchiha_saving/api/auth_base.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/pages/profile_page/components/image_logo.dart';
import 'package:uchiha_saving/pages/profile_page/components/profile_page_appbar.dart';
import 'package:uchiha_saving/tools/custom_navigator.dart';
import 'package:uchiha_saving/uis/categories_ui/category_ui.dart';

class ProfilePage extends StatelessWidget {
  final Person person;
  ProfilePage({Key? key, required this.person}) : super(key: key);

  AuthBase _auth = Auth();
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ProfilePageAppBar(person: person, key: key),
          SliverToBoxAdapter(child: ImageLogo(person: person, key: key)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                person.name.firstName +
                    " " +
                    person.name.middleName +
                    " " +
                    person.name.lastName,
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                  fontSize: _size.height * 0.029,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.monetization_on),
                  title: Text(
                    "Balance: \$ " + person.balance.toStringAsFixed(2),
                    style: GoogleFonts.lato(),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      person.phone,
                      style: GoogleFonts.lato(),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                      contentPadding: EdgeInsets.all(12.0),
                      leading: Icon(Icons.map),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            person.address.street +
                                ", " +
                                person.address.roomNumber,
                            style: GoogleFonts.lato(),
                          ),
                          Text(
                            person.address.city,
                            style: GoogleFonts.lato(),
                          ),
                          Text(
                            person.address.state +
                                " " +
                                person.address.zipCode.toString(),
                            style: GoogleFonts.lato(),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.category),
                    title: Text(
                      "Categories",
                      style: GoogleFonts.lato(),
                    ),
                    onTap: () {
                      customNavigator(context, CategoriesUI(person: person));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text(
                      "FAQ and Policies",
                      style: GoogleFonts.lato(),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.bookmark),
                    title: Text(
                      "Bookmarks",
                      style: GoogleFonts.lato(),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
