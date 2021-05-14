import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/manager.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Agenda extends StatefulWidget {
  @override
  _AgendaState createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Manager>(builder: (context, manager, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          mini: true,
          onPressed: () {
            print('navegando para agendamento');
            Navigator.pushNamed(context, '/scheduling');
          },
          backgroundColor: Colors.cyan,
        ),
        body: Container(
          child: SfCalendar(
            view: CalendarView.week,
            firstDayOfWeek: 1,
            allowViewNavigation: true,
            allowedViews: [
              CalendarView.month,
              CalendarView.week,
              CalendarView.day
            ],
            monthViewSettings: MonthViewSettings(showAgenda: true),
            dataSource: MeetingDataSource(_getDataSource()),
            timeSlotViewSettings: TimeSlotViewSettings(
                startHour: 8,
                endHour: 22,
                nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday]),
          ),
        ),
      );
    });
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 8, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 3));
    meetings
        .add(Meeting('Studant', startTime, endTime, Colors.greenAccent, false));
    meetings.add(Meeting(
        'Urban Teacher',
        startTime,
        endTime.subtract(const Duration(hours: 2)),
        Colors.yellowAccent,
        false));
    meetings.add(Meeting('Colono-Teachers', startTime,
        endTime.subtract(const Duration(hours: 2)), Colors.redAccent, true));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
