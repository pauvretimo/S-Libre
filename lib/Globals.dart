import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Valeurs des heures et minutes sélectionnées
ValueNotifier<int> kStartHour = ValueNotifier(10);
ValueNotifier<int> kStartMin = ValueNotifier(10);
ValueNotifier<int> kEndHour = ValueNotifier(10);
ValueNotifier<int> kEndMin = ValueNotifier(10);

ValueNotifier<int> kSelectedDay = ValueNotifier(0);

ValueNotifier<int> kSelectedFloor = ValueNotifier(0);

String kToday = DateFormat.EEEE().format(DateTime.now());

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
