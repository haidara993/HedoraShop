// import 'dart:convert';

// import 'package:hedorashop/helpers/http_helper.dart';
// import 'package:hedorashop/models/ordering_model.dart';
// import 'package:hedorashop/services/product_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OrderingService {
//   Future<OrderingModel?> get(int id) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var token = pref.getString("jwt");
//     // TODO: implement get
//     var rs = await HttpHelper.get('$ORDERING_ENDPOINT/$id', bearerToken: token);
//     if (rs.statusCode == 200) {
//       var json = jsonDecode(rs.body);
//       return OrderingModel.fromJson(json);
//     }
//     return null;
//   }

//   Future<List<OrderingModel>?> getAll({int from = 0, int? limit}) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var token = pref.getString("jwt");
//     // TODO: implement getAll
//     var rs = await HttpHelper.get(ORDERING_ENDPOINT, bearerToken: token);
//     if (rs.statusCode == 200) {
//       var jsonArray = jsonDecode(rs.body) as List;
//       var orderings =
//           jsonArray.map((json) => OrderingModel.fromJson(json)).toList();
//       orderings = orderings.where((o) => o.status != 0).toList();
//       for (var order in orderings) {
//         var ods = order.orderingDetail;
//         for (var od in ods!) {
//           if (od.product == null) {
//             od.product = await ProductServices().get(od.productId!);
//           }
//         }
//       }
//       return orderings;
//     }
//     return null;
//   }

//   Future<OrderingModel?> cancelOrdering(int orderingId) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var token = pref.getString("jwt");

//     var rs = await HttpHelper.post(
//         ORDERING_ENDPOINT + "/cancel", {"orderingId": orderingId},
//         bearerToken: token);
//     if (rs.statusCode == 200) {
//       var json = jsonDecode(rs.body);
//       return OrderingModel.fromJson(json);
//     }
//     return null;
//   }
// }
