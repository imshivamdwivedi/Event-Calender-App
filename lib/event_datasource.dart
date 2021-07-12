import 'package:calender/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }
  Event getEvent(int index) {
    return appointments![index] as Event;
  }

  @override
  DateTime getStartTime(int index) {
    // TODO: implement getStartTime
    return getEvent(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    // TODO: implement getEndTime
    return getEvent(index).to;
  }

  @override
  String getSubject(int index) {
    // TODO: implement getSubject
    return getEvent(index).title;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
