// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedorashop/pages/checkout/order_history_view.dart';
import 'package:hedorashop/pages/widgets/custom_text.dart';
import 'package:hedorashop/viewmodels/auth_viewmodel.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      init: AuthViewModel(),
      builder: (controller) {
        if (controller.loading.value) {
          return CircularProgressIndicator();
        } else {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 50, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/profile.png')),
                          ),
                        ),
                        Column(
                          children: [
                            CustomText(
                              text: controller.user!.username!,
                              color: Colors.black,
                              fontSize: 24,
                            ),
                            CustomText(
                              text: controller.user!.email!,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        // Get.to(EditProfileView());
                      },
                      child: ListTile(
                        title: CustomText(
                          text: 'Edit Profile',
                        ),
                        leading: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        trailing: Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        // Get.to(NotificationsView());
                      },
                      child: ListTile(
                        title: CustomText(
                          text: 'Notifications',
                        ),
                        leading: Icon(
                          Icons.location_pin,
                          color: Colors.black,
                        ),
                        trailing: Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        Get.to(OrderHistoryView());
                      },
                      child: ListTile(
                        title: CustomText(
                          text: 'Order History',
                        ),
                        leading: Icon(
                          Icons.history,
                          color: Colors.black,
                        ),
                        trailing: Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        // Get.to(CardsView());
                      },
                      child: ListTile(
                        title: CustomText(
                          text: 'Cards',
                        ),
                        leading: Icon(
                          Icons.card_travel,
                          color: Colors.black,
                        ),
                        trailing: Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        Get.find<AuthViewModel>().logOut();
                      },
                      child: ListTile(
                        title: CustomText(
                          text: 'log out',
                        ),
                        leading: Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
