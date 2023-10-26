import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sleep_wise/helpers/config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String getWeekday() {
    return "Today, ${DateFormat('EEEE').format(DateTime.now())}";
  }

  String getCurrentDate() {
    return DateFormat("d MMMM yyyy").format(DateTime.now());
  }

  Widget _newCard(Widget child) {
    return Card(
      margin: EdgeInsets.only(top:AppConfig.spacing / 2, bottom:AppConfig.spacing / 2),
      child: child,
    );
  }

  Widget _dateText() {
    return Padding(
      padding: EdgeInsets.only(bottom:AppConfig.spacing / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getWeekday(),
                style: TextStyle(
                  fontSize: 24 * AppConfig.fontScaling, 
                  fontWeight: FontWeight.w700, 
                  letterSpacing: 0.0
                )
              ),
              IconButton(
                onPressed: () => {}, 
                icon: const Icon(Icons.calendar_month),
                padding: const EdgeInsets.all(0.0),
                iconSize: 24 * AppConfig.fontScaling,
              )
            ],
          ),
          Text(
            getCurrentDate(),
            style: TextStyle(
              fontSize: 18 * AppConfig.fontScaling, 
              color: const Color(0xff8D8D8D), 
              letterSpacing: 0.0
            )
          )
        ]
      )
    );
  }

  Widget _weekProgress() {
    return _newCard(
      SizedBox(
        height: 112 * AppConfig.fontScaling,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical:AppConfig.spacing / 2, horizontal:AppConfig.spacing / 2),
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal:AppConfig.spacing / 2),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                        children: [
                          SizedBox(
                            width: 48 * AppConfig.fontScaling,
                            height: 48 * AppConfig.fontScaling,
                            child: CircularProgressIndicator(
                              value: min(max(0.0, index), 8.0) / 8.0,
                              backgroundColor: Colors.black,
                              strokeWidth: 8 * AppConfig.fontScaling,
                              strokeAlign: 0,
                              strokeCap: StrokeCap.round,
                            ),
                          ),
                          SizedBox(
                            width: 48 * AppConfig.fontScaling,
                            height: 48 * AppConfig.fontScaling,
                            child: Center(
                              child: Text(
                                "${index}h",
                                style: TextStyle(
                                  fontSize: 16 * AppConfig.fontScaling, 
                                  letterSpacing: 0.0
                                )
                              )
                            ),
                          )
                        ],
                      ),
                    Text(
                      DateFormat("EE").format(DateTime.now().add(Duration(days: index))),
                      style: TextStyle(
                        fontSize: 16 * AppConfig.fontScaling, 
                        letterSpacing: 0.0
                      )
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _weekStats() {
    Widget w1 = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Average\nsleep time\nthis week",
          softWrap: true,
          style: TextStyle(
            fontSize: 18 * AppConfig.fontScaling, 
            letterSpacing: 0.0,
          )
        ),
        Row(
          children: [
            Text(
              "6.2",
              style: TextStyle(
                fontSize: 44 * AppConfig.fontScaling, 
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              )
            ),
            Container(
              margin: EdgeInsets.only(left:AppConfig.spacing / 4),
              child: Text(
                "hours\nper day",
                softWrap: true,
                style: TextStyle(
                  fontSize: 16 * AppConfig.fontScaling, 
                  letterSpacing: 0.0,
                )
              ),
            )
          ],
        )
      ],
    );

    Widget qualityCircularWidget = Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: CircularProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.black,
              strokeWidth: 16 * AppConfig.fontScaling,
              strokeAlign: -1,
              strokeCap: StrokeCap.round,
            ),
          )
        ),
        const Center(
          child: Text(
            "100%",
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w800,
              letterSpacing: 0.0
            )
          )
        )
      ],
    );

    Widget w2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom:AppConfig.spacing / 4),
          child: const Text(
            "Quality",
            style: TextStyle(
              fontSize: 14, 
              letterSpacing: 0.0
            )
          ),
        ),
        Expanded(
          child: qualityCircularWidget
        )
      ]
    );

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right:AppConfig.spacing / 2),
            child: _newCard(
              AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: EdgeInsets.all(AppConfig.spacing / 1.5),
                  child: w1,
                )
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left:AppConfig.spacing / 2),
            child: _newCard(
              AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: EdgeInsets.all(AppConfig.spacing / 1.5),
                  child: SizedBox.expand(
                    child: w2,
                  ),
                ),
              ),
            ),
          )
        )
      ]
    );
  }

  Widget _lastSleepInfo() {
    Widget parameter(IconData icon, String label, String value) => Container(
      margin: EdgeInsets.only(top: AppConfig.spacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: AppConfig.spacing / 4),
            child: Icon(icon),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20 * AppConfig.fontScaling, 
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.0
                )
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14 * AppConfig.fontScaling, 
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.0,
                  color: const Color(0xff8D8D8D)
                )
              ),
            ],
          )
        ],
      ),
    );

    return _newCard(
      Padding(
        padding: EdgeInsets.symmetric(vertical: AppConfig.spacing, horizontal: AppConfig.spacing),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Last sleep information:",
                style: TextStyle(
                  fontSize: 18 * AppConfig.fontScaling, 
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.0,
                )
              )
            ),
            Row(
              children: [
                Expanded(child: parameter(Icons.nights_stay_outlined, "Time in sleep", "6h 52m")),
                Expanded(child: parameter(Icons.cloud_outlined, "Wake up time", "07:12 AM")),
              ],
            ),
            Row(
              children: [
                Expanded(child: parameter(Icons.access_time_outlined, "Went to bed", "7h 23m")),
                Expanded(child: parameter(Icons.snooze_outlined, "Fell asleep", "25 min")),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _graph() {
    SideTitleWidget leftTitleWidgets(double value, TitleMeta meta) {
      TextStyle style = TextStyle(
        fontSize: 14 * AppConfig.fontScaling,
      );
      
      Widget text;
      if (value < 0.0 || value > 24.0) {
        text = Text(
          "",
          style: style
        );
      }
      else {
        text = Text(
          value.truncate().toString(),
          style: style
        );
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 6,
        child: text,
      );
    }

    Widget bottomTitleWidgets(double value, TitleMeta meta) {
      TextStyle style = TextStyle(
        fontSize: 14 * AppConfig.fontScaling,
      );

      Widget text = Text(
        DateFormat("EE").format(DateTime.now().add(Duration(days: value.truncate()))),
        style: style
      );

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 6,
        child: text,
      );
    }

    FlTitlesData titles = FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: AppConfig.spacing * 1.5,
          showTitles: true,
          getTitlesWidget: leftTitleWidgets,
          interval: 2,
        )
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: AppConfig.spacing * 1.5,
          showTitles: true,
          getTitlesWidget: bottomTitleWidgets,
          interval: 1,
        )
      )
    );
                      
    LineChartBarData barData = LineChartBarData(
      spots: [
        const FlSpot(0.2, 1.0),
        const FlSpot(0.5, 2.0),
        const FlSpot(2.0, 0.0),
        const FlSpot(3.0, 12.0),
      ],
      preventCurveOverShooting: true,
      barWidth: 8,
      isStrokeCapRound: true,
      isCurved: true,
      gradient: const LinearGradient(
        colors: [
          Color(0xffbe70df),
          Color(0xff9d74e1),
          Color(0xff5676d4),
          Color(0xff3274c4),
        ]
      ),
      dotData: const FlDotData(show: false),
    );

    return _newCard(
      Padding(
        padding: EdgeInsets.only(left: AppConfig.spacing, top: AppConfig.spacing, right: AppConfig.spacing * 1.5, bottom: AppConfig.spacing),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Weekly sleep",
                style: TextStyle(
                  fontSize: 18 * AppConfig.fontScaling, 
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.0,
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: AppConfig.spacing),
              height: 160,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    barData
                  ],
                  gridData: FlGridData(drawVerticalLine: false, getDrawingHorizontalLine: (value) => const FlLine(color: Color(0xff3b3b51), strokeWidth: 1, dashArray: [2, 0])),
                  titlesData: titles,
                  borderData: FlBorderData(show: false),
                  clipData: const FlClipData.all(),
                  baselineY: 8.0,
                  minY: -1,
                  minX: 0,
                  maxX: 4
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppConfig.spacing),
      child: ListView(
        children: [
          _dateText(),
          _weekProgress(),
          _weekStats(),
          _lastSleepInfo(),
          _graph()
        ]
      )
    );
  }
}
