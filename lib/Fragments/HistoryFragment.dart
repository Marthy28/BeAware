import 'package:be_aware/Items/Profil.dart';
import 'package:be_aware/Util/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            stream: provider.getHistory(),
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
    Timestamp test = document.data()["date"];
    var date = test.toDate();
    return FutureBuilder(
      future: getProfilInfo(document),
      builder: (context, snapshot) {
        if (userDetail != null) {
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
                                  backgroundColor: Colors.black,
                                )),
                            Text(
                              "${userDetail.firstName} ${userDetail.lastName}",
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
                                padding: EdgeInsets.fromLTRB(150, 5, 5, 30),
                                child: Text(
                                  "${date.hour}h${date.minute}",
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

  getProfilInfo(QueryDocumentSnapshot document) async {
    var user = await provider.getProfile(document.data()["user_id"]);
    userDetail = Profil.fromProfilData(user.data());
  }
}
