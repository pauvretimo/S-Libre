import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learn/paths.dart';
import 'package:learn/requests.dart';
import 'package:learn/Floor.dart';

class Plan extends StatefulWidget {
  final List<EventCalendar> events;
  const Plan({Key? key, required this.events}) : super(key: key);

  @override
  State<Plan> createState() => _Plan(events: events);
}

class _Plan extends State<Plan> {
  final List<EventCalendar> events;
  @override
  _Plan({required this.events});

  var _selected = 0;
  int _bat = 0;
  var batname = listbatname[0];
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  bool elevation = true;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Création des pages de batiments
      //    Chaque page est composé d'un widget Floor qui permet de gérer l'ombre, et de créer un
      //    widget clipshadowpathclicker pour un étage donné pour un batiment donné

      PageView(
          key: ValueKey(_bat),
          physics: const BouncingScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) => {
                setState(() {
                  _selected = index;
                })
              },
          children: List.generate(
              listbat[_bat].nb_floors,
              (index) => Floor(
                    floor: index,
                    events: events,
                    batiment: listbat[_bat],
                  ))),

      // Boutons d'indication d'étage et de batiment
      //    le padding sert à espacer les boutons entre eux
      //    le matérial gère l'élévation, la forme et la couleur des boutons
      //    le container s'occupe de la taille des boutons
      //    le popupmenubutton permet de faire la liste déroulante pour la sélection des étages / batiment

      Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menu de sélection des étages

            Padding(
                padding: const EdgeInsets.all(5.0),
                child: Material(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    color: const Color(0xCF64C8FF),
                    elevation: 3,
                    child: Container(
                      height: 30,
                      width: 90,
                      alignment: Alignment.center,
                      child: PopupMenuButton(
                        offset: Offset(
                            80, -(listbat[_bat].nb_floors.toDouble() * 45)),
                        color: const Color(0xCF64C8FF),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        child: Center(child: Text('Etage : $_selected')),
                        itemBuilder: (context) {
                          return List.generate(listbat[_bat].nb_floors,
                              (index) {
                            return PopupMenuItem(
                                value: index, child: Text('Etage : $index'));
                          });
                        },
                        onSelected: (int index) {
                          setState(() => _selected = index);
                          pageController.animateToPage(index,
                              curve: Curves.easeIn,
                              duration: const Duration(milliseconds: 300));
                        },
                      ),
                    ))),

            //Menu de sélection des batiments

            Padding(
                padding: const EdgeInsets.all(5.0),
                child: Material(
                  elevation: 3,
                  color: const Color(0xCF64C8FF),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  child: Container(
                    height: 30,
                    width: 180,
                    alignment: Alignment.center,
                    child: PopupMenuButton(
                      offset: const Offset(80, -90),
                      color: const Color(0xCF64C8FF),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      child: Center(child: Text('Batiment : $batname')),
                      itemBuilder: (context) {
                        return List.generate(listbat.length, (index) {
                          return PopupMenuItem(
                              value: index, child: Text('Batiment : $index'));
                        });
                      },
                      onSelected: (int index) {
                        setState(() => _bat = index);
                        setState(() {
                          batname = listbatname[_bat];
                        });
                      },
                    ),
                  ),
                )),
          ]),
    ]);
  }
}
