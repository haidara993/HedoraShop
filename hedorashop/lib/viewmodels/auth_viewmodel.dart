import 'dart:convert';

import 'package:get/get.dart';
import 'package:hedorashop/enums/UserType.dart';
import 'package:hedorashop/helpers/http_helper.dart';
import 'package:hedorashop/helpers/shared_preferences_helper.dart';
import 'package:hedorashop/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthViewModel extends GetxController {
  String? email, password, name;
  User? _user = new User();
  User? get user => _user;

  UserType _userType = UserType.Customer;
  UserType get userType => _userType;

  String path = 'default';

  final isLogged = false.obs;

  AuthViewModel() {}

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("jwt");
    var jwt = token?.split(".");

    if (jwt?.length != 3) {
      isLogged.value = false;
    } else {
      var payload =
          json.decode(ascii.decode(base64.decode(base64.normalize(jwt![1]))));
      if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
          .isAfter(DateTime.now())) {
        _user = await SharedPreferencesHelper.getAccountFromLocal();
        _userType = UserTypeHelper.getEnum((pref.getString('userType'))!);
        update();
        isLogged.value = true;
      } else {
        isLogged.value = false;
      }
    }
  }

  login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> accountInput = {"email": email, "password": password};

    var rs = await HttpHelper.post(LOGIN_ENDPOINT, accountInput);

    if (rs.statusCode == 200) {
      var jsonObject = jsonDecode(rs.body);
      print(jsonObject);
      var account = User.fromJson(jsonObject);
      _user = account;
      pref.setString("jwt", account.jwt!);
      SharedPreferencesHelper.saveAccountToLocal(account);

      var payload = JwtDecoder.decode((user?.jwt)!);
      if (payload["isAdmin"]) {
        pref.setString('userType', "Admin");
      } else {
        pref.setString('userType', "Customer");
      }

      isLogged.value = true;
      update();
    }
  }

  Future logOut() async {
    User _user = new User();
    isLogged.value = false;
    update();
    return await SharedPreferencesHelper.deleteAccountFromLocal();
  }

  Future<User?> getCurrentLogin() async {
    var rs = await SharedPreferencesHelper.getAccountFromLocal();

    _user = rs!;
    update();
    return _user;
  }
}