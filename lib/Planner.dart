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
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    var elevation = 3.0;
    return Stack(children: [
      PageView(
          controller: pageController,
          onPageChanged: (index) => {
                setState(() {
                  _selected = index;
                })
              },
          children: List.generate(
              ENSIBS_Vannes.nb_floors,
              (index) => Floor(
                    floor: index,
                    events: events,
                    batiment: ENSIBS_Vannes,
                    elevation: elevation,
                  ))),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 30,
              width: 180,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color(0xCF64C8C8),
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              child: const Text('Batiment : ENSIBS Vannes'),
            )),
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 30,
              width: 90,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(0.0),
              decoration: const BoxDecoration(
                  color: Color(0xCF64C8C8),
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              child: PopupMenuButton(
                color: const Color(0xCF64C8C8),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Center(child: Text('Etage : $_selected')),
                itemBuilder: (context) {
                  return List.generate(ENSIBS_Vannes.nb_floors, (index) {
                    return PopupMenuItem(
                        value: index, child: Text('Etage : $index'));
                  });
                },
                onSelected: (int index) {
                  setState(() => _selected = index);
                  pageController.animateToPage(index,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 300));
                },
              ),
            ))
      ]),
    ]);
  }
}
