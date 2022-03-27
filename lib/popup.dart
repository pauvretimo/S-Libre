import 'package:learn/Globals.dart';
import 'package:learn/paths.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

void popup(Room salle, BuildContext context) {
  String dispo = "";
  if (salle.color == kSalleOccupee) {
    dispo = "La salle n'est pas disponible";
  } else if (salle.color == kSalleLibre) {
    dispo = "La salle est disponible";
  } else {
    dispo = "La salle est bientôt occupée";
  }
  Alert(
          style: AlertStyle(
              overlayColor: const Color(0x10000000),
              backgroundColor: const Color(0x5F000000),
              titleStyle: TextStyle(
                color: salle.color,
                fontWeight: FontWeight.w400,
                fontFamily: "Dongle",
                fontSize: 50,
              ),
              descStyle: TextStyle(
                color: salle.color,
                fontWeight: FontWeight.w400,
                fontFamily: "Dongle",
                fontSize: 40,
              )),
          context: context,
          title: salle.name,
          desc: dispo)
      .show();
}

bool isTimoteABigBigBeauGosse() {
  return true;
}
