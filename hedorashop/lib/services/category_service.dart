import 'dart:convert';

import 'package:hedorashop/helpers/http_helper.dart';
import 'package:hedorashop/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  Future<CategoryModel?> get(int id) async {
    // TODO: implement get
    var rs = await HttpHelper.get(CATEGORY_ENDPOINT + "/$id");
    if (rs.statusCode == 200) {
      var json = jsonDecode(rs.body);
      // print(jsonList.toList());
      return CategoryModel.fromJson(json);
    }
    return null;
  }

  Future<List<CategoryModel>?> getAll({int from = 0, int? limit}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("jwt");
    // TODO: implement getAll
    var rs = await HttpHelper.get(CATEGORY_ENDPOINT, bearerToken: token);
    if (rs.statusCode == 200) {
      var jsonList = jsonDecode(rs.body) as List;
      // print(jsonList.toList());
      return jsonList.map((j) => CategoryModel.fromJson(j)).toList();
    }
    return null;
  }
}
