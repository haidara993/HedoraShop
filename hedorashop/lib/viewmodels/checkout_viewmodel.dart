import 'package:get/get.dart';
import 'package:hedorashop/helpers/shared_preferences_helper.dart';
import 'package:hedorashop/models/checkout_model.dart';
import 'package:hedorashop/models/user.dart';
import 'package:hedorashop/services/checkout_service.dart';
import 'package:hedorashop/viewmodels/auth_viewmodel.dart';
import 'package:hedorashop/viewmodels/cart_viewmodel.dart';
import 'package:hedorashop/viewmodels/home_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutViewModel extends GetxController {
  String? street, city, state, country, phone;

  List<CheckoutModel> _checkouts = [];

  List<CheckoutModel> get checkouts => _checkouts;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    _getCheckoutsFromFireStore();
  }

  _getCheckoutsFromFireStore() async {
    _isLoading = true;
    _checkouts = await CheckoutService().getAll();
    _isLoading = false;
    update();
  }

  addCheckoutToFireStore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? user = prefs.getString("userId");
    Map<String, dynamic> checkout = {
      "street": street!,
      "city": city!,
      "state": state!,
      "country": country!,
      "phone": phone!,
      "totalPrice": Get.find<CartViewModel>().totalPrice.value.toString(),
      "date": DateFormat.yMMMd().add_jm().format(DateTime.now()),
      "user": user
    };
    var rs = await CheckoutService().post(checkout);

    if (rs == true) {
      Get.find<CartViewModel>().removeAllProducts();

      _getCheckoutsFromFireStore();
    }
  }
}
