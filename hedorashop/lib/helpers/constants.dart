import 'dart:convert';

import 'dart:math';

import 'package:intl/intl.dart';

String createCryptoRandomString([int length = 32]) {
  final Random _random = Random.secure();
  var values = List<int>.generate(length, (i) => _random.nextInt(256));

  return base64Url.encode(values);
}

String numberToMoneyString(int price, {String unit = 'đ'}) {
  return NumberFormat("#,###", "vi_VN").format(price) + unit;
}

final String tableCartProduct = 'cartProduct';
final String columnName = 'name';
final String columnProductId = 'productId';
final String columnImage = 'image';
final String columnQuantity = 'quantity';
final String columnPrice = 'price';
