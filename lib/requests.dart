import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn/Globals.dart';

Future<List<EventCalendar>> getCalendar() async {
  // Get calendar file
  var calendarStrings =
      await http.read(Uri.parse("http://api.cyberlog.dev/get-calendar"));

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
  kRefreshing.value = false;
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
