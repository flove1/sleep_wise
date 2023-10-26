import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:sleep_wise/helpers/config.dart';
import 'package:sleep_wise/pages/main.dart';
import 'package:sleep_wise/helpers/settings.dart';
import 'package:sleep_wise/pages/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Alarm.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppConfig.init(context);

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
      home: FutureBuilder<bool>(
        future: SettingsRepository.getSkipIntroduction(), 
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return const MainPage();
          }
          return const WelcomePage();
        }
      ),
    );
  }
}