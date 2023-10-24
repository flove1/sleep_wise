import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sleep_wise/home.dart';
import 'package:sleep_wise/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SleepWise',
      theme: ThemeData(
        primaryColor: const Color(0xffffbe55),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffffbe55), 
          background: const Color(0xff0b0b19),
          onBackground: const Color(0xffffffff),
          surface: const Color(0xff14142F),
          secondaryContainer: const Color(0xffffbe55),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: "OpenSans"
        // scaffoldBackgroundColor: const Color(0xff0b0b19)
      ),
      home: const WelcomePage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
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
      extendBody: true,//<------like this 
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
              icon: const Icon(Icons.home)
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.book)
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.settings)
            ),
          ],
      ),
    );
  }
}