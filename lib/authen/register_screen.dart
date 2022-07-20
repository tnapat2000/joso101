import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:joso101/utils/basecard.dart';
import 'package:joso101/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../map/map_data.dart';
import '../map/map_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                "REGISTER",
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
              padding: EdgeInsets.all(2.0),
              child: Text(
                errorMsg,
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
            BaseCard(
              color: light_green,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () async {
                if (email == "" || password == "") {
                  setState(() {
                    errorMsg = "Invalid Username or Password";
                  });
                  return;
                } else {
                  setState(() {
                    errorMsg = "";
                  });
                }
                try {
                  await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  // print("$email with $password created");
                  await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  String user = _auth.currentUser?.email ?? "NO ONE";
                  if (user != "NO ONE") {
                    prefs.setString("latestUser", user);
                    prefs.setString("latestUserPass", password);
                    prefs.setBool('showHome', true);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) => MapData(),
                                  child: MapScreen(),
                                )));
                  } else {
                    setState(() {
                      errorMsg = "Login is failed";
                    });
                  }
                } catch (e) {
                  print(e);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
