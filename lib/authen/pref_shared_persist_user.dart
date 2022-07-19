import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistingUser {
  late SharedPreferences prefs;

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void persistUser(String email, String password) async {
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
}
