import 'package:flutter/material.dart';
import 'package:learn/listpath.dart';

//nom de salles
//['V-TO-ENSIBS-D003', 'V-TO-ENSIBS-D113', 'Y-TO-ENSIBS-D106', 'V-TO-ENSIBS-A104', 'V-TO-ENSIBS-A106', 'L-ENSIBS- ', 'V-TO-ENSIbs-A105-107', 'V-TO-ENSIbs-A102 TBI', 'V-TO-ENSIBS-D010', 'V-TO-ENSIBS-TMP-TP', 'V-TO-ENSIBS-TMP-TD', 'V-TO-ENSIbs - B001 amphi', 'V-TO-ENSIBS-D105', 'V-TO-ENSIbs-D101', 'V-TO-ENSIBS-D005', 'V-TO-ENSIbs - B001 amphi', 'V-TO-ENSIbs-CyberLab-SAIM-D111', 'V-TO-YC-F097', 'V-TO-ENSIbs - TMP info', 'V-TO-YC-D170', 'V-TO-YC-D072', 'V-TO-YC-F195', 'V-TO-ENSIbs - GrandeSalle virtuelle', 'V-TO-YC-D172', 'V-TO-YC-AMPHI', 'V-TO-ENSIBS-B002', 'V-TO-ENSIBS-B003', 'V-TO-YC-E083', 'V-TO-YC-D070', 'Salle non réservée', 'V-TO-ENSIbs-TMP-TD', 'V-TO-YC-D176', 'V-TO-YC-D075', 'V-TO-YC-E084', 'V-TO-YC-F092', 'V-TO-YC-E184', 'V-TO-YC-D076', 'V-TO-YC-D174', 'V-TO-YC-D171', 'V-TO-YC-D074', 'à distance', 'V-TO-YC-E182', 'V-TO-YC-D173', 'V-TO-YC-F191 (langues)', 'Moodle/Teams/Via', 'V-TO-YC-D177', 'A 150 V-DSEG', 'A 500 V-DSEG', 'V-TO-YC-D077-VBI', 'V-TO-YC-D079-TBI', 'L-SM-Aucune']

class Room {
  String svgpath;
  Color color;
  String name;
  String id;

  Room(this.svgpath, this.color, this.name, this.id);
}

class Paths {
  List<Room> verticalpaths;
  List<Room> horizontalpaths;
  int xScaleh;
  int yScaleh;
  int xScalev;
  int yScalev;

  Paths(this.verticalpaths, this.horizontalpaths, this.xScalev, this.yScalev,
      this.xScaleh, this.yScaleh);
}

//ENSIBS Vannes RDC

Paths ENSIBSVannesRDCpaths = Paths(
    pathslistENSIBSVannesRDCv
        .map((e) => (Room(
            e[0] as String, e[1] as Color, e[2] as String, e[3] as String)))
        .toList(),
    pathslistENSIBSVannesRDCh
        .map((e) => (Room(
            e[0] as String, e[1] as Color, e[2] as String, e[3] as String)))
        .toList(),
    1300,
    2500,
    6500,
    3600);

//ENSIBS Vannes Etage 1

Paths ENSIBSVannesE1paths = Paths(
    pathslistENSIBSVannesE1v
        .map((e) => (Room(
            e[0] as String, e[1] as Color, e[2] as String, e[3] as String)))
        .toList(),
    pathslistENSIBSVannesE1h
        .map((e) => (Room(
            e[0] as String, e[1] as Color, e[2] as String, e[3] as String)))
        .toList(),
    1300,
    2500,
    2450,
    1380);

class Bat {
  List<Paths> bat;
  int nb_floors;
  Bat(this.bat, this.nb_floors);
}

Bat ENSIBS_Vannes = Bat([ENSIBSVannesRDCpaths, ENSIBSVannesE1paths], 2);
