import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  Color validateTextColor = Colors.white;
  Color validateTextColorMobile = Colors.white;

  String validateText = "";
  String validateTextMobile = "";

  void setValidateEmail(String text) {
    validateText = text;
    notifyListeners();
  }

  void setValidateTextColor(Color color) {
    validateTextColor = color;
    notifyListeners();
  }

  void setValidateMobile(String text) {
    validateTextMobile = text;
    notifyListeners();
  }

  void setValidateTextColorMobile(Color color) {
    validateTextColorMobile = color;
    notifyListeners();
  }
}
