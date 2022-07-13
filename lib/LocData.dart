import 'package:flutter/cupertino.dart';
import 'package:latlong/latlong.dart';

class LocData with ChangeNotifier {
  String _greeting = "Konijiwa";
  LatLng _locData = LatLng(37.422, -122.084);

  void changeGreeting(String newGreeting) {
    _greeting = newGreeting;
    notifyListeners();
  }

  void changePos(LatLng latLng) {
    _locData = latLng;
    notifyListeners();
  }

  Widget changePosWidget(LatLng latLng){
    _locData = latLng;
    notifyListeners();
    return Container();
  }

  String get greeting => _greeting;
  LatLng get locData => _locData;
}