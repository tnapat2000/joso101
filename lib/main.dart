import 'package:flutter/material.dart';
import 'package:joso101/LocData.dart';
import 'package:joso101/map_screen.dart';
import 'package:joso101/pageone.dart';
import 'package:joso101/pagethree.dart';
import 'package:joso101/pagetwo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'shared';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // comment it before launching
  final prefs = await SharedPreferences.getInstance();

  prefs.clear();
  final bool shallShowHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(
    showMap: shallShowHome,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.showMap}) : super(key: key);

  final bool showMap;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: showMap
          ? const MapScreen()
          : const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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
          children: [
            PageOne(),
            PageTwo(),
            PageThree(),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Padding(
              padding: EdgeInsets.fromLTRB(90, 0, 20, 15),
              child: TextButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MapScreen()));
                  },
                  child: Text('Proceed to the App',
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
