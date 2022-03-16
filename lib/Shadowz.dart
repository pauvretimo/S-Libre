import 'package:flutter/material.dart';
import 'package:learn/MyClipper.dart';
import 'package:learn/popup.dart';
import 'package:learn/paths.dart';
import 'package:learn/requests.dart';

@immutable
class ClipShadowedPathclicker extends StatefulWidget {
  final Paths paths;
  final List<EventCalendar> events;

  ClipShadowedPathclicker({
    required this.paths,
    required this.events,
  });
  @override
  State<ClipShadowedPathclicker> createState() => _ClipShadowedPathclicker();
}

class _ClipShadowedPathclicker extends State<ClipShadowedPathclicker> {
  _ClipShadowedPathclicker();
  @override
  Widget build(BuildContext context) {
    Paths paths = widget.paths;
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
            child: Card(
              child: Stack(
                key: UniqueKey(),
                children: [
                  ...paths.verticalpaths.map((e) {
                    // ombres
                    return Transform.translate(
                      offset: const Offset(2.5, 2.5),
                      child: ClipPath(
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 4,
                                color: Color(0x4A000000),
                              ),
                            ],
                          ),
                        ),
                        clipper: MyClipper(e.svgpath, orientation,
                            paths.xScalev, paths.yScalev),
                      ),
                    );
                  }).toList(),
                  ...paths.verticalpaths.map(
                    (e) {
                      // dessins
                      return ClipPath(
                        child: Material(
                            child: e.clickable
                                ? InkWell(
                                    child: null,
                                    onTap: () {
                                      popup(widget.events, e, context);
                                    })
                                : Container(),
                            color: e.color),
                        clipper: MyClipper(e.svgpath, orientation,
                            paths.xScalev, paths.yScalev),
                      );
                    },
                  ).toList()
                ],
              ),
            ),
          ),
        );

        // paysage

      } else {
        return Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Card(
              margin: EdgeInsets.all(MediaQuery.of(context).size.height / 50),
              child: Stack(
                key: UniqueKey(),
                children: [
                  ...paths.horizontalpaths.map((e) {
                    return Transform.translate(
                        offset: const Offset(2.5, 2.5),
                        child: ClipPath(
                            child: Container(
                                decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 4,
                                color: Color(0x4A000000),
                              ),
                            ])),
                            clipper: MyClipper(e.svgpath, orientation,
                                paths.xScaleh, paths.yScaleh)));
                  }).toList(),
                  ...paths.horizontalpaths.map(
                    (e) {
                      return ClipPath(
                        child: Material(
                            child: e.clickable
                                ? InkWell(
                                    child: null,
                                    onTap: () {
                                      popup(widget.events, e, context);
                                    },
                                  )
                                : Container(),
                            color: e.color),
                        clipper: MyClipper(e.svgpath, orientation,
                            paths.xScaleh, paths.yScaleh),
                      );
                    },
                  ).toList()
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
