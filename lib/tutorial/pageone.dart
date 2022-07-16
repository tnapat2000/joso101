import 'package:flutter/material.dart';
import '../utils/colors.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background_green,
        child: Center(
            child: Container(
              width: 300,
              height: 300,
              padding: new EdgeInsets.all(7.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: light_green,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        subtitle: Text(
                            'Hello,\n\nI am your trip assistant. Car accidents occur frequently in Bangkok, Thailand.\n\nI will let you know if you are in the area where accidnets may occur.\n\nTutotial is in the next page.',
                            style: TextStyle(fontSize: 18.0)
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            )
        )

    );

//   Container(
    //   color: background_green,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       Image.asset("assets/images/accidents.png"),
    //       Padding(
    //         padding: EdgeInsets.all(20),
    //         child: Text(
    //           "Play with the data",
    //           style: TextStyle(color: Colors.purpleAccent, fontSize: 36),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}