import 'package:flutter/material.dart';

class MapData with ChangeNotifier {
  bool _activeStatus = false;
  Color _statusColor = Colors.red;

  void setActive() {
    _activeStatus = true;
    _statusColor = Colors.greenAccent;
    notifyListeners();
  }

  void setInactive() {
    _activeStatus = false;
    _statusColor = Colors.red;
    notifyListeners();
  }

  void setAlert() {
    _statusColor = Colors.yellow;
    notifyListeners();
  }

  void setNotAlert() {
    _statusColor = Colors.greenAccent;
    notifyListeners();
  }

  bool get activeStatus => _activeStatus;
  Color get statusColor => _statusColor;
}
