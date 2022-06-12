import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hedorashop/models/cart_product_model.dart';
import 'package:hedorashop/models/product_model.dart';
import 'package:hedorashop/pages/home_page.dart';
import 'package:hedorashop/pages/widgets/custom_button.dart';
import 'package:hedorashop/pages/widgets/custom_text.dart';
import 'package:hedorashop/themes/constant.dart';
import 'package:hedorashop/viewmodels/cart_viewmodel.dart';
import 'package:hedorashop/viewmodels/home_viewmodel.dart';

class DetailsView extends StatelessWidget {
  ProductModel model;
  DetailsView({required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: 'list_${model.name}_details',
                      child: Image.network(
                        model.image!,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.34,
                      ),
                    ),
                    Text(
                      model.name!,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "\$${model.price}",
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "About the product",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Text(
                      model.description!,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: GetBuilder<HomeViewModel>(
                      builder: (controller) => IconButton(
                        onPressed: () {
                          controller.doFavoritebymodel(model);
                        },
                        icon: model.isFavoriteByCurrentUser!
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: GetBuilder<CartViewModel>(
                      builder: (controller) => RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        onPressed: () {
                          controller.addProduct(
                            CartProductModel(
                              name: model.name!,
                              image: model.image!,
                              price: model.price.toString(),
                              productId: model.id!,
                            ),
                          );

                          Navigator.of(context).pop();
                        },
                        color: Colors.orange,
                        // ignore: prefer_const_constructors
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
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
  }
}
