import 'package:flutter/material.dart';

mixin MyNavigatorManager {
  void navigatoToWidget(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ));
  }
}
