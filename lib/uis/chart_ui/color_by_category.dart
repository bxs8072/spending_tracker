import 'package:flutter/material.dart';
import 'package:uchiha_saving/models/category.dart';

Color colorByCategory(Category category) {
  return category.title == "Home"
      ? Colors.blue
      : category.title == "Work"
          ? Colors.green
          : category.title == "Transportation"
              ? Colors.red
              : category.title == "Grocery"
                  ? Colors.deepOrangeAccent
                  : category.title == "Entertainment"
                      ? Colors.purple
                      : category.title == "School"
                          ? Colors.black
                          : category.title == "Miscellaneous"
                              ? Colors.green
                              : Colors.orange;
}
