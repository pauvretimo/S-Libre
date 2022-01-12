import 'package:flutter/material.dart';
import 'package:learn/paths.dart';
import 'package:learn/MyClipper.dart';

class PlanPortrait extends StatefulWidget {
  const PlanPortrait({Key? key, required this.ratio}) : super(key: key);
  final List<int> ratio;

  @override
  State<PlanPortrait> createState() => _PlanPortrait(ratio);
}

class _PlanPortrait extends State<PlanPortrait> {
  final List<int> ratio;
  @override
  _PlanPortrait(this.ratio);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: (ratio[1]) / (ratio[0]),
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
              clipper: MyClipper(e.svgpath),
            );
          }).toList(),
        ));
  }
}

class PlanLandscape extends StatefulWidget {
  const PlanLandscape({Key? key, required this.ratio}) : super(key: key);
  final List<int> ratio;

  @override
  State<PlanLandscape> createState() => _PlanLandscape(ratio);
}

class _PlanLandscape extends State<PlanLandscape> {
  final List<int> ratio;
  @override
  _PlanLandscape(this.ratio);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: (ratio[1]) / (ratio[0]),
        child: Stack(
          children: paths.horizontalpaths.map((e) {
            return ClipPath(
              // widget prenant un path et qui permet d'inclure les widgets soujacents dans la forme du Clipath
              child: Material(
                child: InkWell(
                  child: null,
                  onTap: () {
                    print(e.color); //mettre la sortie de clique ici
                  },
                ),
                color: (e
                    .color), //couleur du material ie de la forme (inkwell et clipath ne permettent pas de colorier)
              ),
              clipper: MyClipper(e.svgpath),
            );
          }).toList(),
        ));
  }
}
