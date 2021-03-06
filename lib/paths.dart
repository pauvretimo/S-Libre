import 'package:flutter/material.dart';
import 'package:learn/Globals.dart';
import 'package:learn/listpath.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

//nom de salles
//['V-TO-ENSIBS-D003', 'V-TO-ENSIBS-D113', 'Y-TO-ENSIBS-D106', 'V-TO-ENSIBS-A104', 'V-TO-ENSIBS-A106', 'L-ENSIBS- ', 'V-TO-ENSIbs-A105-107', 'V-TO-ENSIbs-A102 TBI', 'V-TO-ENSIBS-D010', 'V-TO-ENSIBS-TMP-TP', 'V-TO-ENSIBS-TMP-TD', 'V-TO-ENSIbs - B001 amphi', 'V-TO-ENSIBS-D105', 'V-TO-ENSIbs-D101', 'V-TO-ENSIBS-D005', 'V-TO-ENSIbs - B001 amphi', 'V-TO-ENSIbs-CyberLab-SAIM-D111', 'V-TO-YC-F097', 'V-TO-ENSIbs - TMP info', 'V-TO-YC-D170', 'V-TO-YC-D072', 'V-TO-YC-F195', 'V-TO-ENSIbs - GrandeSalle virtuelle', 'V-TO-YC-D172', 'V-TO-YC-AMPHI', 'V-TO-ENSIBS-B002', 'V-TO-ENSIBS-B003', 'V-TO-YC-E083', 'V-TO-YC-D070', 'Salle non réservée', 'V-TO-ENSIbs-TMP-TD', 'V-TO-YC-D176', 'V-TO-YC-D075', 'V-TO-YC-E084', 'V-TO-YC-F092', 'V-TO-YC-E184', 'V-TO-YC-D076', 'V-TO-YC-D174', 'V-TO-YC-D171', 'V-TO-YC-D074', 'à distance', 'V-TO-YC-E182', 'V-TO-YC-D173', 'V-TO-YC-F191 (langues)', 'Moodle/Teams/Via', 'V-TO-YC-D177', 'A 150 V-DSEG', 'A 500 V-DSEG', 'V-TO-YC-D077-VBI', 'V-TO-YC-D079-TBI', 'L-SM-Aucune']

/// La classe Room correspond à une salle
/// Le [svgpath] correspond au chemin svg d'une salle
/// [color] est la couleur de la salle
/// [name] sert à l'affichage du nom de la salle
/// et [id] sert pour identifier une salle (au cas où)
/// Le paramètre [clickable] est un boolée et
/// il doit être true si la salle peux être accessible en dehors des cours
/// et false si on ne peut pas squatter la salle
class Room {
  Path svgpath;
  Color color;
  String name;
  String id;
  bool clickable;
  Offset offset;
  late List<DateTime> startingHours = [];
  late List<DateTime> endingHours = [];

  Room(this.svgpath, this.color, this.name, this.id, this.clickable,
      this.offset);

  void fromJson(Map<String, dynamic> json) {
    if (json[id] != null) {
      startingHours = json[id]["start"].map<DateTime>((e) {
        return DateTime.parse(e).toLocal();
      }).toList();
      endingHours = json[id]["end"].map<DateTime>((e) {
        return DateTime.parse(e).toLocal();
      }).toList();
    }
  }

  void isFreenow() {
    if (clickable) {
      List<int> candidates = [];
      for (int i = 0; i < endingHours.length; i++) {
        if (endingHours[i].day == kTimeNow.day &&
            endingHours[i].isAfter(kTimeNow)) {
          candidates.add(i);
        }
      }
      color = kSalleLibre;
      int i = 0;
      while (i < candidates.length &&
          (color == kSalleLibre || color == kSalleBientotOccupee)) {
        if (startingHours[candidates[i]].isBefore(kTimeNow)) {
          color = kSalleOccupee;
        } else if (startingHours[candidates[i]]
            .isBefore(kTimeNow.add(const Duration(hours: 1)))) {
          if (color != kSalleOccupee) {
            color = kSalleBientotOccupee;
          }
        }
        i++;
      }
    }
  }

  void isFreeDuring(DateTime start, DateTime end) {
    if (clickable) {
      List<int> candidates = [];
      for (int i = 0; i < endingHours.length; i++) {
        if (endingHours[i].day == start.day && endingHours[i].isAfter(start)) {
          candidates.add(i);
        }
      }
      color = kSalleLibre;
      int i = 0;
      while (i < candidates.length && color == kSalleLibre) {
        if (startingHours[candidates[i]].isBefore(end)) {
          color = kSalleOccupee;
        }
        i++;
      }
    }
  }
}

/* todo: faire une fonction update(le_json_recu_de_l_api) qui prends les heures
* et minutes de début et de fin globales et qui change la couleur des salles
* dans les listes des paths
**/

/// La classe Paths répertorie un ensemble de salles à un même étage
/// Chaque Paths à un nom [name] pour être affiché
/// Les listes [verticalpaths] et [horizontalpaths] servent à  gérer les
/// différentes orientations
/// les quatres paramètres [xScalev], [yScalev], [xScaleh] et [yScaleh]
/// permettent de mettre à l'échelle les différents paths svg
/// lors de l'affichage
class Paths {
  String name;
  List<Room> verticalpaths;
  List<Room> horizontalpaths;
  int xScalev;
  int yScalev;
  int xScaleh;
  int yScaleh;
  bool? wip;

  Paths(this.name, this.verticalpaths, this.horizontalpaths, this.xScalev,
      this.yScalev, this.xScaleh, this.yScaleh,
      [this.wip]);

  void updateRoomsColor() {
    List<int> dayList = [];
    if (kIsSelectSwitched.value) {
      if (kTimeNow.weekday == DateTime.thursday) {
        dayList = [0, 1, 4];
      } else if (kTimeNow.weekday == DateTime.friday) {
        dayList = [0, 3, 4];
      } else if (kTimeNow.weekday == DateTime.saturday) {
        dayList = [2, 3, 4];
      } else if (kTimeNow.weekday == DateTime.sunday) {
        dayList = [1, 2, 3];
      } else {
        dayList = [0, 1, 2];
      }

      DateTime start = kAM_st.value
          ? DateTime(
              kTimeNow.year,
              kTimeNow.month,
              kTimeNow.day + dayList[kSelectedDay.value],
              kStartHour.value,
              kStartMin.value)
          : DateTime(
              kTimeNow.year,
              kTimeNow.month,
              kTimeNow.day + dayList[kSelectedDay.value],
              kStartHour.value + 12,
              kStartMin.value);
      DateTime end = kAM_en.value
          ? DateTime(
              kTimeNow.year,
              kTimeNow.month,
              kTimeNow.day + dayList[kSelectedDay.value],
              kEndHour.value,
              kEndMin.value)
          : DateTime(
              kTimeNow.year,
              kTimeNow.month,
              kTimeNow.day + dayList[kSelectedDay.value],
              kEndHour.value + 12,
              kEndMin.value);

      for (Room i in verticalpaths) {
        i.isFreeDuring(start, end);
      }
      for (Room i in horizontalpaths) {
        i.isFreeDuring(start, end);
      }
    } else {
      for (Room i in verticalpaths) {
        i.isFreenow();
      }
      for (Room i in horizontalpaths) {
        i.isFreenow();
      }
    }
  }

  void parser(Map<String, dynamic> json) {
    for (Room i in verticalpaths) {
      i.fromJson(json);
    }
    for (Room i in horizontalpaths) {
      i.fromJson(json);
    }
  }
}

//Création des class path par étage

//ENSIBS Vannes RDC

Paths ENSIBSVannesRDCpaths = Paths(
    "Rez de Chaussée",
    pathslistENSIBSVannesRDCv
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    pathslistENSIBSVannesRDCh
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    1300,
    2500,
    6500,
    3600);

//ENSIBS Vannes Etage 1

Paths ENSIBSVannesE1paths = Paths(
    "Premier étage",
    pathslistENSIBSVannesE1v
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    pathslistENSIBSVannesE1h
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    1300,
    2500,
    2450,
    1380);

//ENSIBS Lorient RDC
Paths ENSIBSLorientRDCpaths = Paths(
    "Rez de Chaussée",
    pathslistENSIBSLorientE1v
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    pathslistENSIBSLorientE1h
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    1300,
    2500,
    3000,
    2000,
    true);

//ENSIBS Lorient Etage 1

Paths ENSIBSLorientE1paths = Paths(
    "Premier étage",
    pathslistENSIBSLorientE1v
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    pathslistENSIBSLorientE1h
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    1300,
    2500,
    3000,
    2000,
    true);

Paths ENSIBSLorientE2paths = Paths(
    "Deuxième étage",
    pathslistENSIBSLorientE2v
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    pathslistENSIBSLorientE2h
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    1300,
    2500,
    3000,
    2000,
    true);

Paths ENSIBSLorientE3paths = Paths(
    "Troisième étage",
    pathslistENSIBSLorientE1v
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    pathslistENSIBSLorientE1h
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    1300,
    2500,
    3000,
    2000,
    true);

Paths ENSIBSLorientE4paths = Paths(
    "Quatrième étage",
    pathslistENSIBSLorientE1v
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    pathslistENSIBSLorientE1h
        .map((e) => (Room(
            parseSvgPath(e[0] as String),
            e[1] as Color,
            e[2] as String,
            e[3] as String,
            e[4] as bool,
            e.length == 6 ? e[5] as Offset : Offset.zero)))
        .toList(),
    1300,
    2500,
    3000,
    2000,
    true);

/// La class Bat répertorie un nombre de Paths pour former un batiment
/// Elle a également un nom [name] pour être affiché
/// Le nombre d'étages [nb_floors] permet de ne pas avoir à chercher
/// la taille de la liste et facilite le code
class Bat {
  String name;
  List<Paths> bat;
  int nb_floors;
  Bat(this.bat, this.nb_floors, this.name);

  void updateBat() {
    kTimeNow = DateTime.now();
    for (Paths i in bat) {
      i.updateRoomsColor();
    }
  }

  void parser(Map<String, dynamic> json) {
    for (Paths i in bat) {
      i.parser(json);
    }
  }
}

Bat ENSIBS_Vannes =
    Bat([ENSIBSVannesRDCpaths, ENSIBSVannesE1paths], 2, "ENSIBS Vannes");

Bat ENSIBS_Lorient = Bat([
  ENSIBSLorientRDCpaths,
  ENSIBSLorientE1paths,
  ENSIBSLorientE2paths,
  ENSIBSLorientE3paths,
  ENSIBSLorientE4paths
], 5, "ENSIBS Lorient");
