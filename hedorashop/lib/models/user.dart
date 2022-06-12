import 'package:hedorashop/models/delivery_address_model.dart';
import 'package:hedorashop/models/favorite_model.dart';

class User {
  String? id;
  String? username;
  String? email;
  String? phoneNumber;
  String? street;
  String? apartment;
  String? zip;
  String? city;
  String? country;
  String? jwt;

  User({
    this.id,
    this.email,
    this.username,
    this.phoneNumber,
    this.street,
    this.apartment,
    this.zip,
    this.city,
    this.country,
    this.jwt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    User user = new User();
    user.id = json["id"];
    user.username = json['name'];
    user.phoneNumber = json['phone'];
    user.email = json['email'];
    user.street = json['street'];
    user.apartment = json['apartment'];
    user.zip = json['zip'];
    user.city = json['city'];
    user.country = json['country'];
    user.jwt = json['jwt'];

    return user;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.username;
    data['phone'] = this.phoneNumber;
    data['email'] = this.email;
    data['street'] = this.street;
    data['apartment'] = this.apartment;
    data['zip'] = this.zip;
    data['city'] = this.city;
    data['country'] = this.country;

    return data;
  }
}

class AuthUserDetails {
  late String? accessToken;
  late int? expiresIn;
  late User? userDetails;

  AuthUserDetails._({this.accessToken, this.expiresIn, this.userDetails});

  factory AuthUserDetails.fromJson(Map<String, dynamic> json) {
    // print("<<<<<<<<<<< user deatils"+json["userDetails"]);
    // ignore: unnecessary_new
    return new AuthUserDetails._(
        accessToken: json["accessToken"],
        expiresIn: json["expires_in"],
        userDetails: User.fromJson(json["userDetails"]));
  }

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'expiresIn': expiresIn,
        'userDetails': userDetails
      };
}
