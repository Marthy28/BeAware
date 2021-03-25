import 'package:be_aware/Pages/AppairagePage.dart';
import 'package:be_aware/Pages/MainPage.dart';
import 'package:be_aware/Util/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:be_aware/Pages/root_page.dart';

class MyNavigator {
  static Future<void> goToHome(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });
  }

  static Future<void> goToAppairage(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AppairagePage(
                  isFromProfil: false,
                )),
      );
    });
  }

  static Future<void> goToRoot() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        buildContext,
        MaterialPageRoute(builder: (context) => RootPage()),
      );
    });
  }

  static Future<void> goToMyAlarms() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        buildContext,
        MaterialPageRoute(
            builder: (context) => AppairagePage(
                  isFromProfil: true,
                )),
      );
    });
  }

  static Future<void> goBackFromMyAlarms() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(buildContext);
    });
  }
}
