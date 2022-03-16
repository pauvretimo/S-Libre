import 'package:flutter/material.dart';
import 'package:learn/Globals.dart';
import 'package:learn/paths.dart';
import 'package:learn/requests.dart';
import 'package:learn/Batiments.dart';
import 'package:learn/bottommenu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:learn/Datetimepicker.dart';

class Plan extends StatefulWidget {
  final List<EventCalendar> events;
  const Plan({Key? key, required this.events}) : super(key: key);

  @override
  State<Plan> createState() => _Plan();
}

class _Plan extends State<Plan> {
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        kSelectedFloor.value = pageController.page!.toInt();
      });

      batController.addListener(
        () {
          batiment.value = listbat[batController.page!.toInt()];
        },
      );
    });
  }

  ValueNotifier<Bat> batiment = ValueNotifier(ENSIBS_Vannes);
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  PageController batController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  PageController pickcontroller = PageController();

  bool elevation = true;
  ValueNotifier<double> pos = ValueNotifier<double>(0.0);
  final PanelController _pc = PanelController();

// Callbacks
  void scrollcallback() {
    _pc.isPanelOpen ? _pc.close() : _pc.open();
  }

  void batCallback(int floor, [int? bat]) async {
    if (bat != null) {
      batController.jumpToPage(bat);
    }
    await pageController.animateToPage(floor,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SlidingUpPanel(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 6.0,
            right: MediaQuery.of(context).size.width / 6.0,
            top: MediaQuery.of(context).size.height / 6.0,
          ),
          onPanelSlide: (e) {
            pos.value = e;
          },
          renderPanelSheet: false,
          minHeight: 50.0,
          maxHeight: 4 * MediaQuery.of(context).size.height / 5,
          panel: bottomDrawer(
            pos,
            scrollcallback,
            batCallback,
          ),
          body: (Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    // Création des pages de batiments
                    //    Chaque page est composé d'un widget Floor qui permet de gérer l'ombre, et de créer un
                    //    widget clipshadowpathclicker pour un étage donné pour un batiment donné

                    PageView(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: batController,
                      children: List.generate(
                        listbat.length,
                        (index) => Batiment(
                            events: widget.events,
                            batiment: listbat[index],
                            pagecontroller: pageController),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
        ),
        SlidingUpPanel(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 4.0,
              right: MediaQuery.of(context).size.width / 4.0),
          renderPanelSheet: false,
          controller: _pc,
          isDraggable: false,
          borderRadius: const BorderRadius.all(Radius.circular(35)),
          minHeight: 0.0,
          maxHeight: MediaQuery.of(context).size.height,
          panel: PageView(
            controller: pickcontroller,
            children: [
              TimePicker(
                controller: _pc,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
