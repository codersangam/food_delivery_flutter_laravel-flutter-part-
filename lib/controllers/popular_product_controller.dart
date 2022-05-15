import 'package:food_delivery_laravel/controllers/cart_controller.dart';
import 'package:food_delivery_laravel/data/repository/popular_product_repo.dart';
import 'package:food_delivery_laravel/models/cart_model.dart';
import 'package:food_delivery_laravel/models/product_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  PopularProductController({required this.popularProductRepo});
  final PopularProductRepo popularProductRepo;

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoading = true;
      update();
    } else {
      printError();
    }
  }

// For Quantity

  int _quantity = 0;
  int get quantity => _quantity;
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(quantity) {
    if ((_cartItems + quantity) < 0) {
      Get.snackbar('Error', 'Minimum quantity is 1');
      if (_cartItems > 0) {
        _quantity = -_cartItems;
        return _quantity;
      }
      return 0;
    } else if ((_cartItems + quantity) > 10) {
      Get.snackbar('Error', 'Maximum quantity is 10');
      return 10;
    } else {
      return quantity;
    }
  }

  // For Cart Items
  int _cartItems = 0;
  int get cartItems => _cartItems + _quantity;

  late CartController _cartController;

  void initProduct(ProductModel productModel, CartController cartController) {
    _quantity = 0;
    _cartItems = 0;
    _cartController = cartController;
    var exist = false;
    exist = _cartController.existInCart(productModel);
    // ignore: avoid_print
    print("Exist or not: " + exist.toString());
    if (exist) {
      _cartItems = _cartController.getQuantity(productModel);
    }
    // ignore: avoid_print
    print('The quantity in cart is ' + _cartItems.toString());
  }

  void addItem(ProductModel productModel) {
    // if (_quantity > 0) {
    _cartController.addItem(productModel, _quantity);

    _quantity = 0;
    _cartItems = _cartController.getQuantity(productModel);

    _cartController.items.forEach((key, value) {
      // ignore: avoid_print
      print("The id is " +
          value.id.toString() +
          " The quantity is " +
          value.quantity.toString());
    });
    update();
    // } else {
    //   Get.snackbar('Error', 'You should at least 1 item in cart');
    // }
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModel> get getItems {
    return _cartController.getCartItems;
  }
}
