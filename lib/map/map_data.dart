import 'package:flutter/material.dart';
import 'package:joso101/utils/colors.dart';

class MapData with ChangeNotifier {
  bool _isInDanger = false;
  Color _statusColor = app_green;
  Color dangerColor = app_yellow;
  Color safeColor = app_green;

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
