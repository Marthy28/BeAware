import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class Info {
  String name;
  DateTime date;

  Info(name) {
    this.name = name;
    this.date = DateTime.now();
  }
}

class HomeFragment extends StatelessWidget {
  final databaseRef =
      FirebaseDatabase.instance.reference(); //database reference object

  @override
  Widget build(BuildContext context) {
    List<Info> data = [
      new Info("Robin Bigeard"),
      new Info("Robin Bigeard"),
      new Info("Robin Bigeard")
    ];
    List<Widget> dataWidget = new List<Widget>();
    data.forEach((element) {
      dataWidget.add(Text(element.name));
    });

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.all(30),
            child: Text(
              "BeAware",
              style: TextStyle(fontSize: 40),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Alarme",
                  style: TextStyle(fontSize: 20),
                ),
                LiteRollingSwitch(
                  value: true,
                  textOn: 'Active',
                  textOff: 'Inactive',
                  colorOn: Colors.red,
                  colorOff: Colors.blueGrey,
                  iconOn: Icons.shield,
                  iconOff: Icons.power_settings_new,
                  onChanged: (bool state) {
                    print('turned ${(state) ? 'on' : 'off'}');
                  },
                ),
                for (var w in dataWidget) w,
                RaisedButton(
                    color: Colors.pinkAccent,
                    child: Text("Scan NFC"),
                    onPressed: () {
                      addData("Bigeard", "Scan NFC");
                    }),
              ],
            ),
          ),
        ],
      ),
    );
    throw UnimplementedError();
  }

  void addData(String name, String action) {
    databaseRef.push().set({'name': name, 'comment': action});
  }
}
