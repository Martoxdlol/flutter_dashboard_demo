import 'package:flutter/material.dart';
import 'package:flutter_dashboard_demo/card_see_all.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// The app which hosts the home page which contains the calendar on it.
class CalendarCard extends StatelessWidget {
  const CalendarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardSeeAll(
      onSeeMore: () => showCalendarView(context),
      child: Calendar(),
    );
  }
}

void showCalendarView(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => CalendarPage(),
    ),
  );
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController controller = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        actions: [
          IconButton(
            onPressed: () {
              controller.view = CalendarView.month;
            },
            icon: Icon(Icons.calendar_view_month_rounded),
          ),
          IconButton(
            onPressed: () {
              controller.view = CalendarView.day;
            },
            icon: Icon(Icons.calendar_view_day_rounded),
          ),
          IconButton(
            onPressed: () {
              controller.view = CalendarView.week;
            },
            icon: Icon(Icons.calendar_view_week_rounded),
          )
        ],
      ),
      body: Calendar(
        controller: controller,
      ),
    );
  }
}

/// The hove page which hosts the calendar
class Calendar extends StatefulWidget {
  const Calendar({super.key, this.controller});
  final CalendarController? controller;

  @override
  // ignore: library_private_types_in_public_api
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      controller: widget.controller,
      dataSource: MeetingDataSource(_getDataSource()),
      // by default the month appointment display mode set as Indicator, we can
      // change the display mode as appointment using the appointment display
      // mode property
      headerStyle: CalendarHeaderStyle(textAlign: TextAlign.center, textStyle: TextStyle(fontWeight: FontWeight.w500)),
      monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));

    final DateTime startTime2 = DateTime(today.year, today.month, today.day, 11);
    final DateTime endTime2 = startTime2.add(const Duration(hours: 2));
    meetings.add(Meeting('Product Review', startTime2, endTime2, Colors.blue, false));

    final DateTime startTime3 = DateTime(today.year, today.month, today.day, 14);
    final DateTime endTime3 = startTime3.add(const Duration(hours: 2));
    meetings.add(Meeting('Visit', startTime3, endTime3, Colors.amber, false));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
