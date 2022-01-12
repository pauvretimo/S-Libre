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
  _Plan(this.ratio);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: (ratio[0] as int) / (ratio[1] as int),
        child: Stack(
          children: pathsv.map((e) {
            return ClipPath(
              // widget prenant un path et qui permet d'inclure les widgets soujacents dans la forme du Clipath
              child: Material(
                child: InkWell(
                  child: null,
                  onTap: () {
                    print(e[1]); //mettre la sortie de clique ici
                  },
                ),
                color: (e[1]
                    as Color), //couleur du material ie de la forme (inkwell et clipath ne permettent pas de colorier)
              ),
              clipper: MyClipper(e[0] as String),
            );
          }).toList(),
        ));
  }
}
