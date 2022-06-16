import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:hedorashop/helpers/http_helper.dart';
import 'package:hedorashop/pages/home_page.dart';
import 'package:hedorashop/pages/widgets/custom_button.dart';
import 'package:hedorashop/pages/widgets/custom_text.dart';
import 'package:hedorashop/pages/widgets/custom_text_field.dart';
import 'package:hedorashop/themes/constant.dart';
import 'package:hedorashop/viewmodels/cart_viewmodel.dart';
import 'package:hedorashop/viewmodels/checkout_viewmodel.dart';
import 'package:hedorashop/viewmodels/home_viewmodel.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 130.h,
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: 'Checkout',
                    fontSize: 20,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 24.h),
                child: Form(
                  key: _formKey,
                  child: GetBuilder<CheckoutViewModel>(
                    init: Get.find<CheckoutViewModel>(),
                    builder: (controller) => Column(
                      children: [
                        ListViewProducts(),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          title: 'Street',
                          hintText: '21, Alamara Street',
                          validatorFn: (value) {
                            if (value!.isEmpty || value.length < 4)
                              return 'Please enter valid street name.';
                          },
                          onSavedFn: (value) {
                            controller.street = value;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          title: 'City',
                          hintText: 'Jablah',
                          validatorFn: (value) {
                            if (value!.isEmpty || value.length < 4)
                              return 'Please enter valid city name.';
                          },
                          onSavedFn: (value) {
                            controller.city = value;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                title: 'State',
                                hintText: 'Lattakia',
                                validatorFn: (value) {
                                  if (value!.isEmpty || value.length < 4)
                                    return 'Please enter valid state name.';
                                },
                                onSavedFn: (value) {
                                  controller.state = value;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 36.w,
                            ),
                            Expanded(
                              child: CustomTextFormField(
                                title: 'Country',
                                hintText: 'Syria',
                                validatorFn: (value) {
                                  if (value!.isEmpty || value.length < 4)
                                    return 'Please enter valid city name.';
                                },
                                onSavedFn: (value) {
                                  controller.country = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomTextFormField(
                          title: 'Phone Number',
                          hintText: '+9639........',
                          keyboardType: TextInputType.phone,
                          validatorFn: (value) {
                            if (value!.isEmpty || value.length < 10)
                              return 'Please enter valid number.';
                          },
                          onSavedFn: (value) {
                            controller.phone = value;
                          },
                        ),
                        SizedBox(
                          height: 38.h,
                        ),
                        CustomButton(
                          'SUBMIT',
                          () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              print("object");
                              // final url = Uri.parse(
                              //     "http://localhost:3000/api/v1/payment?amount=7000&currency=inr");
                              // final response = await http.get(url);
                              final response = await HttpHelper.get(
                                  "https://hedorashop.herokuapp.com/api/v1/payment?amount=7000&currency=inr");
                              print(response.body);
                              var jsonBody = jsonDecode(response.body);
                              Map<String, dynamic>? paymentIntentData;
                              paymentIntentData = jsonBody;
                              if (paymentIntentData!["paymentIntent"] != "" &&
                                  paymentIntentData["paymentIntent"] != null) {
                                String _intent =
                                    paymentIntentData["paymentIntent"];
                                await Stripe.instance.initPaymentSheet(
                                  paymentSheetParameters:
                                      SetupPaymentSheetParameters(
                                    paymentIntentClientSecret: _intent,
                                    applePay: false,
                                    googlePay: false,
                                    merchantCountryCode: "US",
                                    merchantDisplayName: "HedoraShop",
                                    testEnv: false,
                                    customerId: paymentIntentData['customer'],
                                    customerEphemeralKeySecret:
                                        paymentIntentData['ephemeralKey'],
                                  ),
                                );

                                await Stripe.instance.presentPaymentSheet();
                              }
                              await controller.addCheckoutToFireStore();
                              Get.dialog(
                                AlertDialog(
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: PRIMARY_COLOR,
                                          size: 200.h,
                                        ),
                                        CustomText(
                                          text: 'Order Submitted',
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: PRIMARY_COLOR,
                                          alignment: Alignment.center,
                                        ),
                                        SizedBox(
                                          height: 40.h,
                                        ),
                                        CustomButton(
                                          'Done',
                                          () {
                                            Get.to(HomePage());
                                            Get.find<HomeViewModel>()
                                                .changeToNormal();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                barrierDismissible: false,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      builder: (controller) => Column(
        children: [
          Container(
            height: 160.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.cartProductModel.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 120.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: Colors.white,
                        ),
                        height: 120.h,
                        width: 120.w,
                        child: Image.network(
                          controller.cartProductModel[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      CustomText(
                        text: controller.cartProductModel[index].name,
                        fontSize: 14,
                        maxLines: 1,
                      ),
                      CustomText(
                        text:
                            '\$${controller.cartProductModel[index].price} x ${controller.cartProductModel[index].quantity}',
                        fontSize: 14,
                        color: PRIMARY_COLOR,
                      ),
                    ],
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
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: 'TOTAL: ',
                fontSize: 14,
                color: Colors.grey,
              ),
              CustomText(
                text: '\$${controller.totalPrice.toString()}',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: PRIMARY_COLOR,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
