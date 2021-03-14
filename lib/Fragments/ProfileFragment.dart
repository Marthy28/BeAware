import 'package:be_aware/Util/MyNavigator.dart';
import 'package:be_aware/Util/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          color: Colors.pink,
          child: Text('Se déconnecter'),
          onPressed: () {
            auth.signOut().then((value) => MyNavigator.goToRoot());
          },
        ),
      ),
    );
  }
}
