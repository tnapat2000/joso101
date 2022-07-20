import 'package:flutter/material.dart';

class MapData with ChangeNotifier {
  bool _isInDanger = false;
  Color _statusColor = Colors.greenAccent;
  Color dangerColor = Colors.yellowAccent;
  Color safeColor = Colors.greenAccent;

  void inDanger() {
    _isInDanger = true;
    _statusColor = dangerColor;
    notifyListeners();
  }

  void inSafe() {
    _isInDanger = false;
    _statusColor = safeColor;
    notifyListeners();
  }

  bool get isInDanger => _isInDanger;
  Color get statusColor => _statusColor;
}
