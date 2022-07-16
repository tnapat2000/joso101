import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:joso101/map/MapData.dart';
import 'package:joso101/tutorial/myhomepage.dart';

import 'package:joso101/report/report_screen.dart';

// import 'package:joso101/LocData.dart';
import 'map/map_screen.dart';
import 'tutorial/pageone.dart';
import 'tutorial/pagethree.dart';
import 'tutorial/pagetwo.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'map/map_screen.dart';
// import 'shared';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // comment it before launching
  final prefs = await SharedPreferences.getInstance();

  prefs.clear();
  final bool shallShowHome = prefs.getBool('showHome') ?? false;
  final bool isLoggedIn = prefs.getBool('loggedIn') ?? false;

  runApp(MyApp(
    showMap: shallShowHome,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.showMap, required this.isLoggedIn})
      : super(key: key);

  final bool showMap;
  final bool isLoggedIn;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        // title: 'Flutter Demo',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        // home:
        //     // RegisterScreen()
        //     // LoginScreen()
        //     // showMap
        //     //     ? ChangeNotifierProvider(
        //     //         create: (context) => MapData(),
        //     //         child: MapScreen(),
        //     //       )
        //     //     : const MyHomePage(),
        //     ChangeNotifierProvider(
        //   create: (context) => MapData(),
        //   child: MapScreen(),
        // ));

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      // RegisterScreen()
      // LoginScreen()
      // showMap
      //     ? const MapScreen()
      //     : const MyHomePage(title: 'Flutter Demo Home Page'),
      // MapScreen()
      ReportScreen()
    );

  }
}
