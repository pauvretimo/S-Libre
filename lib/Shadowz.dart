import 'package:flutter/material.dart';
import 'package:learn/MyClipper.dart';
import 'package:learn/popup.dart';
import 'package:learn/paths.dart';
import 'package:learn/requests.dart';
import 'package:learn/Floor.dart';

@immutable
class ClipShadowedPathclicker extends StatefulWidget {
  final BoxShadow shadow;
  final Paths paths;
  final List<EventCalendar> events;
  final double eleveted;

  ClipShadowedPathclicker({
    required this.shadow,
    required this.paths,
    required this.events,
    required this.eleveted,
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
      events,
      eleveted);
}

class _ClipShadowedPathclicker extends State<ClipShadowedPathclicker> {
  BoxShadow shadow;
  Offset offset;
  Paths paths;
  List<EventCalendar> events;
  double eleveted;
  _ClipShadowedPathclicker(
      this.offset, this.shadow, this.paths, this.events, this.eleveted);
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return Center(
            child: AspectRatio(
                aspectRatio: 9 / 16,
                child: Transform.scale(
                    scale: 0.95,
                    child: Card(
                        elevation: eleveted,
                        child: Stack(key: UniqueKey(), children: [
                          ...paths.verticalpaths.map((e) {
                            return Transform.translate(
                                offset: offset,
                                child: ClipPath(
                                    child: Container(
                                        decoration:
                                            BoxDecoration(boxShadow: [shadow])),
                                    clipper: MyClipper(e.svgpath, orientation,
                                        paths.xScalev, paths.yScalev)));
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
                                clipper: MyClipper(e.svgpath, orientation,
                                    paths.xScalev, paths.yScalev));
                          }).toList()
                        ])))));
      } else {
        return Center(
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Transform.scale(
                    scale: 0.95,
                    child: Card(
                        elevation: eleveted,
                        child: Stack(key: UniqueKey(), children: [
                          ...paths.horizontalpaths.map((e) {
                            return Transform.translate(
                                offset: offset,
                                child: ClipPath(
                                    child: Container(
                                        decoration:
                                            BoxDecoration(boxShadow: [shadow])),
                                    clipper: MyClipper(e.svgpath, orientation,
                                        paths.xScaleh, paths.yScaleh)));
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
                                clipper: MyClipper(e.svgpath, orientation,
                                    paths.xScaleh, paths.yScaleh));
                          }).toList()
                        ])))));
      }
    });
  }
}
