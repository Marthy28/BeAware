import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:be_aware/Util/global.dart';

class HistoryFragment extends StatefulWidget {
  @override
  _HistoryFragment createState() => _HistoryFragment();
}

class _HistoryFragment extends State<HistoryFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
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
    var date = test.toDate().;
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        document.data()["user_id"],
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontSize: 28.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      Text(
        date.toString(),
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontSize: 28.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
