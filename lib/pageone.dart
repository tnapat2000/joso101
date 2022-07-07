import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/accidents.png"),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Play with the data",
              style: TextStyle(color: Colors.purpleAccent, fontSize: 36),
            ),
          )
        ],
      ),
    );
  }
}