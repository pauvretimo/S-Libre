import 'package:flutter/cupertino.dart';
import 'package:learn/Shadowz.dart';
import 'package:learn/paths.dart';
import 'package:learn/requests.dart';

class Floor extends StatefulWidget {
  final int floor;
  final List<EventCalendar> events;
  final Bat batiment;
  final double elevation;
  Floor(
      {required this.floor,
      required this.events,
      required this.batiment,
      required this.elevation});

  @override
  State<Floor> createState() => _Floor(events, batiment, floor, elevation);
}

class _Floor extends State<Floor> {
  List<EventCalendar> events;
  int floor;
  double elevation;
  Bat batiment;
  @override
  _Floor(this.events, this.batiment, this.floor, this.elevation);
  @override
  Widget build(BuildContext context) {
    return ClipShadowedPathclicker(
        shadow: BoxShadow(
            offset: Offset(2.5, 2.5),
            blurRadius: 2,
            spreadRadius: 4,
            color: Color(0x4A000000)),
        eleveted: elevation,
        paths: batiment.bat[floor],
        events: events);
  }
}
