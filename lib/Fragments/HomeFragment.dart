import 'package:be_aware/Util/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Info {
  String name;
  DateTime date;

  Info(name) {
    this.name = name;
    this.date = DateTime.now();
  }
}

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    bool _isActive;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Alarme",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30, top: 10),
                  child: StreamBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        _isActive = snapshot.data["isActive"];
                        return FlutterSwitch(
                          width: 120.0,
                          height: 40.0,
                          valueFontSize: 18.0,
                          toggleSize: 20.0,
                          value: _isActive,
                          borderRadius: 30.0,
                          padding: 8.0,
                          showOnOff: true,
                          inactiveText: "Inactive",
                          activeText: "Active",
                          onToggle: (isActive) {
                            provider.setIsActive(isActive);
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                    stream: provider.alarm(),
                  ),
                ),
                Text(
                  "History",
                  style: TextStyle(fontSize: 20),
                ),
                for (var w in dataWidget) w,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
