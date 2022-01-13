import 'package:flutter/material.dart';
import 'package:learn/paths.dart';
import 'package:learn/MyClipper.dart';
import 'package:learn/requests.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PlanPortrait extends StatefulWidget {
  final List<EventCalendar> events;
  const PlanPortrait({Key? key, required this.events}) : super(key: key);

  @override
  State<PlanPortrait> createState() => _PlanPortrait(events: this.events);
}

class _PlanPortrait extends State<PlanPortrait> {
  List<EventCalendar> events;
  @override
  _PlanPortrait({required this.events});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 9 / 16,
        child: Stack(
          children: paths.verticalpaths.map((e) {
            return ClipPath(
              // widget prenant un path et qui permet d'inclure les widgets soujacents dans la forme du Clipath
              child: Material(
                child: InkWell(
                  child: null,
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                    List<EventCalendar> data = this
                        .events
                        .where((ev) => (ev.location == e.id))
                        .toList();

                    print(e.name + " - " + e.id);
                    Alert(
                            style: AlertStyle(
                                overlayColor: Color(0x10000000),
                                backgroundColor: Color(0x7F000000),
                                titleStyle: TextStyle(color: Color(0xFF00FF00)),
                                descStyle: TextStyle(color: Color(0xFF00FF00))),
                            context: context,
                            title: e.name,
                            desc: "La salle est libre")
                        .show(); //mettre la sortie de clique ici
                    print(
                        e.name + " - " + e.id); //mettre la sortie de clique ici
                  },
                ),
                color: (e
                    .color), //couleur du material ie de la forme (inkwell et clipath ne permettent pas de colorier)
              ),
              clipper: MyClipperPortrait(e.svgpath),
            );
          }).toList(),
        ));
  }
}

class PlanLandscape extends StatefulWidget {
  final List<EventCalendar> events;
  const PlanLandscape({Key? key, required this.events}) : super(key: key);

  @override
  State<PlanLandscape> createState() => _PlanLandscape(events: this.events);
}

class _PlanLandscape extends State<PlanLandscape> {
  List<EventCalendar> events;
  @override
  _PlanLandscape({required this.events});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: paths.horizontalpaths.map((e) {
            return ClipPath(
              // widget prenant un path et qui permet d'inclure les widgets soujacents dans la forme du Clipath
              child: Material(
                child: InkWell(
                  child: null,
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                    List<EventCalendar> data = this
                        .events
                        .where((ev) => (ev.location == e.id))
                        .toList();

                    print(e.name + " - " + e.id);
                    Alert(
                            style: AlertStyle(
                                overlayColor: Color(0x10000000),
                                backgroundColor: Color(0x7F000000),
                                titleStyle: TextStyle(color: Color(0xFF00FF00)),
                                descStyle: TextStyle(color: Color(0xFF00FF00))),
                            context: context,
                            title: e.name,
                            desc: "La salle est libre")
                        .show(); //mettre la sortie de clique ici
                  },
                ),
                color: (e
                    .color), //couleur du material ie de la forme (inkwell et clipath ne permettent pas de colorier)
              ),
              clipper: MyClipperLandscape(e.svgpath),
            );
          }).toList(),
        ));
  }
}
