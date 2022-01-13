import 'package:flutter/material.dart';
import 'package:learn/paths.dart';
import 'package:learn/MyClipper.dart';

class PlanPortrait extends StatefulWidget {
  const PlanPortrait({Key? key}) : super(key: key);

  @override
  State<PlanPortrait> createState() => _PlanPortrait();
}

class _PlanPortrait extends State<PlanPortrait> {
  @override
  _PlanPortrait();
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
                    print(e.name); //mettre la sortie de clique ici
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
  const PlanLandscape({Key? key}) : super(key: key);

  @override
  State<PlanLandscape> createState() => _PlanLandscape();
}

class _PlanLandscape extends State<PlanLandscape> {
  @override
  _PlanLandscape();
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
                    print(e.name); //mettre la sortie de clique ici
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
