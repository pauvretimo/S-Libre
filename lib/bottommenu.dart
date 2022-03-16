import 'package:flutter/material.dart';
import 'package:learn/paths.dart';
import 'package:learn/Globals.dart';

class bottomDrawer extends StatefulWidget {
  ValueNotifier<double> pos;
  Function callback;
  Function batcallback;
  bottomDrawer(
    this.pos,
    this.callback,
    this.batcallback,
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
  ValueNotifier<Bat> bat = ValueNotifier(ENSIBS_Vannes);
  late List<String> days;
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
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: 52.0,
          child: Stack(
            children: [
              ValueListenableBuilder<double>(
                valueListenable: pos,
                builder: (BuildContext context, double value, Widget? child) {
                  return ClipPath(
                    key: ValueKey(pos),
                    child: Container(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    clipper: buttonClipper(pos.value),
                  );
                },
              )
            ],
          ),
        ),
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
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      controller: sc,
                      children: [
                        const SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          height: 40.0,
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          decoration: BoxDecoration(
                            color: const Color(0x7AFFFFFF),
                            border: Border.all(
                                width: 2,
                                color: Theme.of(context).colorScheme.tertiary),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: FittedBox(
                            child: PopupMenuButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0))),
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
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          height: 40.0,
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          decoration: BoxDecoration(
                            color: const Color(0x7AFFFFFF),
                            border: Border.all(
                                width: 2,
                                color: Theme.of(context).colorScheme.tertiary),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: FittedBox(
                            child: InkWell(
                              onTap: () {
                                callback();
                              },
                              child: ValueListenableBuilder2(
                                valuelistenable1: kStartHour,
                                valuelistenable2: kStartMin,
                                builder: (context, value1, value2, child) {
                                  return Text(
                                    'De $value1 h $value2',
                                    textAlign: TextAlign.center,
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
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          decoration: BoxDecoration(
                            color: const Color(0x7AFFFFFF),
                            border: Border.all(
                                width: 2,
                                color: Theme.of(context).colorScheme.tertiary),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: FittedBox(
                            child: InkWell(
                              onTap: () {
                                callback();
                              },
                              child: ValueListenableBuilder2(
                                valuelistenable1: kEndHour,
                                valuelistenable2: kEndMin,
                                builder: (context, value1, value2, child) {
                                  return Text(
                                    'à $value1 h $value2',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 30.0),
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
                          height: 60.0,
                          alignment: Alignment.center,
                          color: Colors.transparent,
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
                                    List<Paths> entries = bat.value.bat;
                                    return ValueListenableBuilder(
                                      valueListenable: kSelectedFloor,
                                      builder: (context, value, child) {
                                        return Container(
                                          height: 50,
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              boxShadow: index ==
                                                      kSelectedFloor.value
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
                                                batcallback(index);
                                                kSelectedFloor.value = index;
                                              },
                                              child: Text(
                                                entries[index].name,
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
                                          boxShadow: bat.value == listbat[index]
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                              width: 3),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            bat.value = listbat[index];
                                            kSelectedFloor.value = 0;
                                            batcallback(0, index);
                                          },
                                          child: Text(
                                            listbat[index].name,
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
