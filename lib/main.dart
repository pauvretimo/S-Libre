import 'package:flutter/material.dart';
import 'package:learn/Globals.dart';
import 'package:learn/Planner.dart';
import 'package:learn/SaveData.dart';
import 'package:learn/requests.dart';
import 'dart:ui';
import 'package:intl/intl.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // recuperation dernières donnees
    updateTheme();
    kToday = DateFormat.EEEE().format(DateTime.now());
    return ValueListenableBuilder(
      valueListenable: kThemedelapp,
      builder: (BuildContext context, ThemeMode value, Widget? child) {
        return MaterialApp(
          scrollBehavior: AppScrollBehavior(),
          title: 'App Salles',
          debugShowCheckedModeBanner: false,
          themeMode: kThemedelapp.value,
          theme: ThemeData(
            textTheme: const TextTheme(
              bodyText1: TextStyle(),
              bodyText2: TextStyle(),
            ).apply(
              bodyColor: const Color(0xFF005221),
            ),
            accentColor: const Color(0xFF388C1D),
            fontFamily: 'Lato',
            cardColor: const Color(0xFFF0F0F0),
            colorScheme: const ColorScheme(
              shadow: Color(0xFF404040),
              brightness: Brightness.light,
              primary: Color(0xFF6DB92D),
              onPrimary: Color(0xFFFFFFF0),
              primaryContainer: Color(0xAF005221),
              onPrimaryContainer: Color(0xFFFFFFF0),
              secondary: Color(0xFF388C1D),
              onSecondary: Color(0xFF6DB92D),
              secondaryContainer: Color(0x5F48CC3D),
              onSecondaryContainer: Color(0xFF6DB92D),
              tertiary: Color(0xFF005221),
              onTertiary: Color(0xFFFFFFF0),
              tertiaryContainer: Color(0xAF005221),
              onTertiaryContainer: Color(0xFF003211),
              error: Color(0xFFEE0000),
              onError: Color(0xFFEEEEEE),
              background: Color(0xFFFFFFF6),
              onBackground: Color(0xFF005221),
              surface: Color(0xFFF6F7F0),
              onSurface: Color(0xFF005221),
            ),
          ),
          darkTheme: ThemeData(
              accentColor: const Color(0xFF4B35B9),
              textTheme: const TextTheme(
                bodyText1: TextStyle(),
                bodyText2: TextStyle(),
              ).apply(
                bodyColor: const Color(0xFFFFFFF0),
              ),
              fontFamily: 'Lato',
              cardColor: const Color(0xFF042150),
              colorScheme: const ColorScheme(
                shadow: Color(0xFFFFFFF0),
                brightness: Brightness.dark,
                primary: Color(0xFF037CB5),
                onPrimary: Color(0xFFFFFFF0),
                primaryContainer: Color(0xAF037CB5),
                onPrimaryContainer: Color(0xFFFFFFF0),
                secondary: Color(0xFF4B35B9),
                onSecondary: Color(0xFFFFFFF0),
                secondaryContainer: Color(0x5F222597),
                onSecondaryContainer: Color(0xFFFFFFF0),
                tertiary: Color(0xFF191970),
                onTertiary: Color(0xFFFFFFF0),
                tertiaryContainer: Color(0xAF191970),
                onTertiaryContainer: Color(0xFF037CB5),
                error: Color(0xFFEE0000),
                onError: Color(0xFFEEEEEE),
                background: Color(0xFF002147),
                onBackground: Color(0xFF037CB5),
                surface: Color(0xFF042150),
                onSurface: Color(0xFF037CB5),
              )),
          home: const MyHomePage(),
        );
      },
    );
  }
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
    // enregistrement lors dest changements de paramètres
    kSelectedBat.addListener(() {
      saveSettings.save('bat', kSelectedBat.value.name);
    });

    kSelectedFloor.addListener(
      () {
        saveSettings.save('floor', kSelectedFloor.value);
      },
    );

    // L'app
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ValueListenableBuilder(
        valueListenable: kRefreshing,
        builder: (BuildContext context, bool value, Widget? child) {
          if (value) {
            return FutureBuilder(
              future: getCalendar(context),
              initialData: const [],
              builder: (builder, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            );
          } else {
            return FutureBuilder(
              future: updateValues().then((value) => null),
              initialData: const [],
              builder: (builder, snapshot) {
                return FutureBuilder<String>(
                  future: loadAsset(context),
                  builder: (builder, snapshot) {
                    if (snapshot.hasData) {
                      kLicence = snapshot.data!;
                    }
                    return const Center(
                      child: Plan(),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
