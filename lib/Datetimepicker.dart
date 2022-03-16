import 'package:learn/circle_list.dart';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:learn/Globals.dart';

class TimePicker extends StatefulWidget {
  final PanelController controller;
  const TimePicker({Key? key, required this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimePicker();
}

class _TimePicker extends State<TimePicker> {
  ValueNotifier<int> start_hours = ValueNotifier(10);
  ValueNotifier<int> start_minutes = ValueNotifier(10);
  ValueNotifier<int> end_hours = ValueNotifier(10);
  ValueNotifier<int> end_minutes = ValueNotifier(10);
  ValueNotifier<bool> startSelected = ValueNotifier(true);
  ValueNotifier<bool> AM_st = ValueNotifier(true);
  ValueNotifier<bool> AM_en = ValueNotifier(true);
  int lastHourValue = 10;

  @override
  void initState() {
    super.initState();
    start_hours.addListener(() {
      AM_st.value
          ? kStartHour.value = start_hours.value
          : kStartHour.value = start_hours.value + 12;
    });
    start_minutes.addListener(() {
      kStartMin.value = end_minutes.value;
    });
    end_hours.addListener(() {
      AM_en.value
          ? kEndHour.value = end_hours.value
          : kEndHour.value = end_hours.value + 12;
    });
    end_minutes.addListener(() {
      kEndMin.value = end_minutes.value;
    });
  }

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
                border: Border.all(
                    color: Theme.of(context).colorScheme.secondary, width: 4.0),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).colorScheme.background),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Column(
                    verticalDirection: VerticalDirection.up,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FittedBox(
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      width: 4.0),
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
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary,
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
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
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
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                          shape: BoxShape.circle),
                                      child: Text("$i"),
                                    );
                                  })
                                ]),

                            //selecteur minutes
                            CircleList(
                                onSnapUpdate: (index) {
                                  startSelected.value
                                      ? start_minutes.value =
                                          (5 * index + 10) % 60
                                      : end_minutes.value =
                                          (5 * index + 10) % 60;
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground)),
                                children: [
                                  Container(
                                    height: 38.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
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
                                  if (startSelected.value) {
                                    lastHourValue = start_hours.value;
                                    start_hours.value = (index + 10) % 12;
                                    if (lastHourValue == 11 &&
                                        start_hours.value == 0) {
                                      AM_st.value = false;
                                    } else if (lastHourValue == 0 &&
                                        start_hours.value == 11) {
                                      AM_st.value = true;
                                    }
                                  } else {
                                    lastHourValue = end_hours.value;
                                    end_hours.value = (index + 10) % 12;
                                    if (lastHourValue == 11 &&
                                        end_hours.value == 0) {
                                      AM_en.value = false;
                                    } else if (lastHourValue == 0 &&
                                        end_hours.value == 11) {
                                      AM_en.value = true;
                                    }
                                  }

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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground)),
                                children: [
                                  Container(
                                    height: 41.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
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

                      /// second afficheur
                      Expanded(
                        child: Column(
                            verticalDirection: VerticalDirection.up,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    startSelected.value = false;
                                  },
                                  child: ValueListenableBuilder(
                                      valueListenable: startSelected,
                                      builder: (context, value, child) {
                                        return Container(
                                          margin: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            boxShadow: startSelected.value
                                                ? null
                                                : [
                                                    BoxShadow(
                                                        offset: const Offset(
                                                            0.8, 1.0),
                                                        blurRadius: 2,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .shadow)
                                                  ],
                                            color: startSelected.value
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .tertiaryContainer
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .secondaryContainer,
                                            border: Border.all(
                                                color: startSelected.value
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .onTertiaryContainer
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer,
                                                width: 4.0),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                          ),
                                          child: Row(children: [
                                            Expanded(
                                              flex: 2,
                                              child: FittedBox(
                                                child: ValueListenableBuilder2(
                                                  valuelistenable1: end_hours,
                                                  valuelistenable2: AM_en,
                                                  builder: (context, value1,
                                                      value2, child) {
                                                    int en_hours = (AM_en.value
                                                        ? end_hours.value
                                                        : end_hours.value + 12);
                                                    return Text(
                                                      en_hours < 10
                                                          ? "0$en_hours"
                                                          : "$en_hours",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: startSelected
                                                                .value
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .onTertiaryContainer
                                                            : Theme.of(context)
                                                                .colorScheme
                                                                .onSecondaryContainer,
                                                        fontSize: 90,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: FittedBox(
                                                child: Text(
                                                  "h",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: startSelected.value
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .onTertiaryContainer
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .onSecondaryContainer,
                                                    fontSize: 70,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: FittedBox(
                                                child: ValueListenableBuilder(
                                                  valueListenable: end_minutes,
                                                  builder:
                                                      (context, value, child) {
                                                    final int en_min =
                                                        (end_minutes.value);
                                                    return Text(
                                                      en_min < 10
                                                          ? "0$en_min"
                                                          : "$en_min",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: startSelected
                                                                .value
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .onTertiaryContainer
                                                            : Theme.of(context)
                                                                .colorScheme
                                                                .onSecondaryContainer,
                                                        fontSize: 90,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ]),
                                        );
                                      }),
                                ),
                              ),
                              Expanded(
                                child: FittedBox(
                                  child: Center(
                                    child: Text(
                                      "à",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // premier afficheur
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    startSelected.value = true;
                                  },
                                  child: ValueListenableBuilder(
                                      valueListenable: startSelected,
                                      builder: (context, value, child) {
                                        return Container(
                                          margin: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            boxShadow: startSelected.value
                                                ? [
                                                    BoxShadow(
                                                        offset: const Offset(
                                                            0.8, 1.0),
                                                        blurRadius: 2,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .shadow)
                                                  ]
                                                : null,
                                            color: startSelected.value
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .secondaryContainer
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .tertiaryContainer,
                                            border: Border.all(
                                                color: startSelected.value
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onTertiaryContainer,
                                                width: 4.0),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                          ),
                                          child: Row(children: [
                                            Expanded(
                                              flex: 2,
                                              child: FittedBox(
                                                child: ValueListenableBuilder2(
                                                  valuelistenable1: start_hours,
                                                  valuelistenable2: AM_st,
                                                  builder: (context, value1,
                                                      value2, child) {
                                                    int st_hours = (AM_st.value
                                                        ? start_hours.value
                                                        : start_hours.value +
                                                            12);
                                                    return Text(
                                                      st_hours < 10
                                                          ? "0$st_hours"
                                                          : "$st_hours",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: startSelected
                                                                .value
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .onSecondaryContainer
                                                            : Theme.of(context)
                                                                .colorScheme
                                                                .onTertiaryContainer,
                                                        fontSize: 90,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: FittedBox(
                                                child: Text(
                                                  "h",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: startSelected.value
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .onSecondaryContainer
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .onTertiaryContainer,
                                                    fontSize: 70,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: FittedBox(
                                                child: ValueListenableBuilder(
                                                  valueListenable:
                                                      start_minutes,
                                                  builder:
                                                      (context, value, child) {
                                                    final int st_min =
                                                        (start_minutes.value);
                                                    return Text(
                                                      st_min < 10
                                                          ? "0$st_min"
                                                          : "$st_min",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: startSelected
                                                                .value
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .onSecondaryContainer
                                                            : Theme.of(context)
                                                                .colorScheme
                                                                .onTertiaryContainer,
                                                        fontSize: 90,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ]),
                                        );
                                      }),
                                ),
                              ),

                              Expanded(
                                child: Center(
                                  child: FittedBox(
                                    child: Text(
                                      "De",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ]),
                Column(
                  children: [
                    Expanded(
                      flex: 40,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: -3.0,
                                      offset: const Offset(0.8, 1.0),
                                      blurRadius: 2,
                                      color:
                                          Theme.of(context).colorScheme.shadow)
                                ],
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    width: 3.0),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  startSelected.value
                                      ? AM_st.value = !AM_st.value
                                      : AM_en.value = !AM_en.value;
                                },
                                child: FittedBox(
                                  child: ValueListenableBuilder3(
                                      valuelistenable1: AM_st,
                                      valuelistenable2: AM_en,
                                      valuelistenable3: startSelected,
                                      builder: (context, value1, value2, value3,
                                          child) {
                                        return Row(
                                          children: [
                                            Text(
                                              "AM",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: startSelected.value
                                                      ? AM_st.value
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .onSecondary
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onBackground
                                                      : AM_en.value
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .onSecondary
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onBackground,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              " / ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "PM",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: startSelected.value
                                                      ? AM_st.value
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .onBackground
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onSecondary
                                                      : AM_en.value
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .onBackground
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onSecondary,
                                                  fontSize: 16),
                                            )
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                            flex: 15,
                          ),
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              onTap: () => widget.controller.close(),
                              customBorder: Border.all(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                width: 3.0,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: FittedBox(
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .shadow,
                                        offset: const Offset(0.8, 1.0),
                                        blurRadius: 0.2,
                                      )
                                    ],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
