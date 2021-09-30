import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
}
