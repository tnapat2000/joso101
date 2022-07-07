import 'package:flutter/material.dart';
import 'pageone.dart';
import 'pagetwo.dart';
import 'pagethree.dart';
import 'homepage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // comment it before launching
  final prefs = await SharedPreferences.getInstance();

  prefs.clear();
  final bool shallShowHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(
    showHome: shallShowHome,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({required this.showHome});
  final bool showHome;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: showHome
          ? const HomePage()
          : const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                  MaterialPageRoute(builder: (context) => HomePage()));
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
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Welcome Screen',
//       home: WelcomeScreen(),
//       ),
//       // initialRoute: '/',
//       // routes: {
//       //   '/': (context) => InsertNamePage(),
//       //   // '/wheel': (context) => WheelPage(nameController: ),
//       //   // '/detail': (context) => DetailScreen(),
//       //   // '/exdetail': (context) => ExtraDetailScreen(),
//       // },
//     );
//   }
// }