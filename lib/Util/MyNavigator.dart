import 'package:be_aware/Pages/AppairagePage.dart';
import 'package:be_aware/Pages/MainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:be_aware/Pages/root_page.dart';

class MyNavigator {
  static Future<void> goToHome(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });
  }

  static Future<void> goToAppairage(BuildContext context) async {
    // await Future.delayed(Duration(milliseconds: 300));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppairagePage()),
      );
    });
  }

  static Future<void> goToRoot(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RootPage()),
      );
    });
  }
}
