import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn/Globals.dart';
import 'package:learn/paths.dart';
import 'package:learn/SaveData.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

Future<void> getCalendar(context) async {
  // Get calendar file
  var calendar = '';
  try {
    calendar =
        await http.read(Uri.parse("https://api.cyberlog.dev/get-calendar"));
    saveSettings.save('json', calendar);
  } catch (error) {
    calendar = await saveSettings.readString('json') ?? "";
    Alert(
            style: const AlertStyle(
                overlayColor: Color(0x10A10000),
                backgroundColor: Color(0x5FA10000),
                titleStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Dongle",
                  fontSize: 80,
                ),
                descStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Dongle",
                  fontSize: 40,
                )),
            context: context,
            title: 'Erreur',
            desc:
                'Nous ne sommes pas parvenus à télécharger l\'emploi du temps, nous utiliserons donc le dernier enregistré')
        .show();
  }
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // if (calendarStrings != null) {
  //   prefs.setString('calendar', calendarStrings);
  // } else {
  //   calendarStrings = prefs.getString('calendar')!;
  // }
  Map<String, dynamic> calendarMap = jsonDecode(calendar);
  ENSIBS_Vannes.parser(calendarMap);
  kSelectedBat.value.updateBat();

  kRefreshing.value = false;
}
