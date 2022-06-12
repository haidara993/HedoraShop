import 'package:hedorashop/models/product_model.dart';

class CategoryModel {
  String? id;
  String? name;
  String? description;
  String? image;

  CategoryModel(
      {this.id, this.name, this.description, this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    
    return data;
  }
}
