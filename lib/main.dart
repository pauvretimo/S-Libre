import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:learn/Planner.dart';
import 'package:learn/requests.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Salles',
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

/// A Stateful widget that paints flutter logo using [CustomPaint] and [Path].
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<EventCalendar> cours = [];
    getCalendar().then((events) {
      cours = events;
    });
    return Scaffold(
        body: FutureBuilder(
            future: getCalendar(),
            initialData: const [],
            builder: (builder, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Center(
                  child: Plan(
                events: cours,
              ));
            }));
  }
}
