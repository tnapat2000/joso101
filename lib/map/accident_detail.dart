import 'package:flutter/material.dart';
import 'package:joso101/map/accident_class.dart';

class AccidentDetailScreen extends StatelessWidget {
  const AccidentDetailScreen({Key? key, required this.accident})
      : super(key: key);

  final Accident accident;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Title"),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text(accident.email),
                Text(accident.acc_date.toDate().toString()),
                Text(accident.lat.toString()),
                Text(accident.lng.toString()),
                Text(accident.expw_step),
                Text(accident.injured.toString()),
                Text(accident.death.toString()),
                Text(accident.cause),
              ],
            ),
          ),
        ));
  }
}
