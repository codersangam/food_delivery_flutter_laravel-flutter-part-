import 'package:food_delivery_laravel/models/product_model.dart';
import 'package:get/get.dart';
import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController {
  RecommendedProductController({required this.recommendedProductRepo});
  final RecommendedProductRepo recommendedProductRepo;

  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoading = true;
      update();
    } else {
      printError();
    }
  }
}
