import 'package:be_aware/Util/MyNavigator.dart';
import 'dart:ui';
import 'package:be_aware/Util/global.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _openFileExplorer() async {
      FilePickerResult result = await FilePicker.platform.pickFiles();

      if (result != null) {
        // File file = File(result.files.single.path);
        print(result.files.single.path);
        storageProvider.uploadFile(
            "xshiCmkPvzXIfBCHiju3", result.files.single.path);
      } else {
        // User canceled the picker
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
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
                  RaisedButton(
                      color: Colors.blueAccent,
                      child: Text("Change music"),
                      onPressed: () => _openFileExplorer()),
                  FlatButton(
                    color: Colors.pink,
                    child: Text('Se déconnecter'),
                    onPressed: () {
                      auth.signOut().then((value) => MyNavigator.goToRoot(context));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
