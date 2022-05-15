// ignore_for_file: avoid_print

import 'package:food_delivery_laravel/data/repository/cart_repo.dart';
import 'package:food_delivery_laravel/models/cart_model.dart';
import 'package:food_delivery_laravel/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  CartController({required this.cartRepo});
  final CartRepo cartRepo;

  final Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(ProductModel productModel, int quantity) {
    // print('length of items in cart is ' + _items.length.toString());
    var totalQuantity = 0;
    if (_items.containsKey(productModel.id!)) {
      _items.update(productModel.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now(),
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(productModel.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
          productModel.id!,
          () {
            print("adding item to cart" +
                productModel.id.toString() +
                "quantity" +
                quantity.toString());
            return CartModel(
              id: productModel.id,
              name: productModel.name,
              price: productModel.price,
              img: productModel.img,
              quantity: quantity,
              isExist: true,
              time: DateTime.now(),
            );
          },
        );
      } else {
        Get.snackbar('Error', 'You should at least 1 item in cart');
      }
    }
  }

  bool existInCart(ProductModel productModel) {
    if (_items.containsKey(productModel.id!)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel productModel) {
    var quantity = 0;
    if (_items.containsKey(productModel.id)) {
      _items.forEach((key, value) {
        if (key == productModel.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getCartItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }
}
