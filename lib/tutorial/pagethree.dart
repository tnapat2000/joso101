import 'package:flutter/material.dart';
import '../utils/colors.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background_green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            // color: Colors.blue,
            // height: 100,
            // width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  'assets/images/rescan.png',
                  height: 100,
                ),
                Image.asset(
                  'assets/images/recenter.png',
                  height: 100,
                ),
                Image.asset(
                  'assets/images/report_accidents.png',
                  height: 100,
                ),
                Image.asset(
                  'assets/images/pin_accident.png',
                  height: 100,
                ),
              ],
            ),
          ),
          Container(
            //   color: Colors.amber,
            //   width: 100,
            // height: 100
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  // Text(),
                  child: Text(
                    '"Rescan" lets you\nrefresh your\ndatabase again',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  // Text(),
                  child: Text(
                    '"Recenter" changes\nthe user pin to the\ncenter of the map',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  // Text(),
                  child: Text(
                    'You can report an\naccident here',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  // Text(),
                  child: Text(
                    'You can pin the\nlocation the accident\noccurs and give\nmore information',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
