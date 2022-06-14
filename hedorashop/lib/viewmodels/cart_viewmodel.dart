import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedorashop/models/cart_product_model.dart';
import 'package:hedorashop/models/ordering_model.dart';
import 'package:hedorashop/services/database/cart_database_helper.dart';

class CartViewModel extends GetxController {
  static CartViewModel instance = Get.find();
  ValueNotifier<bool> get loading => _loading;

  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<CartProductModel> _cartProductModel = [];
  List<CartProductModel> get cartProductModel => _cartProductModel;
  var dbHelper = CartDatabaseHelper.db;
  RxInt cartnum = 0.obs;

  // double get totalPrice => _totalPrice;
  RxDouble totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getAllProducts();
    // ever(getAllProducts(), getTotalPrice());
  }

  getAllProducts() async {
    _loading.value = true;
    _cartProductModel = await dbHelper.getAllProduct();
    cartnum.value = _cartProductModel.length;
    getTotalPrice();
    _loading.value = false;
    update();
  }

  Future<bool> addProduct(CartProductModel cartProductModel) async {
    for (var i = 0; i < _cartProductModel.length; i++) {
      if (_cartProductModel[i].productId == cartProductModel.productId) {
        Get.snackbar(
            "Check your cart", "${cartProductModel.name} is already added");
        return false;
      }
    }

    await dbHelper.insert(cartProductModel);
    _cartProductModel.add(cartProductModel);

    Get.snackbar(
        "Item added", "${cartProductModel.name} was added to your cart");
    getAllProducts();

    update();
    return true;
  }

  removeProduct(String productId) async {
    await dbHelper.deleteProduct(productId);
    getAllProducts();
  }

  removeAllProducts() async {
    await dbHelper.deleteAllProducts();
    getAllProducts();
    totalPrice.value = 0;
  }

  getTotalPrice() {
    totalPrice.value = 0.0;
    for (var i = 0; i < _cartProductModel.length; i++) {
      totalPrice.value += (double.parse(_cartProductModel[i].price) *
          _cartProductModel[i].quantity);
    }
  }

  increaseQuantity(int index) async {
    _cartProductModel[index].quantity++;
    totalPrice.value += (double.parse(_cartProductModel[index].price));
    await dbHelper.updateProduct(_cartProductModel[index]);
    update();
  }

  decreaseQuantity(int index) async {
    if (_cartProductModel[index].quantity > 1) {
      _cartProductModel[index].quantity--;
      totalPrice.value -= (double.parse(_cartProductModel[index].price));
      await dbHelper.updateProduct(_cartProductModel[index]);
      update();
    }
  }
}
