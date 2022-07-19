import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joso101/tutorial/myhomepage.dart';
import 'package:joso101/utils/basecard.dart';
import 'package:joso101/utils/colors.dart';
import 'package:joso101/map/map_screen.dart';
import 'package:joso101/authen/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../map/MapData.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FirebaseAuth _auth;
  String email = "";
  String password = "";
  String errorMsg = "";
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    // await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    prefs = await SharedPreferences.getInstance();
  }

  void persistUser() async {
    prefs.setString("currentUserEmail", email);
    prefs.setString("currentUserPassword", password);
  }

  String getUserEmail() {
    return prefs.getString("currentUserEmail") ?? "no one";
  }

  String getUserPass() {
    return prefs.getString("currentUserPassword") ?? "no one";
  }

  void setLoggedIn(bool value) {
    prefs.setBool("loggedIn", value);
  }

  bool getLoginStatus() {
    return prefs.getBool("loggedIn") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_green,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(hintText: "Username"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(hintText: "Password"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                errorMsg,
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
            BaseCard(
              color: light_green,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () async {
                if ((email == "" || password == "")) {
                  setState(() {
                    errorMsg = "Please log in to use the app";
                  });
                } else {
                  setState(() {
                    errorMsg = "";
                  });
                }
                try {
                  await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  String user = _auth.currentUser?.email ?? "NO ONE";
                  if (user != "NO ONE") {
                    persistUser();
                    setLoggedIn(true);
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) => MapData(),
                                  child: MapScreen(
                                    // currentUsername: user,
                                    // currentPassword: password,
                                  ),
                                )));
                  } else {
                    setState(() {
                      errorMsg = "Incorrect Username or Password";
                    });
                  }
                } catch (e) {
                  print(e);
                }
                print("login $email, $password");
              },
            ),
            BaseCard(
              color: light_green,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
                print("register");
              },
            ),
          ],
        ),
      ),
    );
  }
}
