import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<EventCalendar>> getCalendar() async {
  // Get calendar file
  var calendarStrings = await http.read(Uri.parse(
      "https://planning.univ-ubs.fr/jsp/custom/modules/plannings/anonymous_cal.jsp?data=8241fc3873200214e7417115c7d485ce79e7da123cf22f6f8c068302e8f3b112af3cca4281be7a96771366caa7df2f2e93013ded833fb22d11456abdcef2a5c5aba4cc45696f1a35b1905d62543466e298faeae814cf21c7ea3cf73aef96d9f8e6b9126445d989d55ac935c9672d75f3de54cad292dca82dc1abda7ddefb3c873445b366f55cc87a8e5afa9a045ba4d8395d07bffeaee1d7324cfcf2e9e6b4356213d7c347ee7c2df43b49ed91b3cccdb0db0d7caf18783a01e8c0686bd2fcfcc678a65850584e436e8504f9d2b878bbcc37ed75a7205b51"));

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // if (calendarStrings != null) {
  //   prefs.setString('calendar', calendarStrings);
  // } else {
  //   calendarStrings = prefs.getString('calendar')!;
  // }

  // split lines in a list
  LineSplitter ls = const LineSplitter();
  List<String> lines = ls.convert(calendarStrings);
  List<EventCalendar> events = [];

  // for each event we create an event object and add to a list
  for (var i = 0; i < lines.length; i++) {
    if (lines[i] == "BEGIN:VEVENT") {
      var event = EventCalendar();
      i++;
      while (lines[i] != "END:VEVENT") {
        if (lines[i].startsWith("DTSTART:")) {
          event.start = lines[i].substring(8);
        } else if (lines[i].startsWith("DTEND:")) {
          event.end = lines[i].substring(6);
        } else if (lines[i].startsWith("SUMMARY:")) {
          event.summary = lines[i].substring(8);
        } else if (lines[i].startsWith("LOCATION:")) {
          event.location = lines[i].substring(9);
        }
        i++;
      }
      events.add(event);
    }
  }

  return events;
}

class EventCalendar {
  String start;
  String end;
  String summary;
  String location;

  EventCalendar(
      {this.start = "", this.end = "", this.summary = "", this.location = ""});

  @override
  String toString() {
    return "start: $start\nend: $end\nsummary: $summary\nlocation: $location\n";
  }
}
