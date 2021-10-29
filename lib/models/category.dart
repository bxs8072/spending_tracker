import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uchiha_saving/tools/categories_list.dart';

class Category {
  final IconData iconData;
  final String title;

  Category({required this.iconData, required this.title});

  static Category get coffee =>
      Category(iconData: Icons.coffee, title: "Coffee");
  static Category get entertainment =>
      Category(iconData: Icons.music_note, title: "Entertainment");
  static Category get electricity =>
      Category(iconData: Icons.lightbulb, title: "Electricity");
  static Category get gas =>
      Category(iconData: Icons.local_gas_station, title: "Gas");
  static Category get grocery =>
      Category(iconData: Icons.local_grocery_store, title: "Grocery");
  static Category get home => Category(iconData: Icons.home, title: "Home");
  static Category get income =>
      Category(iconData: Icons.monetization_on, title: "Income");
  static Category get miscellaneous =>
      Category(iconData: Icons.more, title: "Miscellaneous");
  static Category get rent =>
      Category(iconData: Icons.business_outlined, title: "Rent");
  static Category get restaurant =>
      Category(iconData: Icons.restaurant, title: "Restaurant");
  static Category get school =>
      Category(iconData: Icons.school, title: "School");
  static Category get stationery =>
      Category(iconData: Icons.book, title: "Stationery");
  static Category get transportation =>
      Category(iconData: Icons.emoji_transportation, title: "Transportation");
  static Category get water => Category(iconData: Icons.water, title: "Water");
  static Category get work => Category(iconData: Icons.work, title: "Work");

  factory Category.fromDynamic(dynamic data) {
    return categoryList
        .firstWhere((element) => element.title == data['category']);
  }

  factory Category.fromDocumentSnapshot(DocumentSnapshot data) {
    return categoryList
        .firstWhere((element) => element.title == data['category']);
  }

  //  void saveCategory(Category category) {
  //   final _pref = SharedPreferences.getInstance();
  //   _pref.then((value) {
  //     List<String> _cat = value.getStringList("categories")!;
  //     bool _isExist = _cat.contains(json.encode(category.toMap));

  //     if (!_isExist) {
  //       _cat.add(json.encode(category.toMap));
  //       value.setStringList("categories", _cat);
  //     } else {
  //       print("Already existed");
  //     }
  //   });
  // }

  // void deleteCategory(Category category) {
  //   final _pref = SharedPreferences.getInstance();
  //   _pref.then((value) {
  //     List<String> _cat = value.getStringList("categories")!;
  //     _cat.removeWhere((element) => element == json.encode(category.toMap));
  //     value.setStringList("categories", _cat);
  //   });
  // }

  // void updateCategory(Category category, IconData iconData, String title) {
  //   final _pref = SharedPreferences.getInstance();
  //   _pref.then((value) {
  //     List<String> _cat = value.getStringList("categories")!;
  //     Category _findCat = Category.fromDynamic(
  //         _cat.firstWhere((element) => element == json.encode(category.toMap)));

  //     _findCat = Category(iconData: iconData, title: title);

  //     int _index = _cat.indexOf(json.encode(category.toMap));

  //     _cat[_index] = json.encode(_findCat.toMap);

  //     value.setStringList("categories", _cat);
  //   });
  // }

}
