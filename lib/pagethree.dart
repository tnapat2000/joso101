import 'package:flutter/material.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/report.png"),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Interact with it",
              style: TextStyle(color: Colors.purpleAccent, fontSize: 36),
            ),
          )
        ],
      ),
    );
  }
}