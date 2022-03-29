import 'package:flutter/material.dart';
import 'package:learn/MyClipper.dart';
import 'package:learn/popup.dart';
import 'package:learn/paths.dart';

@immutable
class ClipShadowedPathclicker extends StatelessWidget {
  final Paths paths;

// Salles avec les ombres mais sans les textes
  const ClipShadowedPathclicker({
    required this.paths,
  });

  @override
  Widget build(BuildContext context) {
    // on gère l'orientation du plan

    return OrientationBuilder(
      builder: (context, orientation) {
        // portrait
        if (paths.wip == true) {
          return const WIP();
        } else {
          if (orientation == Orientation.portrait) {
            // le center permet d'empêcher le widget PageView de casser le ratio fixe du AspectRatio
            return Center(
              // fixe le ratio des cartes
              child: AspectRatio(
                aspectRatio: 9 / 16,
                // Laisse un espace au bord de la carte
                child: Card(
                  color: Theme.of(context).colorScheme.surface,
                  child: Stack(
                    key: UniqueKey(),
                    children: [
                      ...paths.verticalpaths.map((e) {
                        // ombres
                        return Transform.translate(
                          offset: const Offset(2.5, 2.5),
                          child: ClipPath(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 4,
                                    color: Theme.of(context).colorScheme.shadow,
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
                                          popup(e, context);
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
                  color: Theme.of(context).colorScheme.surface,
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 50),
                  child: Stack(
                    key: UniqueKey(),
                    children: [
                      ...paths.horizontalpaths.map((e) {
                        return Transform.translate(
                            offset: const Offset(2.5, 2.5),
                            child: ClipPath(
                                child: Container(
                                    decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 4,
                                    color: Theme.of(context).colorScheme.shadow,
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
                                          popup(e, context);
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
        }
      },
    );
  }
}

// salle sans les ombres ni les textes
@immutable
class ClipPathclicker extends StatelessWidget {
  final Paths paths;

  const ClipPathclicker({
    required this.paths,
  });

  @override
  Widget build(BuildContext context) {
    Color shadowColor = Theme.of(context).colorScheme.shadow;
    // on gère l'orientation du plan

    return OrientationBuilder(
      builder: (context, orientation) {
        // portrait
        if (paths.wip == true) {
          return const WIP();
        } else {
          if (orientation == Orientation.portrait) {
            // le center permet d'empêcher le widget PageView de casser le ratio fixe du AspectRatio
            return Center(
              // fixe le ratio des cartes
              child: AspectRatio(
                aspectRatio: 9 / 16,
                // Laisse un espace au bord de la carte
                child: Card(
                  color: Theme.of(context).colorScheme.surface,
                  child: Stack(
                      key: UniqueKey(),
                      children: paths.verticalpaths.map(
                        (e) {
                          // dessins
                          return ClipPath(
                            child: Material(
                                child: e.clickable
                                    ? InkWell(
                                        child: null,
                                        onTap: () {
                                          popup(e, context);
                                        })
                                    : Container(),
                                color: e.color),
                            clipper: MyClipper(e.svgpath, orientation,
                                paths.xScalev, paths.yScalev),
                          );
                        },
                      ).toList()),
                ),
              ),
            );

            // paysage

          } else {
            return Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Card(
                  color: Theme.of(context).colorScheme.surface,
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 50),
                  child: Stack(
                      key: UniqueKey(),
                      children: paths.horizontalpaths.map(
                        (e) {
                          return ClipPath(
                            child: Material(
                                child: e.clickable
                                    ? InkWell(
                                        child: null,
                                        onTap: () {
                                          popup(e, context);
                                        },
                                      )
                                    : Container(),
                                color: e.color),
                            clipper: MyClipper(e.svgpath, orientation,
                                paths.xScaleh, paths.yScaleh),
                          );
                        },
                      ).toList()),
                ),
              ),
            );
          }
        }
      },
    );
  }
}

@immutable
class ClipShadowedPathclickerTxt extends StatelessWidget {
  final Paths paths;

// Salles avec les ombres et avec les textes
  const ClipShadowedPathclickerTxt({
    required this.paths,
  });

  @override
  Widget build(BuildContext context) {
    // on gère l'orientation du plan

    return OrientationBuilder(
      builder: (context, orientation) {
        // portrait
        if (paths.wip == true) {
          return const WIP();
        } else {
          if (orientation == Orientation.portrait) {
            double height = MediaQuery.of(context).size.height;
            double width = MediaQuery.of(context).size.width;
            Offset offset = width * 16 / 9 < height
                ? Offset(width, width * 16 / 9)
                : Offset(height * 9 / 16, height);
            // le center permet d'empêcher le widget PageView de casser le ratio fixe du AspectRatio
            return Center(
              // fixe le ratio des cartes
              child: AspectRatio(
                aspectRatio: 9 / 16,
                // Laisse un espace au bord de la carte
                child: Card(
                  color: Theme.of(context).colorScheme.surface,
                  child: Stack(
                    key: UniqueKey(),
                    children: paths.verticalpaths
                        .map((e) {
                          MyClipper clip = MyClipper(e.svgpath, orientation,
                              paths.xScalev, paths.yScalev);
                          return [
                            Transform.translate(
                              offset: const Offset(2.5, 2.5),
                              child: ClipPath(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 4,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .shadow,
                                      ),
                                    ],
                                  ),
                                ),
                                clipper: clip,
                              ),
                            ),
                            ClipPath(
                              child: Material(
                                  child: e.clickable
                                      ? InkWell(
                                          child: Center(
                                            child: Text(
                                              e.name,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          onTap: () {
                                            popup(e, context);
                                          },
                                        )
                                      : Container(),
                                  color: e.color),
                              clipper: clip,
                            ),
                            SizedBox(
                              height: 100.0 * offset.dy / 832.0,
                              width: 55.0 * offset.dx / 652,
                              child: e.clickable
                                  ? Transform.translate(
                                      offset: Offset(
                                          offset.dx *
                                              e.offset.dx /
                                              paths.xScalev,
                                          offset.dy *
                                              e.offset.dy /
                                              paths.yScalev),
                                      child: FittedBox(
                                        alignment: Alignment.topCenter,
                                        child: SizedBox(
                                          width: 55,
                                          child: Text(
                                            e.name,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ];
                        })
                        .expand((i) => i)
                        .toList(),
                  ),
                ),
              ),
            );

            // paysage

          } else {
            double height = MediaQuery.of(context).size.height;
            double width = MediaQuery.of(context).size.width;
            Offset offset = height * 16 / 9 < width
                ? Offset(height * 16 / 9, height)
                : Offset(width, width * 9 / 16);
            return Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Card(
                  color: Theme.of(context).colorScheme.surface,
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 50),
                  child: Stack(
                    key: UniqueKey(),
                    children: paths.horizontalpaths
                        .map((e) {
                          MyClipper clip = MyClipper(e.svgpath, orientation,
                              paths.xScaleh, paths.yScaleh);
                          return [
                            Transform.translate(
                              offset: const Offset(2.5, 2.5),
                              child: ClipPath(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 4,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .shadow,
                                      ),
                                    ],
                                  ),
                                ),
                                clipper: clip,
                              ),
                            ),
                            ClipPath(
                              child: Material(
                                  child: e.clickable
                                      ? InkWell(
                                          child: Center(
                                            child: Text(
                                              e.name,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          onTap: () {
                                            popup(e, context);
                                          },
                                        )
                                      : Container(),
                                  color: e.color),
                              clipper: clip,
                            ),
                            SizedBox(
                              height: 100.0 * offset.dy / 545.0,
                              width: 55.0 * offset.dy / 945.0,
                              child: e.clickable
                                  ? Transform.translate(
                                      offset: Offset(
                                          offset.dx *
                                              e.offset.dx /
                                              paths.xScaleh,
                                          offset.dy *
                                              e.offset.dy /
                                              paths.yScaleh),
                                      child: FittedBox(
                                        alignment: Alignment.topCenter,
                                        child: SizedBox(
                                          width: 55,
                                          child: Text(
                                            e.name,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ];
                        })
                        .expand((i) => i)
                        .toList(),
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}

// salle sans les ombres mais avec les textes
@immutable
class ClipPathclickerTxt extends StatelessWidget {
  final Paths paths;

  const ClipPathclickerTxt({
    required this.paths,
  });

  @override
  Widget build(BuildContext context) {
    // on gère l'orientation du plan

    return OrientationBuilder(
      builder: (context, orientation) {
        // portrait
        if (paths.wip == true) {
          return const WIP();
        } else {
          if (orientation == Orientation.portrait) {
            double height = MediaQuery.of(context).size.height;
            double width = MediaQuery.of(context).size.width;
            Offset offset = width * 16 / 9 < height
                ? Offset(width, width * 16 / 9)
                : Offset(height * 9 / 16, height);
            // le center permet d'empêcher le widget PageView de casser le ratio fixe du AspectRatio
            return Center(
              // fixe le ratio des cartes
              child: AspectRatio(
                aspectRatio: 9 / 16,
                // Laisse un espace au bord de la carte
                child: Card(
                  color: Theme.of(context).colorScheme.surface,
                  child: Stack(
                    key: UniqueKey(),
                    children: paths.verticalpaths
                        .map((e) {
                          MyClipper clip = MyClipper(e.svgpath, orientation,
                              paths.xScalev, paths.yScalev);
                          return [
                            ClipPath(
                              child: Material(
                                  child: e.clickable
                                      ? InkWell(
                                          child: Center(
                                            child: Text(
                                              e.name,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          onTap: () {
                                            print(MediaQuery.of(context).size);
                                            popup(e, context);
                                          },
                                        )
                                      : Container(),
                                  color: e.color),
                              clipper: clip,
                            ),
                            SizedBox(
                              height: 100.0 * offset.dy / 832.0,
                              width: 55.0 * offset.dx / 652,
                              child: e.clickable
                                  ? Transform.translate(
                                      offset: Offset(
                                          offset.dx *
                                              e.offset.dx /
                                              paths.xScalev,
                                          offset.dy *
                                              e.offset.dy /
                                              paths.yScalev),
                                      child: FittedBox(
                                        alignment: Alignment.topCenter,
                                        child: SizedBox(
                                          width: 55,
                                          child: Text(
                                            e.name,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ];
                        })
                        .expand((i) => i)
                        .toList(),
                  ),
                ),
              ),
            );

            // paysage

          } else {
            double height = MediaQuery.of(context).size.height;
            double width = MediaQuery.of(context).size.width;
            Offset offset = height * 16 / 9 < width
                ? Offset(height * 16 / 9, height)
                : Offset(width, width * 9 / 16);
            return Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Card(
                  color: Theme.of(context).colorScheme.surface,
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 50),
                  child: Stack(
                    key: UniqueKey(),
                    children: paths.horizontalpaths
                        .map((e) {
                          MyClipper clip = MyClipper(e.svgpath, orientation,
                              paths.xScaleh, paths.yScaleh);
                          return [
                            ClipPath(
                              child: Material(
                                  child: e.clickable
                                      ? InkWell(
                                          child: Center(
                                            child: Text(
                                              e.name,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          onTap: () {
                                            popup(e, context);
                                          },
                                        )
                                      : Container(),
                                  color: e.color),
                              clipper: clip,
                            ),
                            SizedBox(
                              height: 100.0 * offset.dy / 545.0,
                              width: 55.0 * offset.dy / 945.0,
                              child: e.clickable
                                  ? Transform.translate(
                                      offset: Offset(
                                          offset.dx *
                                              e.offset.dx /
                                              paths.xScaleh,
                                          offset.dy *
                                              e.offset.dy /
                                              paths.yScaleh),
                                      child: FittedBox(
                                        alignment: Alignment.topCenter,
                                        child: SizedBox(
                                          width: 55,
                                          child: Text(
                                            e.name,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ];
                        })
                        .expand((i) => i)
                        .toList(),
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}

class WIP extends StatelessWidget {
  const WIP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height / 8.0;
    return Center(
      child: Text(
        'W.I.P',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
