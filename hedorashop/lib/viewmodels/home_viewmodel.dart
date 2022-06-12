import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedorashop/enums/storeState.dart';
import 'package:hedorashop/models/category_model.dart';
import 'package:hedorashop/models/product_model.dart';
import 'package:hedorashop/services/category_service.dart';
import 'package:hedorashop/services/product_service.dart';

class HomeViewModel extends GetxController with SingleGetTickerProviderMixin {
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<CategoryModel> _categoryModel = [];
  List<CategoryModel> get categoryModel => _categoryModel;

  List<ProductModel> _productModel = [];
  List<ProductModel> get productModel => _productModel;

  StoreState _storeState = StoreState.normal;
  StoreState get storeState => _storeState;
  // late Animation animation;
  late AnimationController _animationController;

  @override
  void onInit() {
    super.onInit();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2500,
      ),
    );
  }

  HomeViewModel() {
    getCategory();
    getBsetSelling();
  }

  void changeToCart() {
    _storeState = StoreState.cart;
    update();
  }

  void changeToDetails() {
    _storeState = StoreState.details;
    update();
  }

  void changeToNormal() {
    _storeState = StoreState.normal;
    update();
  }

  doFavoritebyIndex(int index) async {
    if (_productModel[index].isFavoriteByCurrentUser!) {
      _productModel[index].isFavoriteByCurrentUser = false;
      Get.snackbar(
          "Favorites", "${_productModel[index].name} is added to favorites");
    } else {
      _productModel[index].isFavoriteByCurrentUser = true;
      Get.snackbar("Favorites",
          "${_productModel[index].name} is removed from favorites");
    }

    update();
    // await ProductServices().doFavorite(_productModel[index]);
  }

  doFavoritebymodel(ProductModel product) async {
    if (product.isFavoriteByCurrentUser!) {
      product.isFavoriteByCurrentUser = false;
      Get.snackbar("Favorites", "${product.name} is added to favorites");
    } else {
      product.isFavoriteByCurrentUser = true;
      Get.snackbar("Favorites", "${product.name} is removed from favorites");
    }

    update();
    // await ProductServices().doFavorite(product);
  }

  getCategory() async {
    _loading.value = true;
    await CategoryService().getAll().then((value) {
      if (value == null) {
        _categoryModel = [];
      } else {
        _categoryModel = value;
      }
      _loading.value = false;
      update();
    });
  }

  getBsetSelling() async {
    _loading.value = true;
    await ProductServices().getAll().then((value) {
      if (value == null) {
        _productModel = [];
      } else {
        _productModel = value;
      }
      _loading.value = false;
      update();
    });
  }
}
