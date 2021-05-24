import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/scheduling.dart';
import 'package:notebook_app/app/services/scheduling_service.dart';
import 'dart:math';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  Map<int, String> xLabels = {
    0: 'jan',
    1: 'fev',
    2: 'mar',
    3: 'abr',
    4: 'maio',
    5: 'jun',
    6: 'jul',
    7: 'ago',
    8: 'set',
    9: 'out',
    10: 'nov',
    11: 'dez'
  };

  // Map<String, double> months = {
  //   'jan': 0,
  //   'fev': 1,
  //   'mar': 2,
  //   'abr': 3,
  //   'maio': 4,
  //   'jun': 5,
  //   'jul': 6,
  //   'ago': 7,
  //   'set': 8,
  //   'out': 9,
  //   'nov': 10,
  //   'dez': 11
  // };

  Map<int, String> yLabels = {
    0: '0 num',
    1: '1 num',
    2: '2 num',
    3: '3 num',
    4: '4 num',
    5: '5 num',
    6: '6 num',
  };

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Scheduling>>(
      future: SchedulingService().all(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(backgroundColor: Colors.cyan),
            );
          default:
            if (snapshot.hasError) {
              return Center(
                child: Text("it wasn't get data"),
              );
            } else {
              yLabels = {
                0: '0',
                (countMonths(snapshot.data).reduce(max) / 2).toInt():
                    '${(countMonths(snapshot.data).reduce(max) / 2).toInt()}',
                countMonths(snapshot.data).reduce(max):
                    '${countMonths(snapshot.data).reduce(max)}'
              };
              return Center(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                  child: LineChart(
                    data(snapshot.data),
                    swapAnimationDuration: const Duration(milliseconds: 850),
                  ),
                ),
              );
            }
        }
      },
    );
  }

  List<int> countMonths(List<Scheduling> schedulings) {
    List<int> months = List<int>.generate(12, (index) => 0);

    for (var sch in schedulings) {
      months[sch.from.month - 1]++;
    }

    return months;
  }

  LineChartData data(List<Scheduling> schedulings) {
    return LineChartData(
      borderData: FlBorderData(show: true),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {
          print('sim');
        },
        handleBuiltInTouches: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          // rotateAngle: -60.0,
          showTitles: true,
          reservedSize: 14,
          margin: 20,
          getTextStyles: (value) => TextStyle(
              fontSize: 10, color: Colors.purple, fontWeight: FontWeight.bold),
          getTitles: (value) => xLabels[value.toInt()],
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
              fontSize: 10, color: Colors.purple, fontWeight: FontWeight.bold),
          getTitles: (value) => yLabels[value.toInt()],
        ),
      ),
      minX: 0,
      maxX: 11,
      maxY: countMonths(schedulings).reduce(max).toDouble(),
      minY: 0,
      lineBarsData: barData(schedulings),
    );
  }

  List<LineChartBarData> barData(List<Scheduling> schedulings) {
    // months[0] = 5;
    // months[1] = 2;
    // months[3] = 7;

    // print(months);
    // schedulings.map((scheduling) => FlSpot((scheduling.from.month - 1).toDouble(), y))
    return [
      LineChartBarData(
        // isCurved: true,
        spots: List.generate(
            12,
            (i) =>
                FlSpot(i.toDouble(), countMonths(schedulings)[i].toDouble())),
        colors: [
          const Color(0xff4af699),
        ],
      ),
      // LineChartBarData(
      //   isCurved: true,
      //   spots: List.generate(12, (i) => FlSpot(i.toDouble(), i.toDouble() / 2)),
      //   colors: [
      //     const Color(0xff4af699),
      //   ],
      // )
    ];
  }
}
