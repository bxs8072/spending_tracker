import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:uchiha_saving/api/auth.dart';
import 'package:uchiha_saving/api/auth_base.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/tools/custom_navigator.dart';
import 'package:uchiha_saving/uis/categories_ui/category_ui.dart';

class ProfilePage extends StatelessWidget {
  final Person person;
  ProfilePage({Key? key, required this.person}) : super(key: key);

  AuthBase _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
            },
            icon: Icon(FontAwesome.logout),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Card(
              child: ListTile(
                leading: Icon(Icons.category),
                title: Text("Categories"),
                onTap: () {
                  customNavigator(context, CategoriesUI(person: person));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
