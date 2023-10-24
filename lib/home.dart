import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String getWeekday() {
    return "Today, ${DateFormat('EEEE').format(DateTime.now())}";
  }

  String getCurrentDate() {
    return DateFormat("d MMMM yyyy").format(DateTime.now());
  }

  Widget _newCard(Widget child, double spacing) {
    return Card(
      margin: EdgeInsets.only(top: spacing / 2, bottom: spacing / 2),
      child: child,
    );
  }

  Widget _dateText(double spacing) {
    return Padding(
      padding: EdgeInsets.only(top: spacing / 2, bottom: spacing / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getWeekday(),
                style: const TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.w700, 
                  letterSpacing: 0.0
                )
              ),
              IconButton(
                onPressed: () => {}, 
                icon: const Icon(Icons.calendar_month),
                padding: const EdgeInsets.all(0.0),
                iconSize: 28,
                visualDensity: VisualDensity.compact,
              )
            ],
          ),
          Text(
            getCurrentDate(),
            style: const TextStyle(
              fontSize: 18, 
              color: Color(0xff8D8D8D), 
              letterSpacing: 0.0
            )
          )
        ]
      )
    );
  }

  Widget _weekProgress(double spacing) {
    return _newCard(
      SizedBox(
        height: 96,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 60,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Stack(
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            value: min(max(0.0, index), 8.0) / 8.0,
                            backgroundColor: Colors.black,
                            strokeWidth: 8,
                          ),
                        ),
                        Center(
                          child: Text(
                            "${index}h",
                            style: const TextStyle(
                              fontSize: 12, 
                              letterSpacing: 0.0
                            )
                          )
                        )
                      ],
                    )
                    ),
                    Text(
                      DateFormat("EE").format(DateTime.now().add(Duration(days: index))),
                      style: const TextStyle(
                        fontSize: 12, 
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
      spacing
    );
  }

  Widget _weekStats(double spacing) {
    Widget w1 = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Average\nsleep time\nthis week",
          softWrap: true,
          style: TextStyle(
            fontSize: spacing * 0.75, 
            letterSpacing: 0.0,
          )
        ),
        Row(
          children: [
            Text(
              "6.2",
              style: TextStyle(
                fontSize: spacing * 2.25, 
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              )
            ),
            Container(
              margin: EdgeInsets.only(left: spacing / 4),
              child: Text(
                "hours\nper day",
                softWrap: true,
                style: TextStyle(
                  fontSize: spacing * 0.75, 
                  letterSpacing: 0.0,
                )
              ),
            )
          ],
        )
      ],
    );

    Widget w2 = const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Quality",
          style: TextStyle(
            fontSize: 14, 
            letterSpacing: 0.0
          )
        ),
        Expanded(
          child: AspectRatio(
              aspectRatio: 1,
              child: CircularProgressIndicator(
                value: 0.7,
                backgroundColor: Colors.black,
                strokeWidth: 8,
              )
            ),
        )
      ]
    );

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: spacing / 2),
            child: _newCard(
              AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: EdgeInsets.all(spacing),
                  child: w1,
                )
              ),
              spacing
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: spacing / 2),
            child: _newCard(
              AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: EdgeInsets.all(spacing / 2),
                  child: SizedBox.expand(
                    child: w2,
                  ),
                ),
              ),
              spacing
            ),
          )
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    double spacing = MediaQuery.of(context).size.width / 20;

    return Padding(
      padding: EdgeInsets.only(top: 50, right: spacing, left: spacing),
      child: Column(
        children: [
          _dateText(spacing),
          _weekProgress(spacing),
          _weekStats(spacing),
        ]
      )
    );
  }
}
