import 'package:flutter/material.dart';
import 'package:learn/requests.dart';

class Disponibility {
  String id_room;
  bool is_dispo = true;

  Disponibility(this.id_room, this.is_dispo);

  void set isDispo(bool value) {
    is_dispo = value;
  }
}

List<Disponibility> getDisponibility(List<EventCalendar> events) {
  List<Disponibility> disponibility = [];
  for (EventCalendar event in events) {
    if (DateTime.parse(event.start).toString().substring(0, 10) ==
            DateTime.now().toString().substring(0, 10) &&
        DateTime.parse(event.start).isBefore(DateTime.now()) &&
        DateTime.parse(event.end).isAfter(DateTime.now())) {
      disponibility.add(Disponibility(event.location, false));
    }
    return disponibility;
  }
  return disponibility;
}
