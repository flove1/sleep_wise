import 'dart:math';

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sleep_wise/pages/main.dart';
import 'package:sleep_wise/helpers/settings.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    SettingsRepository.setSkipIntroduction(true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainPage()),
    );
  }

  Widget _buildImage(String assetName, {double width = 175}) {
    return Image.asset('assets/$assetName', width: width, height: width,);
  }
    @override
  Widget build(BuildContext context) {
    double fontScaling = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) * 0.0025;

    return IntroductionScreen(
      pages: [
          PageViewModel(
            titleWidget: Container(),
            bodyWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "Track your sleep patterns and improve your sleep habits with SleepWise", 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600, 
                  fontSize: 16 * fontScaling,
                )
              ),
            ),
            image: Center(
              child: _buildImage("images/welcome_1.png", width: MediaQuery.of(context).size.width)
            ),
            decoration: PageDecoration(
              imagePadding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              imageFlex: 6,
              bodyFlex: 4
              // bodyAlignment: Alignment.bottomCenter
            )
          ),
          PageViewModel(
            titleWidget: Container(),
            bodyWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Text(
              "Get personalized tips and resources to help you sleep better with SleepWise", 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600, 
                  fontSize: 16 * fontScaling,
                )
              ),
            ),
            image: Center(
              child: _buildImage("images/welcome_2.png", width: MediaQuery.of(context).size.width)
            ),
            decoration: PageDecoration(
              imagePadding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              imageFlex: 6,
              bodyFlex: 4
              // bodyAlignment: Alignment.bottomCenter
            )
          ),
          PageViewModel(
            titleWidget: Container(),
            bodyWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Text(
              "Say goodbye to insomnia with SleepWise's interactive and engaging approach", 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,  
                  fontSize: 16 * fontScaling,
                )
              ),
            ),
            image: Center(
              child: _buildImage("images/welcome_3.png", width: MediaQuery.of(context).size.width)
            ),
            decoration: PageDecoration(
              imagePadding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              imageFlex: 6,
              bodyFlex: 4
              // bodyAlignment: Alignment.bottomCenter
            )
          )
      ],
      onDone: () => _onIntroEnd(context),
      // onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      showBackButton: false,
      skip: Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16 * fontScaling)),
      next: Icon(Icons.arrow_forward, size: 32 * fontScaling),
      done: Text('Done', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16 * fontScaling)),
      curve: Curves.fastLinearToSlowEaseIn,
      dotsDecorator: DotsDecorator(
        size: Size(MediaQuery.of(context).size.width * 0.025, MediaQuery.of(context).size.width * 0.025),
        color: const Color(0xFFBDBDBD),
        activeSize: Size(MediaQuery.of(context).size.width * 0.05, MediaQuery.of(context).size.width * 0.025),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      // dotsContainerDecorator: const ShapeDecoration(
      //   color: Colors.black87,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
      //   ),
      // ),
    );
  }
}
