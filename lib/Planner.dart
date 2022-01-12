import 'package:flutter/material.dart';
import 'package:learn/paths.dart';
import 'package:learn/MyClipper.dart';

class Plan extends StatefulWidget {
  const Plan({Key? key, required this.ratio}) : super(key: key);
  final List<int> ratio;

  @override
  State<Plan> createState() => _Plan(ratio);
}

class _Plan extends State<Plan> {
  final List<int> ratio;
  @override
  _Plan(this.ratio);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: (ratio[0]) / (ratio[1]),
        child: Stack(
          children: paths.verticalpaths.map((e) {
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
