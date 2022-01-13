import 'package:flutter/material.dart';
import 'package:learn/paths.dart';
import 'package:learn/MyClipper.dart';
import 'package:learn/popup.dart';
import 'package:learn/requests.dart';

class PlanPortrait extends StatefulWidget {
  final List<EventCalendar> events;
  const PlanPortrait({Key? key, required this.events}) : super(key: key);

  @override
  State<PlanPortrait> createState() => _PlanPortrait(events: this.events);
}

class _PlanPortrait extends State<PlanPortrait> {
  List<EventCalendar> events;
  @override
  _PlanPortrait({required this.events});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 9 / 16,
        child: Stack(
          children: paths.verticalpaths.map((e) {
            return ClipPath(
              // widget prenant un path et qui permet d'inclure les widgets soujacents dans la forme du Clipath
              child: Material(
                child: InkWell(
                  child: null,
                  onTap: () {
                    popup(events, e, context);
                  },
                ),
                color: (e
                    .color), //couleur du material ie de la forme (inkwell et clipath ne permettent pas de colorier)
              ),
              clipper: MyClipperPortrait(e.svgpath),
            );
          }).toList(),
        ));
  }
}

class PlanLandscape extends StatefulWidget {
  final List<EventCalendar> events;
  const PlanLandscape({Key? key, required this.events}) : super(key: key);

  @override
  State<PlanLandscape> createState() => _PlanLandscape(events: this.events);
}

class _PlanLandscape extends State<PlanLandscape> {
  List<EventCalendar> events;
  @override
  _PlanLandscape({required this.events});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: paths.horizontalpaths.map((e) {
            return ClipPath(
              // widget prenant un path et qui permet d'inclure les widgets soujacents dans la forme du Clipath
              child: Material(
                child: InkWell(
                  child: null,
                  onTap: () {
                    popup(events, e, context);
                  },
                ),
                color: (e
                    .color), //couleur du material ie de la forme (inkwell et clipath ne permettent pas de colorier)
              ),
              clipper: MyClipperLandscape(e.svgpath),
            );
          }).toList(),
        ));
  }
}
