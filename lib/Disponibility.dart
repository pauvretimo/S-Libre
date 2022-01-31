import 'package:flutter/material.dart';

class Disponibility {
  String id_room;
  bool is_dispo = true;

  Room(this.id_room, this.is_dispo);
}

List<Disponibility> getDisponibility(List<EventCalendar> events) {
  List<Disponibility> disponibility = [];
  for (EventCalendar event in events) {
    if(DateTime.parse(event.start).toString().substring(0, 10) ==
              DateTime.now().toString().substring(0, 10)
      && DateTime.parse(event.start).isBefore(DateTime.now())
      && DateTime.parse(event.end).isAfter(DateTime.now())) {
      disponibility.add(Disponibility(event.id_room, false));
    }
  return disponibility;
}