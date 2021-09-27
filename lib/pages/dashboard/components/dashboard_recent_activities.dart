import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uchiha_saving/models/category.dart';
import 'package:uchiha_saving/models/person.dart';
import 'package:uchiha_saving/models/spend.dart';
import 'package:uchiha_saving/tools/get_random_color.dart';

class DashboardRecentActivity extends StatelessWidget {
  final Person person;
  DashboardRecentActivity({Key? key, required this.person}) : super(key: key);

  List<Spend> _list = [
    Spend(
      title: "Walmart",
      description: "Bought groceries",
      createdAt: Timestamp.now(),
      amount: 67.65,
      spendType: 2,
      category: Category(iconData: Icons.shopping_bag, title: "Grocery"),
      priority: 3,
    ),
    Spend(
      title: "Gas Station",
      description: "Filled gas at Racetrac",
      createdAt: Timestamp.now(),
      amount: 35.00,
      spendType: 2,
      category: Category(
        iconData: Icons.emoji_transportation,
        title: "Transportation",
      ),
      priority: 3,
    ),
    Spend(
      title: "Netflix",
      description: "Netflix Subscription",
      createdAt: Timestamp.now(),
      amount: 20.00,
      spendType: 2,
      category: Category(
        iconData: Iconic.video,
        title: "Entertainment",
      ),
      priority: 1,
    ),
    Spend(
      title: "College Tuition",
      description: "First Installment",
      createdAt: Timestamp.now(),
      amount: 2000.00,
      spendType: 2,
      category: Category(
        iconData: Icons.school,
        title: "School",
      ),
      priority: 3,
    ),
    // Spend(
    //   title: "Shopping Clothes",
    //   description: "Bought Shirts and Pants",
    //   createdAt: Timestamp.now(),
    //   amount: 635.45,
    //   spendType: 2,
    //   category: Category(
    //     iconData: Icons.shopping_bag,
    //     title: "Shopping",
    //   ),
    //   priority: 2,
    // ),
    // Spend(
    //   title: "Shopping Clothes",
    //   description: "Bought Shirts and Pants",
    //   createdAt: Timestamp.now(),
    //   amount: 635.45,
    //   spendType: 2,
    //   category: Category(
    //     iconData: Icons.shopping_bag,
    //     title: "Shopping",
    //   ),
    //   priority: 2,
    // ),
    // Spend(
    //   title: "Shopping Clothes",
    //   description: "Bought Shirts and Pants",
    //   createdAt: Timestamp.now(),
    //   amount: 635.45,
    //   spendType: 2,
    //   category: Category(
    //     iconData: Icons.shopping_bag,
    //     title: "Shopping",
    //   ),
    //   priority: 2,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Recent Activities",
                  style: GoogleFonts.lato(
                    fontSize: _size.height * 0.025,
                  ),
                ),
              ),
              ListView.builder(
                  primary: false,
                  padding: EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  itemCount: _list.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: getRandomColor(context),
                        leading: Icon(_list[i].category.iconData),
                        isThreeLine: true,
                        dense: true,
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(
                          _list[i].title,
                          style: GoogleFonts.lato(
                            fontSize: _size.height * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Intl().date('MMM dd', 'en_US').format(
                                    _list[i].createdAt.toDate(),
                                  ),
                              style: GoogleFonts.lato(
                                fontSize: _size.height * 0.022,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _list[i].description,
                              style: GoogleFonts.lato(
                                fontSize: _size.height * 0.022,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        trailing: Text(
                          _list[i].spendType == 1
                              ? "+ "
                              : "- " +
                                  "\$${_list[i].amount.toStringAsFixed(2)}",
                          style: GoogleFonts.lato(
                            fontSize: _size.height * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
              Divider(
                thickness: 2,
              ),
              ListTile(
                contentPadding: EdgeInsets.all(8.0),
                leading: Icon(FontAwesome.list_bullet),
                title: Text(
                  "View all activity",
                  style: GoogleFonts.lato(),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ),
      ),
    );
  }
}
