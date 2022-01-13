import 'package:learn/paths.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:learn/requests.dart';

void popup(List<EventCalendar> events, Room salle, BuildContext context) {
  List<EventCalendar> data = events
      .where((ev) =>
          (ev.location == salle.id &&
              DateTime.parse(ev.start).toString().substring(0, 10) ==
                  DateTime.now().toString().substring(0, 10)) &&
          DateTime.parse(ev.start).isAfter(DateTime.now()))
      .toList();

  String dispo = "Aucune Information";
  Color dispoColor = Colors.white;
  if (isThereACourseNow(data)) {
    dispo = "La salle n'est pas disponible";
    dispoColor = Colors.red;
  } else {
    dispo = "La salle est disponible";
    dispoColor = Colors.green;
  }
  print(data);
  print(salle.name + " - " + salle.id);
  Alert(
          style: AlertStyle(
              overlayColor: Color(0x10000000),
              backgroundColor: Color(0x5F000000),
              titleStyle: TextStyle(color: dispoColor),
              descStyle: TextStyle(color: dispoColor)),
          context: context,
          title: salle.name,
          desc: dispo)
      .show();
}

bool isThereACourseNow(List<EventCalendar> todayCourses) {
  for (EventCalendar course in todayCourses) {
    if (DateTime.now().isBefore(DateTime.parse(course.end)) &&
            DateTime.now().isAfter(DateTime.parse(course.start)) ||
        todayCourses.isEmpty) {
      return true;
    }
  }
  return false;
}
