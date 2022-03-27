import 'package:flutter/material.dart';
import 'package:learn/paths.dart';
import 'package:learn/Globals.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class bottomDrawer extends StatefulWidget {
  ValueNotifier<double> pos;
  Function callback;
  Function batcallback;
  PanelController settingsController;
  bottomDrawer(
    this.pos,
    this.callback,
    this.batcallback,
    this.settingsController,
  );
  @override
  State<StatefulWidget> createState() => _bottomDrawer(
        pos,
        callback,
        batcallback,
      );
}

class _bottomDrawer extends State<bottomDrawer> with TickerProviderStateMixin {
  final ScrollController sc = ScrollController();
  ValueNotifier<double> pos;
  ValueNotifier<Bat> bat = ValueNotifier(kSelectedBat.value);
  late List<String> days;
  ScrollController floorController = ScrollController();
  ValueNotifier<bool> isFloorListScrollableRight = ValueNotifier(false);
  ValueNotifier<bool> isFloorListScrollableLeft = ValueNotifier(false);
  List<String> daysName = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  Function callback;
  Function batcallback;
  _bottomDrawer(
    this.pos,
    this.callback,
    this.batcallback,
  );

  void scrollIndicator() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (floorController.position.maxScrollExtent > 0) {
        isFloorListScrollableRight.value = true;
        isFloorListScrollableLeft.value = false;
      } else {
        isFloorListScrollableRight.value = false;
        isFloorListScrollableLeft.value = false;
      }

      floorController.addListener(
        () {
          if (floorController.position.pixels <
              floorController.position.maxScrollExtent - 30) {
            isFloorListScrollableRight.value = true;
          } else {
            isFloorListScrollableRight.value = false;
          }
          if (floorController.position.pixels >
              floorController.position.minScrollExtent + 30) {
            isFloorListScrollableLeft.value = true;
          } else {
            isFloorListScrollableLeft.value = false;
          }
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    scrollIndicator();
  }

  @override
  Widget build(BuildContext context) {
    final int dayindex = daysName.indexOf(kToday);
    if (dayindex == 3) {
      days = ["Aujourd'hui", "Demain", "Lundi"];
    } else if (dayindex == 4) {
      days = ["Aujourd'hui", "Lundi", "Mardi"];
    } else if (dayindex > 4) {
      days = ["Lundi", "Mardi", "Mercredi"];
    } else {
      days = ["Aujourd'hui", "Demain", "Après-demain"];
    }
    if ((kTimeNow.weekday == DateTime.saturday ||
        kTimeNow.weekday == DateTime.sunday ||
        kSelectedDay.value > 0)) {
      kIsSelectSwitched.value = true;
      print('here');
    }
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
            height: 52.0,
            child: ValueListenableBuilder<double>(
              valueListenable: pos,
              builder: (BuildContext context, double value, Widget? child) {
                return ClipPath(
                  key: ValueKey(pos),
                  child: Container(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  clipper: buttonClipper(pos.value),
                );
              },
            )),
        ValueListenableBuilder(
          valueListenable: pos,
          builder: (BuildContext context, double value, Widget? child) {
            return Positioned(
              top: 10 + value * 20,
              child: Icon(
                Icons.arrow_drop_up_rounded,
                color:
                    Color.fromARGB(255 - (255 * value).toInt(), 255, 255, 240),
                size: 50.0,
              ),
            );
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: FittedBox(
                child: Container(
                  height: 400.0,
                  width: 260.0,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 6.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    border: Border.all(
                      width: 4.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 10.0,
                        left: 10.0,
                        child: Container(
                          alignment: Alignment.center,
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Theme.of(context).colorScheme.onSurface),
                          child: IconButton(
                            onPressed: () {
                              widget.settingsController.open();
                            },
                            icon: Icon(
                              Icons.settings,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.0,
                        right: 10.0,
                        child: Container(
                          alignment: Alignment.center,
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Theme.of(context).colorScheme.onSurface),
                          child: IconButton(
                            onPressed: () {
                              kRefreshing.value = true;
                            },
                            icon: Icon(
                              Icons.refresh_rounded,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ListView(
                          shrinkWrap: true,
                          controller: sc,
                          children: [
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              height: 40.0,
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              decoration: BoxDecoration(
                                color: const Color(0x7AFFFFFF),
                                border: Border.all(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: FittedBox(
                                child: PopupMenuButton(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16.0))),
                                  child: ValueListenableBuilder(
                                    valueListenable: kSelectedDay,
                                    builder: (context, value, child) {
                                      return Text(
                                        days[kSelectedDay.value],
                                        textAlign: TextAlign.center,
                                      );
                                    },
                                  ),
                                  itemBuilder: (context) {
                                    return List.generate(3, (index) {
                                      String day = days[index];
                                      return PopupMenuItem(
                                          value: index, child: Text(day));
                                    });
                                  },
                                  onSelected: (int index) {
                                    kSelectedDay.value = index;
                                    bat.value.updateBat();
                                    kToUpdate.value = !kToUpdate.value;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                              height: 100,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: RotatedBox(
                                      quarterTurns: -1,
                                      child: Center(
                                        child: ValueListenableBuilder(
                                          valueListenable: kIsSelectSwitched,
                                          builder: (BuildContext context,
                                              bool value, Widget? child) {
                                            return Switch(
                                              value: value,
                                              onChanged: (val) {
                                                if (!(kTimeNow.weekday ==
                                                        DateTime.saturday ||
                                                    kTimeNow.weekday ==
                                                        DateTime.sunday ||
                                                    kSelectedDay.value > 0)) {
                                                  kIsSelectSwitched.value = val;
                                                  bat.value.updateBat();
                                                  kToUpdate.value =
                                                      !kToUpdate.value;
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: ValueListenableBuilder(
                                      valueListenable: kIsSelectSwitched,
                                      builder: (BuildContext context,
                                          bool switched, Widget? child) {
                                        return ListView(
                                          children: [
                                            Container(
                                              height: 40.0,
                                              margin: const EdgeInsets.only(
                                                  left: 1.0, right: 10.0),
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              decoration: BoxDecoration(
                                                color: switched
                                                    ? const Color(0x7AFFFFFF)
                                                    : const Color(0x7AAFAFAF),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiary),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: FittedBox(
                                                child: InkWell(
                                                  onTap: () {
                                                    kIsSelectSwitched.value =
                                                        true;
                                                    callback();
                                                  },
                                                  child:
                                                      ValueListenableBuilder3(
                                                    valuelistenable1:
                                                        kStartHour,
                                                    valuelistenable2: kStartMin,
                                                    valuelistenable3: kAM_st,
                                                    builder: (context,
                                                        int value1,
                                                        int value2,
                                                        bool value3,
                                                        child) {
                                                      int hour = (kAM_st.value
                                                          ? value1
                                                          : value1 + 12);
                                                      return Text(
                                                        hour < 10
                                                            ? (value2 < 10
                                                                ? 'de 0$hour h 0$value2'
                                                                : 'de 0$hour h $value2')
                                                            : (value2 < 10
                                                                ? 'de $hour h 0$value2'
                                                                : 'de $hour h $value2'),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: switched
                                                                ? null
                                                                : const Color(
                                                                    0xFF000000),
                                                            fontSize: 30.0),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Container(
                                              height: 40.0,
                                              margin: const EdgeInsets.only(
                                                  left: 1.0, right: 10.0),
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              decoration: BoxDecoration(
                                                color: switched
                                                    ? const Color(0x7AFFFFFF)
                                                    : const Color(0x7AAFAFAF),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiary),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: FittedBox(
                                                child: InkWell(
                                                  onTap: () {
                                                    kIsSelectSwitched.value =
                                                        true;
                                                    callback();
                                                  },
                                                  child:
                                                      ValueListenableBuilder3(
                                                    valuelistenable1: kEndHour,
                                                    valuelistenable2: kEndMin,
                                                    valuelistenable3: kAM_en,
                                                    builder: (context,
                                                        int value1,
                                                        int value2,
                                                        bool value3,
                                                        child) {
                                                      int hour = (kAM_en.value
                                                          ? value1
                                                          : value1 + 12);
                                                      return Text(
                                                        hour < 10
                                                            ? (value2 < 10
                                                                ? 'à 0$hour h 0$value2'
                                                                : 'à 0$hour h $value2')
                                                            : (value2 < 10
                                                                ? 'à $hour h 0$value2'
                                                                : 'à $hour h $value2'),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: switched
                                                                ? null
                                                                : const Color(
                                                                    0xFF000000),
                                                            fontSize: 30.0),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              height: 60.0,
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: bat,
                                    builder: (context, value, child) {
                                      return Center(
                                        child: ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          controller: floorController,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.all(8),
                                          itemCount: bat.value.nb_floors,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            List<Paths> entries = bat.value.bat;
                                            return ValueListenableBuilder(
                                              valueListenable: kSelectedFloor,
                                              builder: (context, value, child) {
                                                return Container(
                                                  height: 50,
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                      boxShadow: index ==
                                                              kSelectedFloor
                                                                  .value
                                                          ? [
                                                              BoxShadow(
                                                                  offset:
                                                                      const Offset(
                                                                          0.8,
                                                                          1.0),
                                                                  blurRadius: 2,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .shadow)
                                                            ]
                                                          : null,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary,
                                                          width: 3),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        batcallback(index);
                                                        kSelectedFloor.value =
                                                            index;
                                                      },
                                                      child: Text(
                                                        entries[index].name,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onTertiary),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const VerticalDivider(
                                            width: 10.0,
                                            thickness: 2.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    left: -14,
                                    child: ValueListenableBuilder(
                                      valueListenable:
                                          isFloorListScrollableLeft,
                                      builder: (context, bool value, child) {
                                        return value
                                            ? const Icon(
                                                Icons.arrow_left_rounded,
                                                size: 36.0,
                                              )
                                            : Container();
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    right: -14,
                                    child: ValueListenableBuilder(
                                      valueListenable:
                                          isFloorListScrollableRight,
                                      builder: (context, bool value, child) {
                                        return value
                                            ? const Icon(
                                                Icons.arrow_right_rounded,
                                                size: 36.0,
                                              )
                                            : Container();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              height: 60.0,
                              child: ValueListenableBuilder(
                                valueListenable: bat,
                                builder: (context, value, child) {
                                  return Center(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.all(8),
                                      itemCount: 2,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          height: 50,
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              boxShadow: bat.value ==
                                                      listBat[index]
                                                  ? [
                                                      BoxShadow(
                                                          offset: const Offset(
                                                              0.8, 1.0),
                                                          blurRadius: 2,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .shadow)
                                                    ]
                                                  : null,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                  width: 3),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                          child: Center(
                                            child: InkWell(
                                              onTap: () {
                                                bat.value = listBat[index];
                                                kSelectedFloor.value = 0;
                                                batcallback(0, index);
                                                scrollIndicator();
                                              },
                                              child: Text(
                                                listBat[index].name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onTertiary),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const VerticalDivider(
                                        width: 10.0,
                                        thickness: 2.0,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class buttonClipper extends CustomClipper<Path> {
  final double top;
  buttonClipper(
    this.top,
  );

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(.0, 51.0);
    path.moveTo(size.width / 2.0 - 40.0 + (top * 10), 51.0);
    path.quadraticBezierTo(size.width / 2.0 - 23.0 + (top * 13), 51.0,
        size.width / 2.0 - 23.0 + (top * 13), 41.0 + (top * 10.0));
    path.cubicTo(
        size.width / 2.0 - 18.0 + (top * 15),
        11.0 + (top * 40.0),
        size.width / 2.0 + 18.0 - (top * 15),
        11.0 + (top * 40.0),
        size.width / 2.0 + 23.0 - (top * 13),
        41.0 + (top * 10));
    path.quadraticBezierTo(size.width / 2.0 + 23.0 - (top * 13), 51.0,
        size.width / 2.0 + 40.0 - (top * 10), 51.0);
    path.moveTo(size.width, 51.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
