// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hedorashop/helpers/http_helper.dart';
// import 'package:hedorashop/helpers/shared_preferences_helper.dart';
// import 'package:hedorashop/models/favorite_model.dart';
// import 'package:hedorashop/viewmodels/auth_viewmodel.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class FavoriteService {
//   Future<FavoriteModel?> get(int id) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var token = pref.getString("jwt");
//     // TODO: implement get
//     var rs =
//         await HttpHelper.get(FAVORITE_ENDPOINT + '/$id', bearerToken: token);
//     if (rs.statusCode == 200 || rs.statusCode == 201) {
//       var jsonObject = jsonDecode(rs.body);
//       var favorite = FavoriteModel.fromJson(jsonObject);
//       _updateCurrentAccountFavorite(favorite);
//       return favorite;
//     }
//     return null;
//   }

//   @override
//   Future<List<FavoriteModel>?> getAll({int from = 0, int? limit}) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var token = pref.getString("jwt");

//     // TODO: implement getAll
//     var rs = await HttpHelper.get(FAVORITE_ENDPOINT, bearerToken: token);
//     if (rs.statusCode == 200 || rs.statusCode == 201) {
//       var jsonArray = jsonDecode(rs.body) as List;
//       var favorites =
//           jsonArray.map((json) => FavoriteModel.fromJson(json)).toList();
//       await _updateCurrentAccountFavorites(favorites);
//       return favorites;
//     }
//     return null;
//   }

//   Future _updateCurrentAccountFavorites(List<FavoriteModel> favorites) async {
//     Get.find<AuthViewModel>().user?.favorite = favorites;
//     await SharedPreferencesHelper.saveAccountToLocal(
//         Get.find<AuthViewModel>().user!);
//   }

//   Future _updateCurrentAccountFavorite(FavoriteModel favorite) async {
//     var currentFavorite = Get.find<AuthViewModel>().user?.favorite?.firstWhere(
//         (favoriteTemp) => favoriteTemp.id == favorite.id,
//         orElse: () => new FavoriteModel());
//     if (currentFavorite != null) {
//       Get.find<AuthViewModel>().user?.favorite?.remove(currentFavorite);
//     }
//     Get.find<AuthViewModel>().user?.favorite?.add(favorite);
//     await SharedPreferencesHelper.saveAccountToLocal(
//         Get.find<AuthViewModel>().user!);
//   }

//   Future<FavoriteModel?> doFavorite({@required String? productID}) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var token = pref.getString("jwt");

//     var rs = await HttpHelper.post(FAVORITE_ENDPOINT, {'productID': productID},
//         bearerToken: token);
//     if (rs.statusCode == 200 || rs.statusCode == 201) {
//       //  print(rs.body);
//       var jsonObject = jsonDecode(rs.body);
//       var favorite = FavoriteModel.fromJson(jsonObject);
//       await _updateCurrentAccountFavorite(favorite);
//       return favorite;
//     }
//     return null;
//   }

//   FavoriteModel? getFavoriteFromLocalByProductId(String productID) {
//     // print(currentLogin.account.favorite.map((e) => e.productId).toList());
//     if (Get.find<AuthViewModel>().user == null) {
//       return new FavoriteModel();
//     }
//     return Get.find<AuthViewModel>().user?.favorite?.firstWhere(
//         (favorite) => favorite.productId == productID,
//         orElse: () => new FavoriteModel());
//   }
// }
