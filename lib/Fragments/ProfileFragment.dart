import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Center(
                child: Column(children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://i.ytimg.com/vi/zPCZWn_iWb0/maxresdefault.jpg"),
                radius: 80,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30, top: 10),
                child: Text(
                  "Tony Bigeard",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text("Owner"),
              Text("exemple@gmail.com"),
              RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Edit Profile"),
                  onPressed: () {}),
            ]))
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
