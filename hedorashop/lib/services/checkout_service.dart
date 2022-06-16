import 'dart:convert';

import 'package:get/get.dart';
import 'package:hedorashop/helpers/http_helper.dart';
import 'package:hedorashop/models/checkout_model.dart';
import 'package:hedorashop/viewmodels/auth_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutService {
  Future<List<CheckoutModel>> getAll() async {
    // TODO: implement getAll
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = await pref.getString("userId");
    var token = pref.getString("jwt");
    var rs = await HttpHelper.get(CHECKOUT_ENDPOINT + '/${userId}',
        bearerToken: token);
    // print(rs.statusCode);
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;

      var checkouts = jsonList.map((j) => CheckoutModel.fromJson(j)).toList();
      return checkouts;
    }
    return [];
  }

  Future<bool> post(Map<String, dynamic> checkoutModel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var token = pref.getString("jwt");
    var rs = await HttpHelper.post(CHECKOUT_ENDPOINT, checkoutModel,
        bearerToken: token);
    // print(rs.statusCode);
    if (rs.statusCode == 200) {
      var checkout = jsonDecode(rs.body);

      return true;
    }
    return false;
  }
}
