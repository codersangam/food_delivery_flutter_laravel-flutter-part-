import 'package:food_delivery_laravel/models/user_model.dart';
import 'package:food_delivery_laravel/models/response_model.dart';
import 'package:get/get.dart';
import '../data/repository/user_repo.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, 'successfully');
    } else {
      responseModel = ResponseModel(false, response.statusText.toString());
    }
    update();
    return responseModel;
  }
}
