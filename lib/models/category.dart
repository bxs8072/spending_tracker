import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Category {
  final IconData iconData;
  final String title;

  Category({required this.iconData, required this.title});

  Map<String, dynamic> get toMap =>
      {"codePoint": iconData.codePoint, "title": title};

  factory Category.fromDynamic(dynamic data) {
    return Category(
      iconData: IconData(data['codePoint'], fontFamily: 'MaterialIcons'),
      title: data['title'],
    );
  }

  factory Category.fromDocumentSnapshot(DocumentSnapshot data) {
    return Category(
      iconData: IconData(data['codePoint'], fontFamily: 'MaterialIcons'),
      title: data['title'],
    );
  }

  void saveCategory(Category category) {
    final _pref = SharedPreferences.getInstance();
    _pref.then((value) {
      List<String> _cat = value.getStringList("categories")!;
      bool _isExist = _cat.contains(json.encode(category.toMap));

      if (!_isExist) {
        _cat.add(json.encode(category.toMap));
        value.setStringList("categories", _cat);
      } else {
        print("Already existed");
      }
    });
  }

  void deleteCategory(Category category) {
    final _pref = SharedPreferences.getInstance();
    _pref.then((value) {
      List<String> _cat = value.getStringList("categories")!;
      _cat.removeWhere((element) => element == json.encode(category.toMap));
      value.setStringList("categories", _cat);
    });
  }

  void updateCategory(Category category, IconData iconData, String title) {
    final _pref = SharedPreferences.getInstance();
    _pref.then((value) {
      List<String> _cat = value.getStringList("categories")!;
      Category _findCat = Category.fromDynamic(
          _cat.firstWhere((element) => element == json.encode(category.toMap)));

      _findCat = Category(iconData: iconData, title: title);

      int _index = _cat.indexOf(json.encode(category.toMap));

      _cat[_index] = json.encode(_findCat.toMap);

      value.setStringList("categories", _cat);
    });
  }
}
