import 'package:flutter/material.dart';
import 'package:learn/Globals.dart';
import 'package:learn/Batiments.dart';
import 'package:learn/bottommenu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:learn/Datetimepicker.dart';
import 'package:learn/SettingsMenu.dart';
import 'dart:async';

class Plan extends StatefulWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  State<Plan> createState() => _Plan();
}

class _Plan extends State<Plan> {
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        kSelectedFloor.value = pageController.page!.toInt();
      });

      batController.addListener(
        () {
          kSelectedBat.value = listBat[batController.page!.toInt()];
        },
      );
    });
  }

  PageController pageController = PageController(
    initialPage: kSelectedFloor.value,
    keepPage: true,
  );
  PageController batController = PageController(
    initialPage: listBat.indexOf(kSelectedBat.value),
    keepPage: true,
  );

  PageController pickcontroller = PageController();

  bool elevation = true;
  ValueNotifier<double> pos = ValueNotifier<double>(0.0);
  final PanelController _pc = PanelController();
  final PanelController _sc = PanelController();

// Callbacks
  void scrollcallback() {
    _pc.isPanelOpen ? _pc.close() : _pc.open();
  }

  void batCallback(int floor, [int? bat]) async {
    if (bat != null) {
      batController.jumpToPage(bat);
    }
    await pageController.animateToPage(floor,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    Timer refresh = Timer.periodic(Duration(seconds: 10), (timer) {
      kSelectedBat.value.updateBat();
    });
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  // Création des pages de batiments
                  //    Chaque page est composé d'un widget Floor qui permet de gérer l'ombre, et de créer un
                  //    widget clipshadowpathclicker pour un étage donné pour un batiment donné

                  PageView(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: batController,
                    children: List.generate(
                      listBat.length,
                      (index) => Batiment(
                          batiment: listBat[index],
                          pagecontroller: pageController),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SlidingUpPanel(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 10.0,
            right: MediaQuery.of(context).size.width / 10.0,
            top: MediaQuery.of(context).size.height / 10.0,
          ),
          onPanelSlide: (e) {
            pos.value = e;
          },
          renderPanelSheet: false,
          minHeight: 50.0,
          maxHeight: 4 * MediaQuery.of(context).size.height / 5,
          panel: bottomDrawer(pos, scrollcallback, batCallback, _sc),
        ),
        SlidingUpPanel(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 12.0,
              right: MediaQuery.of(context).size.width / 12.0),
          renderPanelSheet: false,
          controller: _pc,
          isDraggable: false,
          borderRadius: const BorderRadius.all(Radius.circular(35)),
          minHeight: 0.0,
          maxHeight: MediaQuery.of(context).size.height,
          panel: PageView(
            controller: pickcontroller,
            children: [
              TimePicker(
                controller: _pc,
              ),
            ],
          ),
        ),
        SlidingUpPanel(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 12.0,
              right: MediaQuery.of(context).size.width / 12.0),
          renderPanelSheet: false,
          controller: _sc,
          isDraggable: false,
          borderRadius: const BorderRadius.all(Radius.circular(35)),
          minHeight: 0.0,
          maxHeight: MediaQuery.of(context).size.height,
          panel: SettingMenu(closer: _sc),
        ),
      ],
    );
  }
}
