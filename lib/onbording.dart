import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
  }

  Widget _buildImage(String assetName, [double width = 200]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "",
          body:
              "مرحبًا بكم في BeeKeeper! ساعد في حماية النحل وأعشاشه من خلال الإبلاغ عن أعشاش النحل والدبابير في منطقتك.",
          image: _buildImage('p1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: '',
          body:
              "كيفية الاستخدامالتقط صورة لأي نحلة أو عش دبابير باستخدام الكاميرا، واختر نوع العش، وضرب «تقرير». المتخصصون لدينا سوف يعتنون بالباقي!",
          image: _buildImage('p2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: '',
          body:
              " المكافآت والتأثيراربح نقاطًا لكل عش تقوم بالإبلاغ عنه واستردها مقابل مكافآت نقدية وخصومات على المنتجات الصديقة للنحل في متجرنا. ",        image: _buildImage('p3.png'),
          footer: Padding(
            padding: const EdgeInsets.only(bottom: 30,left: 15.0, right: 15.0,),
            child: ElevatedButton(
              onPressed: () {
                print("Clicked Get Started Button");
              },
              child: const Text(
                'GET STARTED',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(55), // NEW
                primary: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      showSkipButton: false,
      showDoneButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: const Text('Back',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      next: const Text('Next',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(8.0, 8.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(15.0, 5.0),
        activeColor: Colors.black,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
