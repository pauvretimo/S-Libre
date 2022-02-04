import 'package:learn/paths.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:learn/requests.dart';

void popup(List<EventCalendar> events, Room salle, BuildContext context) {
  print(salle.name + " - " + salle.id);
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
              alertBorder: Border.all(color: Colors.transparent),
              overlayColor: Colors.transparent,
              backgroundColor: const Color(0x4F000000),
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
