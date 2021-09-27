import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:uchiha_saving/api/auth.dart';
import 'package:uchiha_saving/api/auth_base.dart';
import 'package:uchiha_saving/models/person.dart';

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
    );
  }
}
