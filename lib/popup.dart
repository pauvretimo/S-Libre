import 'package:learn/paths.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:learn/requests.dart';

void popup(List<EventCalendar> events, Room salle, BuildContext context) {
  String dispo = "Aucune Information";
  Color dispoColor = Colors.white;
  if (isThereACourseNow(events, salle)) {
    dispo = "La salle n'est pas disponible";
    dispoColor = Colors.red;
  } else {
    dispo = "La salle est disponible";
    dispoColor = Colors.green;
  }
  Alert(
          style: AlertStyle(
              overlayColor: const Color(0x10000000),
              backgroundColor: const Color(0x5F000000),
              titleStyle: TextStyle(
                color: dispoColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Dongle",
                fontSize: 50,
              ),
              descStyle: TextStyle(
                color: dispoColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Dongle",
                fontSize: 40,
              )),
          context: context,
          title: salle.name,
          desc: dispo)
      .show();
}

bool isThereACourseNow(List<EventCalendar> events, Room salle) {
  List<EventCalendar> data = events
      .where((ev) => (ev.location == salle.id &&
          DateTime.parse(ev.start).toString().substring(0, 10) ==
              DateTime.now().toString().substring(0, 10)))
      .toList();

  for (EventCalendar course in data) {
    if (DateTime.now().isBefore(DateTime.parse(course.end)) &&
            DateTime.now().isAfter(DateTime.parse(course.start)) ||
        data.isEmpty) {
      return true;
    }
  }
  return false;
}

bool isTimoteABigBigBeauGosse() {
  return true;
}
