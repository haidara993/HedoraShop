import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hedorashop/enums/storeState.dart';
import 'package:hedorashop/models/cart_product_model.dart';
import 'package:hedorashop/pages/cart/cart_page.dart';
import 'package:hedorashop/pages/category_products_view.dart';
import 'package:hedorashop/pages/detailScreen.dart';
import 'package:hedorashop/pages/profile_view.dart';
import 'package:hedorashop/pages/search_view.dart';
import 'package:hedorashop/pages/widgets/custom_text.dart';
import 'package:hedorashop/themes/constant.dart';
import 'package:hedorashop/viewmodels/auth_viewmodel.dart';
import 'package:hedorashop/viewmodels/cart_viewmodel.dart';
import 'package:hedorashop/viewmodels/home_viewmodel.dart';

class HomePage extends GetWidget<HomeViewModel> {
  final _cartBarHeight = 100.0;
  final panelTransation = Duration(milliseconds: 500);

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -7) {
      controller.changeToCart();
    } else if (details.primaryDelta! > 7) {
      controller.changeToNormal();
    }
  }

  double? _getTopForWhitePanel(StoreState state, Size size) {
    if (state == StoreState.normal) {
      return 0;
    } else if (state == StoreState.cart) {
      return -(size.height - (_cartBarHeight * 2));
    }
  }

  double? _getTopForBlackPanel(StoreState state, Size size) {
    if (state == StoreState.normal) {
      return size.height - _cartBarHeight;
    } else if (state == StoreState.cart) {
      return _cartBarHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
        animation: HomeViewModel(),
        builder: (context, _) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: GetBuilder<HomeViewModel>(
              init: HomeViewModel(),
              builder: (controller) => controller.loading.value
                  ? Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                duration: panelTransation,
                                curve: Curves.decelerate,
                                top: _getTopForWhitePanel(
                                    controller.storeState, size),
                                right: 0,
                                left: 0,
                                height: size.height - _cartBarHeight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: SingleChildScrollView(
                                      padding: EdgeInsets.only(
                                        top: 25.h,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .padding
                                                  .top,
                                              left: 25,
                                              right: 25,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    RichText(
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                          text:
                                                              'Howdy, What Are You\nLooking For? ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextSpan(
                                                            text: '👀',
                                                            style: TextStyle(
                                                                fontSize: 22)),
                                                      ]),
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  child: CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          'assets/images/profile.png'),
                                                      radius: 25),
                                                  onTap: () async {
                                                    Get.to(ProfileView());
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(20),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      child: TextFormField(
                                                        cursorColor:
                                                            Colors.grey,
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor:
                                                              Colors.white,
                                                          filled: true,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          hintText:
                                                              'Search for a product',
                                                          hintStyle:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 18,
                                                          ),
                                                          prefixIcon: Container(
                                                            child: Icon(
                                                              Icons
                                                                  .search_outlined,
                                                            ),
                                                          ),
                                                        ),
                                                        onFieldSubmitted:
                                                            (value) {
                                                          Get.to(SearchView(
                                                              value));
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: CustomText(
                                              text: 'Categories',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          _listCategoris(),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  text: 'Best Selling',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(CategoryProductsView(
                                                      categoryName:
                                                          'Best Selling',
                                                      products: controller
                                                          .productModel,
                                                    ));
                                                  },
                                                  child: CustomText(
                                                    text: 'See all',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          _listProducts(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                duration: panelTransation,
                                curve: Curves.decelerate,
                                top: _getTopForBlackPanel(
                                    controller.storeState, size),
                                right: 0,
                                left: 0,
                                height: size.height - 100,
                                child: GestureDetector(
                                  onVerticalDragUpdate: _onVerticalGesture,
                                  child: Container(
                                    color: Colors.black,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: AnimatedSwitcher(
                                            duration: panelTransation,
                                            child:
                                                controller.storeState ==
                                                        StoreState.normal
                                                    ? Row(
                                                        children: [
                                                          // ignore: prefer_const_constructors
                                                          Text(
                                                            'Cart',
                                                            // ignore: prefer_const_constructors
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          GetBuilder<
                                                              CartViewModel>(
                                                            builder:
                                                                (controller) =>
                                                                    Expanded(
                                                              child:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          5.0),
                                                                  child: Row(
                                                                    children: List
                                                                        .generate(
                                                                      controller
                                                                          .cartProductModel
                                                                          .length,
                                                                      (index) =>
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 3.0),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            Hero(
                                                                              tag: 'list_${controller.cartProductModel[index].name}details',
                                                                              child: CircleAvatar(
                                                                                backgroundImage: NetworkImage(
                                                                                  controller.cartProductModel[index].image,
                                                                                  scale: .25,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            // ignore: prefer_const_constructors
                                                                            Positioned(
                                                                              right: 0,
                                                                              child: CircleAvatar(
                                                                                radius: 10,
                                                                                backgroundColor: PRIMARY_COLOR,
                                                                                child: Text(
                                                                                  controller.cartProductModel[index].quantity.toString(),
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.find<
                                                                      HomeViewModel>()
                                                                  .changeToCart();
                                                            },
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color: Colors.grey.withOpacity(
                                                                                0.3),
                                                                            spreadRadius:
                                                                                0.1,
                                                                            blurRadius:
                                                                                0.1,
                                                                            offset:
                                                                                Offset(0, 1))
                                                                      ]),
                                                                  child: Icon(
                                                                    Icons
                                                                        .shopping_cart_outlined,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  right: 5,
                                                                  top: 5,
                                                                  child:
                                                                      Container(
                                                                    width: 17,
                                                                    height: 17,
                                                                    decoration: BoxDecoration(
                                                                        color: Theme.of(context)
                                                                            .primaryColor,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left: 5,
                                                                      ),
                                                                      child: Obx(
                                                                          () =>
                                                                              Text(
                                                                                Get.find<CartViewModel>().cartnum.value.toString(),
                                                                              )),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    : const SizedBox.shrink(),
                                          ),
                                        ),
                                        Expanded(
                                          child: CartPage(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
            ),
          );
        });
  }

  Widget _listProducts() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 300.h,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          scrollDirection: Axis.horizontal,
          itemCount: controller.productModel.length,
          itemBuilder: (context, index) {
            return Container(
              width: 230,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, _) {
                        return FadeTransition(
                          opacity: animation,
                          child: DetailsView(
                            model: controller.productModel[index],
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 900),
                    ),
                  );
                },
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Hero(
                            tag:
                                'list_${controller.productModel[index].name}_details',
                            child: Image.network(
                              controller.productModel[index].image!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "\$${controller.productModel[index].price}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  controller.productModel[index].name!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    icon: controller.productModel[index]
                                            .isFavoriteByCurrentUser!
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : Icon(
                                            Icons.favorite_border,
                                            color: Colors.black,
                                          ),
                                    onPressed: () {
                                      controller.doFavoritebyIndex(index);
                                    }),
                                IconButton(
                                    icon: Icon(Icons.add_shopping_cart),
                                    onPressed: () {
                                      Get.find<CartViewModel>().addProduct(
                                          CartProductModel(
                                              name:
                                                  controller.productModel[index]
                                                      .name!,
                                              productId: controller
                                                  .productModel[index].id!,
                                              image: controller
                                                  .productModel[index].image!,
                                              price: controller
                                                  .productModel[index].price
                                                  .toString()));
                                    }),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 15.w,
            );
          },
        ),
      ),
    );
  }

  Widget _listCategoris() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        height: 50.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categoryModel.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(CategoryProductsView(
                  categoryName: controller.categoryModel[index].name!,
                  products: controller.productModel
                      .where((product) =>
                          product.category ==
                          controller.categoryModel[index].id)
                      .toList(),
                ));
              },
              child: Container(
                margin: EdgeInsets.only(top: 10, right: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  controller.categoryModel[index].name!,
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
