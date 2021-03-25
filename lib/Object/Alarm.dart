class Alarm {
  String name;

  Alarm.fromData(Map<String, dynamic> data) {
    name = data['name'];
  }
}
