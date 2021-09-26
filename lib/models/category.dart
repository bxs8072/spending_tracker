import 'package:flutter/material.dart';

class Category {
  final IconData iconData;
  final String title;

  Category({required this.iconData, required this.title});

  Map<String, dynamic> get toMap =>
      {"codePoint": iconData.codePoint, "title": title};

  factory Category.fromDynamic(dynamic data) {
    return Category(
      iconData: IconData(data['codePoint']),
      title: data['Title'],
    );
  }
}
