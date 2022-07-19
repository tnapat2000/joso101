import 'package:flutter/material.dart';
import 'package:joso101/authen/login_screen.dart';
import 'package:joso101/tutorial/pageone.dart';
import 'package:joso101/tutorial/pagethree.dart';
import 'package:joso101/tutorial/pagetwo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../map/MapData.dart';
import '../map/map_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() => isLastPage = (index == 2));
          },
          children: [PageOne(), PageTwo(), PageThree()],
        ),
      ),
      bottomSheet: isLastPage
          ? Padding(
              padding: EdgeInsets.fromLTRB(110, 0, 20, 15),
              child:
                  // Text('Please Login', style: TextStyle(fontSize: 32))
                  TextButton(
                      onPressed: ()  {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                        // }
                      },
                      child: Text('Proceed to Login',
                          style: TextStyle(fontSize: 24))),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => pageController.jumpToPage(2),
                      child: Text('SKIP')),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: WormEffect(
                          dotHeight: 30,
                          dotWidth: 30,
                          spacing: 20,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.blue),
                      onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                    ),
                  ),
                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: Text('NEXT'))
                ],
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
