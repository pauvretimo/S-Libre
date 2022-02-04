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
        events,
      );
}

class _ClipShadowedPathclicker extends State<ClipShadowedPathclicker> {
  BoxShadow shadow;
  Offset offset;
  Paths paths;
  List<EventCalendar> events;
  _ClipShadowedPathclicker(this.offset, this.shadow, this.paths, this.events);
  @override
  Widget build(BuildContext context) {
    // on gère l'orientation du plan

    return OrientationBuilder(builder: (context, orientation) {
      // portrait

      if (orientation == Orientation.portrait) {
        // le center permet d'empêcher le widget PageView de casser le ratio fixe du AspectRatio
        return Center(
            // fixe le ratio des cartes
            child: AspectRatio(
                aspectRatio: 9 / 16,
                // Laisse un espace au bord de la carte
                child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width / 1000),
                    // La carte en question
                    child: Card(
                        elevation: 2.0,
                        child: Stack(key: UniqueKey(), children: [
                          ...paths.verticalpaths.map((e) {
                            // ombres
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
                            // dessins
                            return ClipPath(
                                child: Material(
                                    child: e.clickable
                                        ? InkWell(
                                            child: null,
                                            onTap: () {
                                              popup(events, e, context);
                                            })
                                        : Container(),
                                    color: e.color),
                                clipper: MyClipper(e.svgpath, orientation,
                                    paths.xScalev, paths.yScalev));
                          }).toList()
                        ])))));

        // paysage

      } else {
        return Center(
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height / 1000),
                    child: Card(
                        elevation: 2.0,
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
                                    child: e.clickable
                                        ? InkWell(
                                            child: null,
                                            onTap: () {
                                              popup(events, e, context);
                                            })
                                        : Container(),
                                    color: e.color),
                                clipper: MyClipper(e.svgpath, orientation,
                                    paths.xScaleh, paths.yScaleh));
                          }).toList()
                        ])))));
      }
    });
  }
}
