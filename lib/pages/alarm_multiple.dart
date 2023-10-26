import 'dart:io';
import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sleep_wise/helpers/config.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  DateTime? _alarmTime;
  late List<bool> _selectedWeekdays;
  late int _alarmId;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmId = Alarm.getAlarms().map((e) => e.id).fold(0, max);
    _selectedWeekdays = DateFormat.EEEE(Platform.localeName).dateSymbols.SHORTWEEKDAYS.map((e) {
        return false;
    }).toList();                   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Permission.activityRecognition.request();

    return Padding(
      padding: EdgeInsets.only(top: AppConfig.spacing, right: AppConfig.spacing, left: AppConfig.spacing),
      child: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: AppConfig.spacing),
                child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Schedule sleep:",
                        style: TextStyle(
                          fontSize: 24 * AppConfig.fontScaling, 
                          fontWeight: FontWeight.w700, 
                          letterSpacing: 0.0
                        )
                      ),
                      IconButton(
                        onPressed: () {
                          _selectedWeekdays = DateFormat.EEEE(Platform.localeName).dateSymbols.SHORTWEEKDAYS.map((e) {
                              return false;
                          }).toList();
                          showModalBottomSheet(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            useRootNavigator: true,
                            isScrollControlled: true,
                            useSafeArea: true,
                            enableDrag: false,
                            isDismissible: false,
                            context: context,
                            clipBehavior: Clip.antiAlias,
                            shape: const Border(),
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: AppConfig.spacing / 4, horizontal: AppConfig.spacing),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.close),
                                              iconSize: 28 * AppConfig.fontScaling,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                // onSaveAlarm(_selectedWeekdays);
                                                print(_alarmTime);
                                                await Alarm.set(
                                                  alarmSettings: AlarmSettings(
                                                    id: _alarmId, 
                                                    dateTime: _alarmTime!, 
                                                    assetAudioPath: "assets/alarms/alarm-1.mp3"
                                                  )
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5 * AppConfig.fontScaling),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10 * AppConfig.fontScaling)),
                                                  border: Border.all(
                                                    width: 2,
                                                    color: Theme.of(context).primaryColor,
                                                  )
                                                ),
                                                child: Text(
                                                  "Save",
                                                  style: TextStyle(
                                                    fontSize: 20 * AppConfig.fontScaling, 
                                                    fontWeight: FontWeight.w700, 
                                                    letterSpacing: 0.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],  
                                        ),
                                      ),
                                      const Divider(),
                                      Padding(
                                        padding: EdgeInsets.all(AppConfig.spacing),
                                        child: Column(
                                          children: [
                                            TimePickerSpinner(
                                              normalTextStyle: TextStyle(
                                                fontSize: 18 * AppConfig.fontScaling, 
                                                fontWeight: FontWeight.w400, 
                                                letterSpacing: 0.0,
                                                color: Colors.grey[600],
                                              ),
                                              highlightedTextStyle: TextStyle(
                                                fontSize: 24 * AppConfig.fontScaling, 
                                                fontWeight: FontWeight.w800, 
                                                letterSpacing: 0.0,
                                                color: Colors.white,
                                              ),
                                              isForce2Digits: true,
                                              // spacing: spacing / 2,
                                              itemHeight: 36 * AppConfig.fontScaling,
                                              is24HourMode: false,
                                              alignment: Alignment.center,
                                              onTimeChange: (time) {
                                                  print(time);
                                                  setState(() {
                                                    _alarmTime = time;
                                                  });
                                              },
                                            ),
                                            ExpandablePanel(
                                              theme: ExpandableThemeData(
                                                headerAlignment: ExpandablePanelHeaderAlignment.center,
                                                iconColor: Theme.of(context).primaryColor
                                              ),
                                              header: Padding(
                                                padding: EdgeInsets.only(left: AppConfig.spacing / 2),
                                                child: Text(
                                                  'Repeat', 
                                                  style: TextStyle(
                                                    fontSize: 16 * AppConfig.fontScaling, 
                                                    fontWeight: FontWeight.w800, 
                                                    letterSpacing: 0.0,
                                                    color: Colors.white,
                                                  )
                                                ),
                                              ),
                                              expanded: Center(
                                                child: ToggleButtons(
                                                  isSelected: _selectedWeekdays,
                                                  constraints: BoxConstraints.tight(Size.square(AppConfig.spacing * 2)),
                                                  borderRadius: BorderRadius.all(Radius.circular(AppConfig.spacing / 2)),
                                                  borderWidth: 2,
                                                  onPressed: (int index) {
                                                    setState(() {
                                                      _selectedWeekdays[index] = !_selectedWeekdays[index];
                                                    });
                                                  },
                                                  children: DateFormat.EEEE(Platform.localeName).dateSymbols.SHORTWEEKDAYS.map((e) {
                                                    return Text(e);
                                                  }).toList(),
                                                ), 
                                              ),
                                              collapsed: Container(),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        }, 
                        icon: const Icon(Icons.add),
                        padding: const EdgeInsets.all(0.0),
                        iconSize: 28 * AppConfig.fontScaling,
                      )
                    ],
                  )
              ),
              Builder(
                builder: (context) {
                  return Column(
                    children: Alarm.getAlarms().map((alarm) {
                      var alarmTime = DateFormat('hh:mm aa').format(alarm.dateTime);
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: AppConfig.spacing / 2),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: AppConfig.spacing / 2, horizontal: AppConfig.spacing),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.label,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        alarm.notificationTitle ?? "empty",
                                        style: const TextStyle(color: Colors.white, fontFamily: 'avenir'),
                                      ),
                                    ],
                                  ),
                                  Switch(
                                    onChanged: (bool value) {},
                                    value: true,
                                    activeColor: Colors.white,
                                  ),
                                ],
                              ),
                              const Text(
                                'Mon-Fri',
                                style: TextStyle(color: Colors.white, fontFamily: 'avenir'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    alarmTime,
                                    style: const TextStyle(
                                        color: Colors.white, fontFamily: 'avenir', fontSize: 24, fontWeight: FontWeight.w700),
                                  ),
                                  IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Colors.white,
                                      onPressed: () {
                                        Alarm.stop(alarm.id);
                                        setState(() {});
                                      }),
                                ],
                              ),
                            ],
                          ),
                        )
                      );
                    }).toList()
                  );
                }
              )
            ]
          ),
        ]
      ),
    );
  }
}