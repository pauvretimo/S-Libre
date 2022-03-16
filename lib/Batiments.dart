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
  State<Batiment> createState() => _Batiment();
}

class _Batiment extends State<Batiment> {
  @override
  Widget build(BuildContext context) {
    List<EventCalendar> events = widget.events;
    Bat batiment = widget.batiment;
    PageController pagecontroller = widget.pagecontroller;
    return PageView(
      controller: pagecontroller,
      physics: const BouncingScrollPhysics(),
      children: List.generate(
        batiment.nb_floors,
        (index) {
          return ClipShadowedPathclicker(
              // gestion de l'étage
              paths: batiment.bat[index],
              events: events);
        },
      ),
    );
  }
}
