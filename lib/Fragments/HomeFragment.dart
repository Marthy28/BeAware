import 'package:be_aware/Items/Alarm.dart';
import 'package:be_aware/Util/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Alarm _selectedAlarm;

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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: StreamBuilder(
                            stream: provider.usersAlarm(firebaseUser.uid),
                            builder:
                                (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                List<Alarm> alarms = new List<Alarm>();
                                snapshot.data.docs.forEach((element) {
                                  alarms.add(Alarm.fromData(element));
                                });

                                if (_selectedAlarm == null)
                                  Future.delayed(Duration.zero, () async {
                                    setState(() {
                                      _selectedAlarm = alarms.first;
                                    });
                                  });

                                return DropdownButton(
                                  underline: Container(),
                                  value: _selectedAlarm,
                                  items: alarms.map<DropdownMenuItem<Alarm>>(
                                      (Alarm value) {
                                    return DropdownMenuItem<Alarm>(
                                      child: Text(
                                        value.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      value: _selectedAlarm,
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedAlarm = newValue;
                                    });
                                  },
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ),
                      if (_selectedAlarm != null)
                        StreamBuilder(
                          stream: provider.alarm(_selectedAlarm.id),
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
                        )
                    ],
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
