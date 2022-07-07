import 'package:flutter/material.dart';
import 'package:joso101/colors.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

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
                  'assets/images/current_location.png',
                  height: 100,
                ),
                Image.asset(
                  'assets/images/report.png',
                  height: 100,
                ),
                Image.asset(
                  'assets/images/accidents.png',
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
                      'This represents\nyour current\nlocation',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  // Text(),
                  child: Text(
                    'This represents\nlocations that\nusers has\nreported an\naccident',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  // Text(),
                  child: Text(
                    'This represents\nlocations that\nhas accidents\nhappened in the\npast 2-3 days',
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




// child: new Column(
//   children: <Widget>[
//     new Row(
//       children: <Widget>[
//         new Text('first'),
//
//       ],
//     ),
//     new Row(
//       children: <Widget>[
//         new Text('sec'),
//       ],
//     ),
//     new Row(
//       children: <Widget>[
//         new Text('third'),
//       ],
//     ),
//     new Row(
//       children: <Widget>[
//         new Text('forth'),
//       ],
//     ),
//   ],
// ),




// child: Column(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     Column(
//       children: [
//
//         const Text('Instruction',
//             style: TextStyle(fontSize: 35.0)
//         ),
//       ],
//     ),
//     Column(
//       children: [
//         Icon(Icons.kitchen, color: Colors.green[500]),
//         const Text('PREP:'),
//         const Text('25 min'),
//       ],
//     ),
//     Column(
//       children: [
//         Icon(Icons.timer, color: Colors.green[500]),
//         const Text('COOK:'),
//         const Text('1 hr'),
//       ],
//     ),
//     Column(
//       children: [
//         Icon(Icons.restaurant, color: Colors.green[500]),
//         const Text('FEEDS:'),
//         const Text('4-6'),
//       ],
//     ),
//   ],
// ),
