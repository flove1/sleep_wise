import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sleep_wise/pages/alarm.dart';
import 'package:sleep_wise/pages/home.dart';
import 'package:sleep_wise/pages/settings.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const AlarmPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      extendBody: true,
      bottomNavigationBar: DotNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          enableFloatingNavBar: true,
          dotIndicatorColor: Colors.transparent,
          selectedItemColor: const Color(0xffffbe55),
          unselectedItemColor: const Color(0xff949494),
          enablePaddingAnimation: false,
          splashColor: Colors.transparent,
          paddingR: const EdgeInsets.all(4.0),
          marginR: const EdgeInsets.only(
            left: 12.0,
            right: 12.0 
          ),
          items: <DotNavigationBarItem>[
            DotNavigationBarItem(
              icon: const Icon(Icons.home_outlined)
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.alarm_outlined)
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.settings_outlined)
            ),
          ],
      ),
    );
  }
}