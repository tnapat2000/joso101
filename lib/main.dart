import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joso101/map/MapData.dart';
import 'package:joso101/tutorial/myhomepage.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'map/map_screen.dart';
// import 'shared';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // comment it before launching
  final prefs = await SharedPreferences.getInstance();

  // prefs.clear();
  final bool shallShowHome = prefs.getBool('showHome') ?? false;
  final bool isLoggedIn = prefs.getBool('loggedIn') ?? false;

  final String latestUser = prefs.getString('currentUserEmail') ?? "no one";
  final String latestPass = prefs.getString('currentUserPassword') ?? "";

  print("$latestUser ,$latestPass");

  runApp(MyApp(
    showMap: shallShowHome,
    latestUser: latestUser,
    latestPass: latestPass,
  ));
}

class MyApp extends StatelessWidget {
  MyApp(
      {Key? key,
      required this.showMap,
      required this.latestUser,
      required this.latestPass})
      : super(key: key);

  final bool showMap;
  final String latestUser;
  final String latestPass;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          // RegisterScreen()
          // LoginScreen()
          showMap
              ? ChangeNotifierProvider(
                  create: (context) => MapData(),
                  child: MapScreen(
                    // currentUsername: latestUser,
                    // currentPassword: latestPass,
                  ),
                )
              : const MyHomePage(),
      //     ChangeNotifierProvider(
      //   create: (context) => MapData(),
      //   child: MapScreen(),
      // )
    );
  }
}
