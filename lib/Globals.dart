import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn/paths.dart';

// Valeurs des heures et minutes sélectionnees
ValueNotifier<int> kStartHour = ValueNotifier(10);
ValueNotifier<int> kStartMin = ValueNotifier(10);
ValueNotifier<int> kEndHour = ValueNotifier(10);
ValueNotifier<int> kEndMin = ValueNotifier(10);
ValueNotifier<bool> kAM_st = ValueNotifier(true);
ValueNotifier<bool> kAM_en = ValueNotifier(true);

// Le jour selectionne
ValueNotifier<int> kSelectedDay = ValueNotifier(0);

// L'etage selectionne 0 -> n
ValueNotifier<int> kSelectedFloor = ValueNotifier(0);

// Le jour actuel
String kToday = DateFormat.EEEE().format(DateTime.now());

// couleurs des salles:
const Color kSalleOccupee = Color(0xFFD10819);
const Color kSalleBientotOccupee = Color(0xFFFF681F);
const Color kSalleLibre = Color(0xFF39FF14);
const Color kSalleInaccessible = Color(0xFF828282);
const Color kCouloirs = Color(0xFF64C8EF);

// liste des batiments de l'app
List<Bat> listbat = [ENSIBS_Vannes, ENSIBS_Lorient];

// classes permettants de rebuild en fonction de plusieurs ValueNotifier
class ValueListenableBuilder2<A, B> extends StatelessWidget {
  const ValueListenableBuilder2({
    required this.valuelistenable1,
    required this.valuelistenable2,
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<A> valuelistenable1;
  final ValueListenable<B> valuelistenable2;
  final Widget? child;
  final Widget Function(BuildContext context, A a, B b, Widget? child) builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<A>(
        valueListenable: valuelistenable1,
        builder: (_, a, __) {
          return ValueListenableBuilder<B>(
            valueListenable: valuelistenable2,
            builder: (context, b, __) {
              return builder(context, a, b, child);
            },
          );
        },
      );
}

class ValueListenableBuilder3<A, B, C> extends StatelessWidget {
  const ValueListenableBuilder3({
    required this.valuelistenable1,
    required this.valuelistenable2,
    required this.valuelistenable3,
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<A> valuelistenable1;
  final ValueListenable<B> valuelistenable2;
  final ValueListenable<C> valuelistenable3;
  final Widget? child;
  final Widget Function(BuildContext context, A a, B b, C c, Widget? child)
      builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<A>(
        valueListenable: valuelistenable1,
        builder: (_, a, __) {
          return ValueListenableBuilder<B>(
            valueListenable: valuelistenable2,
            builder: (_, b, __) {
              return ValueListenableBuilder<C>(
                valueListenable: valuelistenable3,
                builder: (context, c, __) {
                  return builder(context, a, b, c, child);
                },
              );
            },
          );
        },
      );
}
