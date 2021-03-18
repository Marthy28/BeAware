import 'dart:async';

import 'package:be_aware/Util/MyNavigator.dart';
import 'package:be_aware/Util/global.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void initState() {
    //widget.dbProvider.main();
    super.initState();
    buildContext = context;
    Timer(Duration(milliseconds: 300), () => MyNavigator.goToRoot(context));
  }
}
