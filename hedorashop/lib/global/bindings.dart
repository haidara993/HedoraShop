import 'package:get/get.dart';
import 'package:hedorashop/viewmodels/auth_viewmodel.dart';
import 'package:hedorashop/viewmodels/cart_viewmodel.dart';
import 'package:hedorashop/viewmodels/checkout_viewmodel.dart';
import 'package:hedorashop/viewmodels/control_viewmoldel.dart';
import 'package:hedorashop/viewmodels/home_viewmodel.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => CartViewModel());
    Get.lazyPut(() => CheckoutViewModel());
  }
}
