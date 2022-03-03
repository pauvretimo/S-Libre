import 'package:flutter/foundation.dart';
import 'package:learn/circle_list.dart';
import 'dart:math' as Math;
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimePicker();
}

class _TimePicker extends State<TimePicker> {
  ValueNotifier<int> start_hours = ValueNotifier(10);
  ValueNotifier<int> start_minutes = ValueNotifier(10);
  ValueNotifier<int> end_hours = ValueNotifier(10);
  ValueNotifier<int> end_minutes = ValueNotifier(10);
  bool startSelected = true;

  void notifycallback(e) {
    setState(() {
      start_hours = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 0.8,
        child: AspectRatio(
          aspectRatio: 9.0 / 16.0,
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xDF282828), width: 5.0),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: const Color(0xEFAFAFAF)),
            child: Column(verticalDirection: VerticalDirection.up, children: [
              FittedBox(
                child: UnconstrainedBox(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 320,
                    width: 320,
                    child: Stack(alignment: Alignment.center, children: [
                      //cercle central
                      Center(
                        child: Container(
                          height: 35.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color(0xAF101010), width: 2.0),
                          ),
                        ),
                      ),

                      //cadrant minutes
                      CircleList(
                        outerRadius: 155.0,
                        rotateMode: RotateMode.stopRotate,
                        initialAngle: -Math.pi / 2,
                        origin: const Offset(0, 0),
                        children: List.generate(12, (index) {
                          final int i = index * 5;
                          return Container(
                            height: 30.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? const Color.fromARGB(255, 20, 150, 255)
                                    : const Color.fromARGB(255, 20, 102, 240),
                                shape: BoxShape.circle),
                            child: Text("$i"),
                          );
                        }),
                      ),

                      //cadrant heures
                      CircleList(
                          outerRadius: 90.0,
                          rotateMode: RotateMode.stopRotate,
                          initialAngle: -Math.pi / 2,
                          origin: const Offset(0, 0),
                          children: [
                            Container(
                              height: 33.0,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 20, 150, 255),
                                  shape: BoxShape.circle),
                              child: const Text("12"),
                            ),
                            ...List.generate(11, (index) {
                              final int i = index + 1;
                              return Container(
                                height: 33.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? const Color.fromARGB(
                                            255, 20, 150, 255)
                                        : const Color.fromARGB(
                                            255, 20, 102, 240),
                                    shape: BoxShape.circle),
                                child: Text("$i"),
                              );
                            })
                          ]),

                      //selecteur minutes
                      CircleList(
                          onSnapUpdate: (index) {
                            startSelected
                                ? start_minutes.value = (5 * index + 10) % 60
                                : end_minutes.value = (5 * index + 10) % 60;
                            return null;
                          },
                          snapping: 12,
                          initialAngle: -Math.pi / 6,
                          outerRadius: 155.0,
                          origin: const Offset(0, 0),
                          innerCircleRotateWithChildren: true,
                          centerWidget: Transform.translate(
                              offset: const Offset(57.0, 0),
                              child: Container(
                                  width: 82.0,
                                  height: 2.0,
                                  color: const Color(0xAF101010))),
                          children: [
                            Container(
                              height: 38.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xAF101010),
                                      width: 2.0),
                                  color: const Color(0x30EFEFEF),
                                  shape: BoxShape.circle),
                              child: null,
                            ),
                            Container(),
                          ]),

                      //selecteurs heures
                      CircleList(
                          onSnapUpdate: (index) {
                            startSelected
                                ? start_hours.value = (index + 10) % 12
                                : end_hours.value = (index + 10) % 12;
                            return null;
                          },
                          snapping: 12,
                          initialAngle: -5 * Math.pi / 6,
                          innerCircleRotateWithChildren: true,
                          outerRadius: 90.0,
                          origin: const Offset(0, 0),
                          centerWidget: Transform.translate(
                              offset: const Offset(32.0, 0),
                              child: Container(
                                  width: 32.0,
                                  height: 2.0,
                                  color: const Color(0xAF101010))),
                          children: [
                            Container(
                              height: 41.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xAF101010),
                                      width: 2.0),
                                  color: const Color(0x30EFEFEF),
                                  shape: BoxShape.circle),
                              child: null,
                            ),
                            Container(),
                          ]),
                    ]),
                  ),
                ),
              ),
              // second afficheur
              Expanded(
                flex: 3,
                child: Row(children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: ValueListenableBuilder(
                        valueListenable: end_hours,
                        builder: (context, value, child) {
                          final int en_hours = (end_hours.value);
                          return Text(
                            "$en_hours",
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "h",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: ValueListenableBuilder(
                        valueListenable: end_minutes,
                        builder: (context, value, child) {
                          final int en_min = (end_minutes.value);
                          return Text(
                            "$en_min",
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "min",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: Text(
                  "à",
                  textAlign: TextAlign.center,
                ),
              ),
              // premier afficheur
              Expanded(
                flex: 3,
                child: Row(children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: ValueListenableBuilder(
                        valueListenable: start_hours,
                        builder: (context, value, child) {
                          final int st_hours = (start_hours.value);
                          return Text(
                            "$st_hours",
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "h",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: ValueListenableBuilder(
                        valueListenable: start_minutes,
                        builder: (context, value, child) {
                          final int st_min = (start_minutes.value);
                          return Text(
                            "$st_min",
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "min",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: Text(
                  "De",
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
