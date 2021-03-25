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
  @override
  Widget build(BuildContext context) {
    bool _isActive;

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
                Container(
                    child: StreamBuilder(
                        stream: provider.getHistory(1),
                        builder: (BuildContext,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.docs[index]['type'] ==
                                        'alert') {
                                      DateTime date;
                                      if (snapshot.data.docs[index]["date"] ==
                                          null) {
                                        date = DateTime.now();
                                      } else if (snapshot.data.docs[index]
                                          ["date"] is String) {
                                        date = new DateFormat(
                                                "yyyy-MM-dd hh:mm:ss")
                                            .parse(snapshot.data.docs[index]
                                                ["date"]);
                                      } else {
                                        date = snapshot.data.docs[index]["date"]
                                            .toDate()
                                            .toLocal();
                                      }

                                      return Container(
                                          child: Card(
                                              child: Column(
                                        children: [
                                          Container(
                                              width: double.infinity,
                                              color: Colors.red,
                                              child: Expanded(
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.all(15),
                                                      child: Text(
                                                        "You have a intrusion",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 30,
                                                        ),
                                                      )))),
                                          Container(
                                              child: Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(date.minute < 10
                                                      ? "Il y a eu une intrusion dans votre maison le ${date.day}/${date.month} à ${date.hour}h0${date.minute}"
                                                      : "Il y a eu une intrusion dans votre maison le ${date.day}/${date.month} à ${date.hour}h${date.minute}"))),
                                          TextButton(
                                            onPressed: () {
                                              snapshot
                                                  .data.docs[index].reference
                                                  .update({"type": "validate"});
                                            },
                                            child: Text("marquer comme lu"),
                                          )
                                        ],
                                      )));
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
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
