import 'package:flutter/material.dart';
import 'package:learn/paths.dart';
import 'package:learn/MyClipper.dart';
import 'package:learn/popup.dart';
import 'package:learn/requests.dart';
import 'package:learn/Shadowz.dart';

class Plan extends StatefulWidget {
  final List<EventCalendar> events;
  final Orientation orientation;
  const Plan({Key? key, required this.events, required this.orientation})
      : super(key: key);

  @override
  State<Plan> createState() =>
      _Plan(events: this.events, orientation: this.orientation);
}

class _Plan extends State<Plan> {
  List<EventCalendar> events;
  Orientation orientation;
  @override
  _Plan({required this.events, required this.orientation});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 9 / 16,
        child: ClipShadowedPathclicker(
          orientation: orientation,
          shadow: BoxShadow(
              offset: Offset(2.5, 2.5), blurRadius: 4, spreadRadius: 4),
          paths: ENSIBSVannesRDCpaths,
          events: events,
        ));
  }
}
