import 'package:flutter/cupertino.dart';
import 'package:learn/Globals.dart';
import 'package:learn/Shadowz.dart';
import 'package:learn/paths.dart';

class Batiment extends StatefulWidget {
  final Bat batiment;
  final PageController pagecontroller;
  const Batiment({
    Key? key,
    required this.batiment,
    required this.pagecontroller,
  }) : super(key: key);

  @override
  State<Batiment> createState() => _Batiment();
}

class _Batiment extends State<Batiment> {
  @override
  Widget build(BuildContext context) {
    Bat batiment = widget.batiment;
    batiment.updateBat();
    PageController pagecontroller = widget.pagecontroller;
    return ValueListenableBuilder3(
      valuelistenable1: kAfficheLesNoms,
      valuelistenable2: kAfficheLesOmbres,
      valuelistenable3: kToUpdate,
      builder: (context, bool value1, bool value2, bool value3, child) {
        return PageView(
          controller: pagecontroller,
          physics: const BouncingScrollPhysics(),
          children: List.generate(
            batiment.nb_floors,
            (index) {
              if (value1 && value2) {
                return ClipShadowedPathclickerTxt(
                  paths: batiment.bat[index],
                );
              } else if (value1 && !value2) {
                return ClipPathclickerTxt(
                  paths: batiment.bat[index],
                );
              } else if (!value1 && value2) {
                return ClipShadowedPathclicker(
                  paths: batiment.bat[index],
                );
              } else {
                return ClipPathclicker(
                  paths: batiment.bat[index],
                );
              }
            },
          ),
        );
      },
    );
  }
}
