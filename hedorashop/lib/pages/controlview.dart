// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedorashop/pages/auth/login_view.dart';
import 'package:hedorashop/pages/auth/sign_up/sign_up_page.dart';
import 'package:hedorashop/pages/home_page.dart';
import 'package:hedorashop/viewmodels/auth_viewmodel.dart';
import 'package:hedorashop/viewmodels/control_viewmoldel.dart';

class ControlView extends GetWidget<AuthViewModel> {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().isLogged.value == false)
          ? SignUpPage()
          : GetBuilder<ControlViewModel>(
              init: ControlViewModel(),
              builder: (controller) {
                return Scaffold(
                  body: HomePage(),
                );
              },
            );
    });
  }
}
