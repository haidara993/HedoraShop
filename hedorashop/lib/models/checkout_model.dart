class CheckoutModel {
  late String street, city, state, country, phone, totalPrice, date;
  late String userId;

  CheckoutModel(
      {required this.street,
      required this.city,
      required this.state,
      required this.country,
      required this.phone,
      required this.totalPrice,
      required this.date,
      required this.userId});

  CheckoutModel.fromJson(dynamic map) {
    street = map['street'];
    city = map['city'];
    state = map['state'];
    country = map['country'];
    phone = map['phone'];
    totalPrice = map['totalPrice'];
    date = map['date'];
    userId = map['userId'];
  }

  toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'phone': phone,
      'totalPrice': totalPrice,
      'date': date,
      'userId': userId,
    };
  }
}
