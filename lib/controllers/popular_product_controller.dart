import 'package:food_delivery_laravel/data/repository/popular_product_repo.dart';
import 'package:food_delivery_laravel/models/product_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  PopularProductController({required this.popularProductRepo});
  final PopularProductRepo popularProductRepo;

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      update();
    } else {
      printError();
    }
  }
}
