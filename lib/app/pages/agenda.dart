import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/scheduling.dart';
import 'package:notebook_app/app/services/scheduling_service.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Agenda extends StatefulWidget {
  @override
  _AgendaState createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Schedulings>(builder: (context, schedulings, child) {
      // events.addAll(schedulings.getSchedulings());
      // events = events.toSet().toList();
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          mini: true,
          onPressed: () {
            Navigator.pushNamed(context, '/scheduling');
          },
          backgroundColor: Colors.cyan,
        ),
        body: Container(
          child: FutureBuilder(
            future: SchedulingService().all(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Erro ao carregar..."),
                    );
                  } else {
                    return SfCalendar(
                      view: CalendarView.week,
                      firstDayOfWeek: 1,
                      allowViewNavigation: true,
                      allowedViews: [
                        CalendarView.month,
                        CalendarView.week,
                        CalendarView.day
                      ],
                      monthViewSettings: MonthViewSettings(showAgenda: true),
                      dataSource: SchedulingDataSource(snapshot.data),
                      timeSlotViewSettings: TimeSlotViewSettings(
                          startHour: 8,
                          endHour: 22,
                          nonWorkingDays: <int>[
                            DateTime.saturday,
                            DateTime.sunday
                          ]),
                    );
                  }
              }
            },
          ),
        ),
      );
    });
  }
}

class SchedulingDataSource extends CalendarDataSource {
  SchedulingDataSource(List<Scheduling> source) {
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
