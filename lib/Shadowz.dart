import 'package:flutter/material.dart';
import 'package:learn/MyClipper.dart';
import 'package:learn/popup.dart';
import 'package:learn/paths.dart';
import 'package:learn/requests.dart';

@immutable
class ClipShadowedPathclicker extends StatefulWidget {
  final int floor;
  final String bat;
  final BoxShadow shadow;
  final Paths paths;
  final List<EventCalendar> events;

  ClipShadowedPathclicker({
    required this.shadow,
    required this.paths,
    required this.events,
    required this.floor,
    required this.bat,
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
        floor,
        bat,
      );
}

class _ClipShadowedPathclicker extends State<ClipShadowedPathclicker> {
  BoxShadow shadow;
  Offset offset;
  Paths paths;
  List<EventCalendar> events;
  int floor;
  String bat;
  _ClipShadowedPathclicker(
      this.offset, this.shadow, this.paths, this.events, this.floor, this.bat);
  @override
  Widget build(BuildContext context) {
    // on gère l'orientation du plan

    return OrientationBuilder(builder: (context, orientation) {
      // portrait

      if (orientation == Orientation.portrait) {
        // le center permet d'empêcher le widget PageView de casser le ratio fixe du AspectRatio
        return Center(
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Card(
                    color: const Color(0xFFCFCFCF),
                    margin:
                        EdgeInsets.all(MediaQuery.of(context).size.height / 50),
                    child: Card(
                        margin: EdgeInsets.all(
                            MediaQuery.of(context).size.height / 50),
                        color: const Color(0xFF202030),
                        elevation: 10.0,
                        child: Center(
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
                                  color: e.color,
                                  child: e.clickable
                                      ? InkWell(
                                          child: null,
                                          hoverColor: const Color(0xA1FFFFFF),
                                          highlightColor:
                                              const Color(0x31FFFFFF),
                                          splashColor: const Color(0xA1FFFFFF),
                                          onTap: () {
                                            if (e.clickable) {
                                              popup(events, e, context);
                                            } else {
                                              print("pas clickable");
                                            }
                                          })
                                      : Container(),
                                  //création d'un bouton uniquement si clickable
                                ),
                                clipper: MyClipper(e.svgpath, orientation,
                                    paths.xScalev, paths.yScalev));
                          }).toList()
                        ]))))));

        // paysage

      } else {
        return Center(
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Card(
                    color: const Color(0xFFCFCFCF),
                    margin:
                        EdgeInsets.all(MediaQuery.of(context).size.height / 50),
                    child: Card(
                        margin: EdgeInsets.all(
                            MediaQuery.of(context).size.height / 50),
                        color: const Color(0xFF202030),
                        elevation: 10.0,
                        child: Center(
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
                                  color: e.color,
                                  child: e.clickable
                                      ? InkWell(
                                          child: null,
                                          hoverColor: const Color(0xA1FFFFFF),
                                          highlightColor:
                                              const Color(0x31FFFFFF),
                                          splashColor: const Color(0xA1FFFFFF),
                                          onTap: () {
                                            if (e.clickable) {
                                              popup(events, e, context);
                                            } else {
                                              print("pas clickable");
                                            }
                                          })
                                      : Container(),
                                  //création d'un bouton uniquement si clickable
                                ),
                                clipper: MyClipper(e.svgpath, orientation,
                                    paths.xScaleh, paths.yScaleh));
                          }).toList()
                        ]))))));
      }
    });
  }
}
