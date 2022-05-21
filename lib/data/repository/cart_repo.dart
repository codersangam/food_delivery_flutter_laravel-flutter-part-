import 'dart:convert';
import 'package:food_delivery_laravel/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_model.dart';

class CartRepo {
  CartRepo({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  List<String> cart = [];
  addToCartList(List<CartModel> cartList) {
    cart = [];

    // Converting List<CartModel> (Object) to String because SharedPreferences only accepts String

    // ignore: avoid_function_literals_in_foreach_calls
    cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });

    // In Short
    // ignore: avoid_function_literals_in_foreach_calls
    cartList.forEach((element) => cart.add(jsonEncode(element)));

    sharedPreferences.setStringList(Constants.cartList, cart);
    // print(sharedPreferences.getStringList("cart-list"));

    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(Constants.cartList)) {
      carts = sharedPreferences.getStringList(Constants.cartList)!;
      // ignore: avoid_print
      print("Inside Cart List" + carts.toString());
    }
    List<CartModel> cartList = [];

    // ignore: avoid_function_literals_in_foreach_calls
    // carts.forEach((element) {
    //   cartList.add(CartModel.fromJson(jsonDecode(element)));
    // });

    // Short
    // ignore: avoid_function_literals_in_foreach_calls
    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }
}
