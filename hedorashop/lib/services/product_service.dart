import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:hedorashop/helpers/http_helper.dart';
import 'package:hedorashop/models/favorite_model.dart';
import 'package:hedorashop/models/product_model.dart';
import 'package:hedorashop/services/favorite_service.dart';
import 'package:hedorashop/viewmodels/auth_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductServices {
  Future<ProductModel?> get(int id) async {
    // TODO: implement get
    var rs = await HttpHelper.get(PRODUCT_ENDPOINT + "/$id");
    if (rs.statusCode == 200) {
      var json = jsonDecode(rs.body);
      // print(jsonList.toList());
      var product = ProductModel.fromJson(json);
      // product = _checkIsFavoriteByCurrentUser(product);
      return product;
    }
    return null;
  }

  // ProductModel _checkIsFavoriteByCurrentUser(ProductModel product) {
  //   var favorite =
  //       FavoriteService().getFavoriteFromLocalByProductId(product.id!);
  //   if (favorite?.id != null) {
  //     product.isFavoriteByCurrentUser = favorite?.isfavorite;
  //   } else {
  //     product.isFavoriteByCurrentUser = false;
  //   }
  //   return product;
  // }

  String getQueryString(Map<String, dynamic> condition) {
    String result = '';
    for (var key in condition.keys) {
      String value =
          condition[key] == null ? '' : '${condition[key].toString()}';
      result += '&$key=$value';
    }
    //remove first &
    result = result.replaceFirst('&', '');
    return result;
  }

  Future<List<ProductModel>?> getAll({int from = 0, int? limit}) async {
    // TODO: implement getAll
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("jwt");
    var rs = await HttpHelper.get(
        PRODUCT_ENDPOINT + '?${getQueryString({'from': from, 'limit': limit})}',
        bearerToken: token);
    // print(rs.statusCode);
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;

      var products = jsonList.map((j) => ProductModel.fromJson(j)).toList();
      // for (var product in products) {
      //   product = _checkIsFavoriteByCurrentUser(product);
      // }
      return products;
    }
    return null;
  }

  ProductModel _checkIsFavoriteByFavoriteModel(
      {required ProductModel productModel,
      required FavoriteModel favoriteModel}) {
    if (favoriteModel != null) {
      productModel.isFavoriteByCurrentUser = favoriteModel.isfavorite;
    }
    return productModel;
  }

  // Future<ProductModel> doFavorite(ProductModel productModel) async {
  //   var favorite =
  //       await FavoriteService().doFavorite(productID: productModel.id);
  //   var rs = _checkIsFavoriteByFavoriteModel(
  //       productModel: productModel, favoriteModel: favorite!);
  //   return rs;
  // }

  Future<List<ProductModel>?> getAllWithCategoryId(int categoryID,
      {int from = 0, int? limit}) async {
    // TODO: implement getAll
    var rs = await HttpHelper.get(PRODUCT_ENDPOINT +
        "?categoryID=$categoryID" +
        '&${getQueryString({'from': from, 'limit': limit})}');
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      // print(jsonList.toList());
      var products = jsonList.map((j) => ProductModel.fromJson(j)).toList();
      // for (var product in products) {
      //   product = _checkIsFavoriteByCurrentUser(product);
      // }
      return products;
    }
    return null;
  }

  Future<List<ProductModel>?> getProductsForYou() async {
    if (Get.find<AuthViewModel>().user != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString("jwt");
      var rs = await HttpHelper.get(PRODUCT_ENDPOINT + "/forYou",
          bearerToken: token);
      if (rs.statusCode == 200) {
        var jsonList = jsonDecode(rs.body) as List;
        var products = jsonList.map((j) => ProductModel.fromJson(j)).toList();
        // for (var product in products) {
        //   product = _checkIsFavoriteByCurrentUser(product);
        // }
        return products;
      }
      return null;
    }
    return getAll(limit: 10, from: Random().nextInt(10));
  }

  Future<List<ProductModel>?> searchProduct(String keyword,
      {int? limit, int from = 0}) async {
    if (Get.find<AuthViewModel>().user != null) {
      var rs = await HttpHelper.post(
          PRODUCT_ENDPOINT +
              "/search?${getQueryString({
                    'keyword': keyword,
                    'from': from,
                    'limit': limit
                  })}",
          {},
          bearerToken: Get.find<AuthViewModel>().user?.jwt);
      if (rs.statusCode == 200) {
        var jsonList = jsonDecode(rs.body) as List;
        var products = jsonList.map((j) => ProductModel.fromJson(j)).toList();
        // for (var product in products) {
        //   product = _checkIsFavoriteByCurrentUser(product);
        // }
        return products;
      }
      return null;
    }
    return getAll(limit: 10, from: Random().nextInt(10));
  }
}
