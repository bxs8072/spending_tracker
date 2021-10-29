import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsUI extends StatelessWidget {
  final Person person;
  const NotificationsUI({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            title: Text(
              "Notifications",
              style: GoogleFonts.lato(),
            ),
            backgroundColor: Colors.transparent,
            foregroundColor:
                ThemeProvider.controllerOf(context).currentThemeId == "dark"
                    ? Colors.white
                    : Colors.black,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Notifications')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(child: Center());
                } else {
                  List<Map<String, dynamic>> _items = snapshot.data!.docs
                      .map((e) => e.data() as Map<String, dynamic>)
                      .toList();
                  return _items.isEmpty
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(height: _size.height * 0.2),
                                Text(
                                  "You have no notifications at this time\n\n ☺️☺️☺️",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    fontSize: _size.height * 0.023,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate((context, i) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        _items[i]['title'],
                                        style:
                                            GoogleFonts.allerta(fontSize: 16),
                                      )),
                                  Image.network(_items[i]['image']),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      _items[i]['content'],
                                      style: GoogleFonts.allerta(fontSize: 16),
                                    ),
                                  ),
                                  RaisedButton(
                                    color: Colors.blue,
                                    onPressed: () async {
                                      await launch(_items[i]['link']);
                                    },
                                    child: Text(
                                      _items[i]['btnName'],
                                      style: GoogleFonts.allerta(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }, childCount: _items.length),
                        );
                }
              })
        ],
      ),
    );
  }
}