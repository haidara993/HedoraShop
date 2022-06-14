import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const DOMAIN = 'http://localhost:3000/api/v1/';
const LOGIN_ENDPOINT = DOMAIN + 'users/login';
const CATEGORY_ENDPOINT = DOMAIN + 'categories';
const PRODUCT_ENDPOINT = DOMAIN + 'products';
const FAVORITE_ENDPOINT = DOMAIN + 'favorites';
const CHECKOUT_ENDPOINT = DOMAIN + 'checkout';
const SHOP_ACCOUNT_ENDPOINT = DOMAIN + 'shopaccounts';

class HttpHelper {
  static Future<http.Response> post(String url, Map<String, dynamic> body,
      {String? bearerToken}) async {
    return (await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $bearerToken'
    }));
  }

  static Future<http.Response> put(String url, Map<String, dynamic> body,
      {String? bearerToken}) async {
    return (await http.put(Uri.parse(url), body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $bearerToken'
    }));
  }

  static Future<http.Response> get(String url, {String? bearerToken}) async {
    return await http.get(Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $bearerToken'});
  }
}
