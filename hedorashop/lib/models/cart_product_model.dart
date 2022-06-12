class CartProductModel {
  late String name, image, price, productId;
  late int quantity;
  CartProductModel(
      {required this.name,
      required this.productId,
      required this.image,
      this.quantity = 1,
      required this.price});

  CartProductModel.fromJson(dynamic map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    productId = map['productId'];
    image = map['image'];
    quantity = map['quantity'];
    price = map['price'];
  }

  toJson() {
    return {
      'name': name,
      'productId': productId,
      'image': image,
      'quantity': quantity,
      'price': price,
    };
  }
}
