import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void customNavigator(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (ctx) {
      return widget;
    }),
  );
}
