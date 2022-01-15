import 'package:flutter/material.dart';
import 'package:learn/paths.dart';
import 'package:learn/requests.dart';
import 'package:learn/Shadowz.dart';

class Plan extends StatefulWidget {
  final List<EventCalendar> events;
  const Plan({Key? key, required this.events}) : super(key: key);

  @override
  State<Plan> createState() => _Plan(events: this.events);
}

class _Plan extends State<Plan> {
  List<EventCalendar> events;
  @override
  _Plan({required this.events});
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        ClipShadowedPathclicker(
          shadow: BoxShadow(
              offset: Offset(2.5, 2.5),
              blurRadius: 2,
              spreadRadius: 4,
              color: Color(0x4A000000)),
          paths: ENSIBSVannesRDCpaths,
          events: events,
        ),
        ClipShadowedPathclicker(
          shadow: BoxShadow(
              offset: Offset(2.5, 2.5),
              blurRadius: 2,
              spreadRadius: 4,
              color: Color(0x4A000000)),
          paths: ENSIBSVannesE1paths,
          events: events,
        ),
      ],
    );
  }
}
