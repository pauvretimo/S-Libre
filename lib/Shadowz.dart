import 'package:flutter/material.dart';
import 'package:learn/MyClipper.dart';
import 'package:learn/popup.dart';
import 'package:learn/paths.dart';
import 'package:learn/requests.dart';

@immutable
class ClipShadowedPathclicker extends StatefulWidget {
  final BoxShadow shadow;
  final Paths paths;
  final Orientation orientation;
  final List<EventCalendar> events;

  ClipShadowedPathclicker({
    required this.shadow,
    required this.paths,
    required this.orientation,
    required this.events,
  });
  @override
  State<ClipShadowedPathclicker> createState() => _ClipShadowedPathclicker(
      shadow.offset,
      BoxShadow(
          blurRadius: shadow.blurRadius, spreadRadius: shadow.spreadRadius),
      paths,
      orientation,
      events);
}

class _ClipShadowedPathclicker extends State<ClipShadowedPathclicker> {
  BoxShadow shadow;
  Offset offset;
  Paths paths;
  Orientation orientation;
  List<EventCalendar> events;
  _ClipShadowedPathclicker(
      this.offset, this.shadow, this.paths, this.orientation, this.events);

  @override
  Widget build(BuildContext context) {
    return Stack(key: UniqueKey(), children: [
      ...paths.verticalpaths.map((e) {
        return Transform.translate(
            offset: offset,
            child: ClipPath(
                child:
                    Container(decoration: BoxDecoration(boxShadow: [shadow])),
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
            ),
            clipper: MyClipper(e.svgpath, orientation));
      }).toList()
    ]);
  }
}
