import 'package:calender/event.dart';
import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];

  DateTime selectedDate = DateTime.now();

  DateTime get selectedDateTime {
    return selectedDate;
  }

  void setDate(DateTime dateTime) {
    selectedDate = dateTime;
  }

  List<Event> get eventsOfSelectedDate {
    return _events;
  }

  List<Event> get events {
    return _events;
  }

  void addEvents(Event event) {
    _events.add(event);
    print(event.title);
    notifyListeners();
  }
}
