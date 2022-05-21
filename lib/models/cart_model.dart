import 'package:food_delivery_laravel/models/product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  DateTime? time;
  ProductModel? productModel;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.quantity,
      this.isExist,
      this.time,
      this.productModel});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    name = json['name'];
    price = int.parse(json['price']);
    img = json['img'];
    quantity = int.parse(json['quantity']);
    isExist = bool.fromEnvironment(json['isExist']);
    time = DateTime.parse(json['time']);
    productModel = ProductModel.fromJson(json['productModel']);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id.toString();
  //   data['name'] = name;
  //   data['price'] = price.toString();
  //   data['img'] = img;
  //   data['quantity'] = quantity.toString();
  //   data['isExist'] = isExist.toString();
  //   data['time'] = time.toString();
  //   data['productModel'] = productModel!.toJson();
  //   return data;
  // }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "name": name,
      "price": price.toString(),
      "img": img,
      "quantity": quantity.toString(),
      "isExist": isExist.toString(),
      "time": time.toString(),
      "productModel": productModel!.toJson(),
    };
  }
}
