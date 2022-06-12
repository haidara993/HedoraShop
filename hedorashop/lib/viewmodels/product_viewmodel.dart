import 'dart:convert';

import 'package:get/get.dart';
import 'package:hedorashop/helpers/http_helper.dart';
import 'package:hedorashop/models/product_model.dart';

class ProductViewModel extends GetxController {
  List<ProductModel>? _products;
  List<ProductModel>? get products => _products;

  ProductModel? _productModel;
  ProductModel? get productModel => _productModel;
}
