import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/current_location.png"),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Create dashboard",
              style: TextStyle(color: Colors.purpleAccent, fontSize: 36),
            ),
          )
        ],
      ),
    );
  }
}
