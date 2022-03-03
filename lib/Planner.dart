import 'package:flutter/material.dart';
import 'package:learn/paths.dart';
import 'package:learn/requests.dart';
import 'package:learn/Floor.dart';
import 'package:learn/bottommenu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:learn/Datetimepicker.dart';

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

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {});
    });
  }

  var _selected = 0;
  int _bat = 0;
  var batname = listbatname[0];
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  PageController pickcontroller = PageController();

  bool elevation = true;
  ValueNotifier<double> pos = ValueNotifier<double>(0.0);
  final PanelController _pc = PanelController();

  @override
  Widget build(BuildContext context) {
// Callbacks
    void scrollcallback() {
      _pc.isPanelOpen ? _pc.close() : _pc.open();
    }

    return Stack(children: [
      SlidingUpPanel(
        onPanelSlide: (e) {
          pos.value = e;
        },
        renderPanelSheet: false,
        minHeight: 50.0,
        panel: bottomDrawer(pageController, pos, scrollcallback),
        body: (Column(children: [
          Expanded(
            child: Stack(children: [
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
            ]),
          ),
          Container(height: 50.0),
        ])),
      ),
      SlidingUpPanel(
        defaultPanelState: PanelState.OPEN,
        renderPanelSheet: false,
        controller: _pc,
        isDraggable: false,
        borderRadius: const BorderRadius.all(Radius.circular(35)),
        minHeight: 0.0,
        maxHeight: MediaQuery.of(context).size.height,
        panel: PageView(controller: pickcontroller, children: [
          TimePicker(),
        ]),
      ),
    ]);
  }
}
