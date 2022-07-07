import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "The App",
              style: TextStyle(color: Colors.purpleAccent, fontSize: 36),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "bla bla bla",
              style: TextStyle(color: Colors.purpleAccent, fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
