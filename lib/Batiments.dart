import 'package:flutter/cupertino.dart';
import 'package:learn/Shadowz.dart';
import 'package:learn/paths.dart';
import 'package:learn/requests.dart';

class Batiment extends StatefulWidget {
  final List<EventCalendar> events;
  final Bat batiment;
  final PageController pagecontroller;
  const Batiment({
    Key? key,
    required this.events,
    required this.batiment,
    required this.pagecontroller,
  }) : super(key: key);

  @override
  State<Batiment> createState() => _Batiment(events, batiment, pagecontroller);
}

class _Batiment extends State<Batiment> {
  List<EventCalendar> events;
  Bat batiment;
  PageController pagecontroller;
  @override
  _Batiment(this.events, this.batiment, this.pagecontroller);
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pagecontroller,
      physics: const BouncingScrollPhysics(),
      children: List.generate(
        batiment.nb_floors,
        (index) {
          return ClipShadowedPathclicker(
              // gestion de l'ombre
              shadow: const BoxShadow(
                  offset: Offset(2.5, 2.5),
                  blurRadius: 2,
                  spreadRadius: 4,
                  color: Color(0x4A000000)),
              // gestion de l'étage
              paths: batiment.bat[index],
              events: events);
        },
      ),
    );
  }
}
