import 'package:flutter/material.dart';
import 'package:joso101/utils/colors.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: app_darkblue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
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
          Column(
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
        ],
      ),
    );
  }
}
