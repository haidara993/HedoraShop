class DeliveryAddressModel {
  int? id;
  String? username;
  String? phoneNumber;
  String? fullname;
  String? address;
  String? latitude;
  String? longitude;

  DeliveryAddressModel(
      {this.id,
      this.username,
      this.phoneNumber,
      this.fullname,
      this.address,
      this.latitude,
      this.longitude});

  DeliveryAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    phoneNumber = json['phoneNumber'];
    fullname = json['fullname'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['phoneNumber'] = this.phoneNumber;
    data['fullname'] = this.fullname;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
