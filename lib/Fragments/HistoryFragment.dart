import 'package:be_aware/Items/Profil.dart';
import 'package:be_aware/Util/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:be_aware/Util/global.dart';
import 'package:intl/intl.dart';

class HistoryFragment extends StatefulWidget {
  @override
  _HistoryFragment createState() => _HistoryFragment();
}

class _HistoryFragment extends State<HistoryFragment> {
  Profil userDetail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(30),
              child: Text(
                "Historique",
                style: TextStyle(
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            _listPersonne(context),
          ],
        ),
      ),
    );
  }

  Widget _listPersonne(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream: provider.usersAlarm(firebaseUser.uid),
            builder: (BuildContext, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder(
                        stream: provider.getHistory(
                            20, snapshot.data.docs[index].id),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  return itemHistory(
                                      context, snapshot.data.docs[index]);
                                });
                          } else
                            return Container();
                        },
                      );
                    });
              } else {
                return Container();
              }
            }));
  }

  Widget itemHistory(BuildContext context, QueryDocumentSnapshot document) {
    DateTime date;
    userDetail = null;
    if (document.data()["date"] == null) {
      date = DateTime.now();
    } else if (document.data()["date"] is String) {
      date =
          new DateFormat("yyyy-MM-dd hh:mm:ss").parse(document.data()["date"]);
    } else {
      date = document.data()["date"].toDate().toLocal();
    }
    return FutureBuilder(
      future: getProfilInfo(document),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: CircleAvatar(
                                  backgroundColor:
                                      document.data()['type'] == 'alert'
                                          ? Colors.red
                                          : Colors.green,
                                )),
                            Expanded(
                              child: Text(
                                document.data()['type'] == 'alert'
                                    ? "Intrusion"
                                    : document.data()['type'] == 'validate'
                                        ? "Validation"
                                        : "${snapshot.data.firstName} ${snapshot.data.lastName}",
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    "${DateFormat('dd/MM/yyyy à HH:mm').format(date.toLocal())}",
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ]))));
        } else {
          return Container();
        }
      },
    );
  }

  Future<Profil> getProfilInfo(QueryDocumentSnapshot document) async {
    var user = await provider.getProfile(document.data()["user_id"]);
    if (user != null)
      return userDetail = Profil.fromProfilData(user.data());
    else
      return null;
  }
}
