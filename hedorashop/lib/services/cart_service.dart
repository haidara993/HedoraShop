// import 'dart:convert';

// import 'package:hedorashop/helpers/http_helper.dart';
// import 'package:hedorashop/models/ordering_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CartService {
//   Future<OrderingModel> get(int id) {
//     // TODO: implement get
//     throw UnimplementedError();
//   }

//   Future<List<OrderingModel>> getAll({int from = 0, int? limit}) {
//     // TODO: implement getAll
//     throw UnimplementedError();
//   }

//   Future<List<OrderingModel>?> getCurrentCart() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var token = pref.getString("jwt");

//     var rs = await HttpHelper.get(CART_ENDPOINT, bearerToken: token);
//     if (rs.statusCode == 200) {
//       var jsonArray = jsonDecode(rs.body) as List;
//       return jsonArray.map((json) => OrderingModel.fromJson(json)).toList();
//     }
//     return null;
//   }

//   Future<OrderingModel?> addToCart(int productId, int count) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var token = pref.getString("jwt");

//     var rs = await HttpHelper.post(
//         ORDERING_ENDPOINT + "/cart", {"productID": productId, "count": count},
//         bearerToken: token);
//     if (rs.statusCode == 200) {
//       var json = jsonDecode(rs.body);
//       return OrderingModel.fromJson(json);
//     }
//     return null;
//   }
// }
