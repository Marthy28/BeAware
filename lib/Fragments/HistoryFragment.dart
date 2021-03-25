import 'package:be_aware/Items/Profil.dart';
import 'package:be_aware/Util/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                "BeAware",
                style: TextStyle(fontSize: 40),
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
            stream: provider.getHistory(20),
            builder: (BuildContext, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return itemHistory(context, snapshot.data.docs[index]);
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
                            Text(
                              document.data()['type'] == 'alert'
                                  ? "Intrusion"
                                  : "${snapshot.data.firstName} ${snapshot.data.lastName}",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      fontSize: 28.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(40, 5, 5, 30),
                                child: Text(
                                  date.minute < 10
                                      ? "${date.hour}h0${date.minute}"
                                      : "${date.hour}h${date.minute}",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                )),
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
