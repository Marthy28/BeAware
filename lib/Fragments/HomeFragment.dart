import 'package:be_aware/Items/Alarm.dart';
import 'package:be_aware/Util/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.all(30),
              child: Text(
                "Accueil",
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StreamBuilder(
                          stream: provider.usersAlarm(firebaseUser.uid),
                          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                              return Center(
                                child: DropdownButton(
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
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                      if (_selectedAlarm != null)
                        StreamBuilder(
                          stream: provider.alarm(_selectedAlarm.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _isActive = snapshot.data["isActive"];
                              return Expanded(
                                child: FlutterSwitch(
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
                                    provider.setIsActive(
                                        isActive, _selectedAlarm.id);
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        )
                    ],
                  ),
                ),
                Container(
                    child: StreamBuilder(
                        stream: provider.usersAlarm(firebaseUser.uid),
                        builder: (BuildContext,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return StreamBuilder(
                                    stream: provider.getHistory(
                                        1, snapshot.data.docs[index].id),
                                    builder: (BuildContext,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                snapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              if (snapshot.hasData) {
                                                print(snapshot.data.docs[index]
                                                    ["date"]);
                                                if (snapshot.data.docs[index]
                                                        ['type'] ==
                                                    'alert') {
                                                  DateTime date;
                                                  if (snapshot.data.docs[index]
                                                          ["date"] ==
                                                      null) {
                                                    date = DateTime.now();
                                                  } else if (snapshot
                                                          .data.docs[index]
                                                      ["date"] is String) {
                                                    date = new DateFormat(
                                                            "yyyy-MM-dd hh:mm:ss")
                                                        .parse(snapshot.data
                                                                .docs[index]
                                                            ["date"]);
                                                  } else {
                                                    date = snapshot.data
                                                        .docs[index]["date"]
                                                        .toDate()
                                                        .toLocal();
                                                  }

                                                  return Container(
                                                    child: Card(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            color: Colors.red,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15),
                                                              child: Text(
                                                                "You have a intrusion",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 30,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Text(
                                                                  "Il y a eu une intrusion dans votre maison le ${DateFormat('dd/MM/yyyy à HH:mm').format(date)}"),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              snapshot
                                                                  .data
                                                                  .docs[index]
                                                                  .reference
                                                                  .update({
                                                                "type":
                                                                    "validate"
                                                              });
                                                            },
                                                            child: Text(
                                                                "marquer comme lu"),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              } else {
                                                return Container();
                                              }
                                            });
                                      } else {
                                        return Container();
                                      }
                                    });
                              },
                            );
                          } else
                            return Container();
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
