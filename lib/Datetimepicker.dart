import 'package:circle_list/circle_list.dart';
import 'dart:math' as Math;
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimePicker();
}

class _TimePicker extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Center(
              child: AspectRatio(
                  aspectRatio: 9.0 / 16.0,
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xDF282828), width: 5.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: const Color(0xEFAFAFAF)),
                      child: LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Transform.scale(
                            scale: constraints.maxWidth / 322.0,
                            child: Container(
                                alignment: Alignment.bottomCenter,
                                height: 320,
                                width: 320,
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      //cercle central
                                      Center(
                                          child: Container(
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: const Color(0xAF101010),
                                              width: 2.0),
                                        ),
                                      )),

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
                                                      ? const Color.fromARGB(
                                                          255, 20, 150, 255)
                                                      : const Color.fromARGB(
                                                          255, 20, 102, 240),
                                                  shape: BoxShape.circle),
                                              child: Text("$i"),
                                            );
                                          })),

                                      //cadrant heures
                                      CircleList(
                                          outerRadius: 80.0,
                                          rotateMode: RotateMode.stopRotate,
                                          initialAngle: -Math.pi / 2,
                                          origin: const Offset(0, 0),
                                          children: List.generate(8, (index) {
                                            final int i = index * 3;
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
                                          })),

                                      //selecteur minutes
                                      CircleList(
                                          outerRadius: 155.0,
                                          origin: const Offset(0, 0),
                                          innerCircleRotateWithChildren: true,
                                          centerWidget: Transform.translate(
                                              offset: const Offset(57.0, 0),
                                              child: Container(
                                                  width: 82.0,
                                                  height: 2.0,
                                                  color:
                                                      const Color(0xAF101010))),
                                          children: [
                                            Container(
                                              height: 38.0,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xAF101010),
                                                      width: 2.0),
                                                  color:
                                                      const Color(0x30EFEFEF),
                                                  shape: BoxShape.circle),
                                              child: null,
                                            ),
                                            Container(),
                                          ]),

                                      //selecteurs heures
                                      CircleList(
                                          innerCircleRotateWithChildren: true,
                                          outerRadius: 80.0,
                                          origin: const Offset(0, 0),
                                          centerWidget: Transform.translate(
                                              offset: const Offset(28.0, 0),
                                              child: Container(
                                                  width: 24.0,
                                                  height: 2.0,
                                                  color:
                                                      const Color(0xAF101010))),
                                          children: [
                                            Container(
                                              height: 41.0,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xAF101010),
                                                      width: 2.0),
                                                  color:
                                                      const Color(0x30EFEFEF),
                                                  shape: BoxShape.circle),
                                              child: null,
                                            ),
                                            Container(),
                                          ]),
                                    ])));
                      }))))),
      const SizedBox(height: 100.0)
    ]);
  }
}
