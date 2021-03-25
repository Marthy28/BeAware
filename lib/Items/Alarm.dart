import 'package:be_aware/Util/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Alarm {
  String name, id;

  Alarm.fromData(QueryDocumentSnapshot snap) {
    name = snap.get('name');
    id = snap.id;
  }
}
