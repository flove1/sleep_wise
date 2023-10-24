import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sleep_wise/main.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainPage()),
    );
  }

  Widget _buildImage(String assetName, [double width = 175]) {
    return Image.asset('assets/$assetName', width: width, height: width);
  }
    @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
          PageViewModel(
            title: "Sleep patterns",
            body: "Track your sleep patterns and improve your sleep habits with SleepWise",
            image: Center(
              child: _buildImage("images/welcome_1.png")
            )
          ),
          PageViewModel(
            title: "Tips & tricks",
            body: "Get personalized tips and resources to help you sleep better with SleepWise",
            image: Center(
              child: _buildImage("images/welcome_2.png")
            )
          ),
          PageViewModel(
            title: "No more insomnia!",
            body: "Say goodbye to insomnia with SleepWise's interactive and engaging approach",
            image: Center(
              child: _buildImage("images/welcome_3.png")
            )
          )
      ],
      onDone: () => _onIntroEnd(context),
      // onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      showBackButton: false,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(4),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
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
