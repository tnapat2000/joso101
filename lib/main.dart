import 'package:flutter/material.dart';
import 'package:joso101/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      home:
      // RegisterScreen()
      LoginScreen()
      // showMap
      //     ? const MapScreen()
      //     : const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
