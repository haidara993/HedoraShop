// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hedorashop/pages/checkout/checkout_view.dart';
import 'package:hedorashop/pages/widgets/custom_text.dart';
import 'package:hedorashop/viewmodels/cart_viewmodel.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "Cart",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 74.h, right: 16.w, left: 16.w),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(controller.cartProductModel[index].productId
                            .toString()),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 33.w),
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            controller.removeProduct(
                                controller.cartProductModel[index].productId);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  controller.cartProductModel[index].image,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Wrap(
                              direction: Axis.vertical,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(left: 14),
                                    child: CustomText(
                                      text: controller
                                          .cartProductModel[index].name,
                                      color: Colors.white,
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.chevron_left),
                                        color: Colors.white,
                                        onPressed: () {
                                          controller.decreaseQuantity(index);
                                        }),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomText(
                                        text: controller
                                            .cartProductModel[index].quantity
                                            .toString(),
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.chevron_right),
                                        color: Colors.white,
                                        onPressed: () {
                                          controller.increaseQuantity(index);
                                        }),
                                  ],
                                )
                              ],
                            )),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: CustomText(
                                text: controller.cartProductModel[index].price,
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 16.h,
                    ),
                    itemCount: controller.cartProductModel.length,
                  ),
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  "Total:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  "\$${controller.totalPrice.value.toString()}",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Pay (\$${controller.totalPrice.value.toString()})",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              onPressed: () => Get.to(CheckoutView()),
            ),
          ),
        ],
      ),
    );
  }
}
