import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontController extends ChangeNotifier {
  double _textScaleFactor = 1.0; // 12pt baseline
  String _currentLabel = '12pt';

  double get textScaleFactor => _textScaleFactor;
  String get currentLabel => _currentLabel;

  void setByLabel(String label) {
    // Map labels to relative scale based on 12pt baseline
    switch (label) {
      case '10pt':
        _textScaleFactor = 10 / 12;
        break;
      case '12pt':
        _textScaleFactor = 1.0;
        break;
      case '14pt':
        _textScaleFactor = 14 / 12;
        break;
      case '16pt':
        _textScaleFactor = 16 / 12;
        break;
      case '18pt':
        _textScaleFactor = 18 / 12;
        break;
      default:
        _textScaleFactor = 1.0;
    }
    _currentLabel = label;
    notifyListeners();
    _persist();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLabel = prefs.getString('fontLabel') ?? '12pt';
    setByLabel(_currentLabel);
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fontLabel', _currentLabel);
  }
}
