import 'package:be_aware/Pages/MainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:be_aware/Pages/root_page.dart';

import 'global.dart';

class MyNavigator {
  static Future<void> goToHome(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  static Future<void> goToRoot() async {
    //Navigator.pop(context);
    await Future.delayed(Duration(milliseconds: 300));
    Navigator.push(
      buildContext,
      MaterialPageRoute(builder: (context) => RootPage()),
    );
    //Navigator.pushNamed(context, "/root");
  }
}
