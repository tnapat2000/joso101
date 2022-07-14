import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:joso101/basecard.dart';
import 'package:joso101/colors.dart';
import 'package:joso101/map_screen.dart';
import 'package:joso101/register_screen.dart';

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

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  void initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () async {
                if (email == "" && password == "") {
                  setState(() {
                    errorMsg = "Please log in to use the app";
                  });
                } else {
                  setState(() {
                    errorMsg = "";
                  });
                }
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  print("login $email, $password");
                  if (user != null) {
                    print("POP TO MAP SCREEN");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MapScreen()));
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
