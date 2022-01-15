import 'package:flutter/material.dart';
import 'package:learn/MyClipper.dart';
import 'package:learn/popup.dart';
import 'package:learn/paths.dart';
import 'package:learn/requests.dart';

@immutable
class ClipShadowedPathclicker extends StatefulWidget {
  final BoxShadow shadow;
  final Paths paths;
  final List<EventCalendar> events;

  ClipShadowedPathclicker({
    required this.shadow,
    required this.paths,
    required this.events,
  });
  @override
  State<ClipShadowedPathclicker> createState() => _ClipShadowedPathclicker(
      shadow.offset,
      BoxShadow(
          blurRadius: shadow.blurRadius,
          spreadRadius: shadow.spreadRadius,
          color: shadow.color,
          blurStyle: shadow.blurStyle),
      paths,
      events);
}

class _ClipShadowedPathclicker extends State<ClipShadowedPathclicker> {
  BoxShadow shadow;
  Offset offset;
  Paths paths;
  List<EventCalendar> events;
  _ClipShadowedPathclicker(this.offset, this.shadow, this.paths, this.events);
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return AspectRatio(
            aspectRatio: 9 / 16,
            child: Stack(key: UniqueKey(), children: [
              ...paths.verticalpaths.map((e) {
                return Transform.translate(
                    offset: offset,
                    child: ClipPath(
                        child: Container(
                            decoration: BoxDecoration(boxShadow: [shadow])),
                        clipper: MyClipper(e.svgpath, orientation)));
              }).toList(),
              ...paths.verticalpaths.map((e) {
                return ClipPath(
                    child: Material(
                        child: InkWell(
                            child: null,
                            onTap: () {
                              popup(events, e, context);
                            }),
                        color: e.color),
                    clipper: MyClipper(e.svgpath, orientation));
              }).toList()
            ]));
      } else {
        return AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(key: UniqueKey(), children: [
              ...paths.horizontalpaths.map((e) {
                return Transform.translate(
                    offset: offset,
                    child: ClipPath(
                        child: Container(
                            decoration: BoxDecoration(boxShadow: [shadow])),
                        clipper: MyClipper(e.svgpath, orientation)));
              }).toList(),
              ...paths.horizontalpaths.map((e) {
                return ClipPath(
                    child: Material(
                        child: InkWell(
                            child: null,
                            onTap: () {
                              popup(events, e, context);
                            }),
                        color: e.color),
                    clipper: MyClipper(e.svgpath, orientation));
              }).toList()
            ]));
      }
    });
  }
}
