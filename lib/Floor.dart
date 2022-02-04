import 'package:flutter/cupertino.dart';
import 'package:learn/Shadowz.dart';
import 'package:learn/paths.dart';
import 'package:learn/requests.dart';

class Floor extends StatefulWidget {
  final int floor;
  final List<EventCalendar> events;
  final Bat batiment;
  final String nom;
  const Floor({
    Key? key,
    required this.floor,
    required this.events,
    required this.batiment,
    required this.nom,
  }) : super(key: key);

  @override
  State<Floor> createState() => _Floor(events, batiment, floor, nom);
}

class _Floor extends State<Floor> {
  List<EventCalendar> events;
  int floor;
  Bat batiment;
  String nom;
  @override
  _Floor(this.events, this.batiment, this.floor, this.nom);
  @override
  Widget build(BuildContext context) {
    return ClipShadowedPathclicker(
        // gestion de l'ombre
        shadow: const BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 30,
            spreadRadius: 10,
            color: Color(0x6AEFEFFF)),
        floor: floor,
        bat: nom,
        // gestion de l'étage
        paths: batiment.bat[floor],
        events: events);
  }
}
