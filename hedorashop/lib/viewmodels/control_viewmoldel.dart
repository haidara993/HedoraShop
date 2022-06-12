import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedorashop/pages/home_page.dart';
import 'package:hedorashop/pages/profile_view.dart';

class ControlViewModel extends GetxController {
  int _navigationValue = 0;
  get navigationValue => _navigationValue;

  Widget _currentScreen = HomePage();

  get currentScreen => _currentScreen;

  void changeSelectedValue(int selectedValue) {
    _navigationValue = selectedValue;
    switch (selectedValue) {
      case 0:
        {
          _currentScreen = HomePage();
          break;
        }
      case 1:
        {
          _currentScreen = ProfileView();
          break;
        }
    }
    update();
  }
}
