import 'package:food_delivery_laravel/data/repository/auth_repo.dart';
import 'package:food_delivery_laravel/models/user_model.dart';
import 'package:food_delivery_laravel/models/response_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(UserModel userModel) async {
    _isLoading = true;
    late ResponseModel responseModel;
    Response response = await authRepo.registration(userModel);
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText.toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    Response response = await authRepo.login(email, password);
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText.toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserEmailAndPassword(String email, String password) {
    authRepo.saveUserEmailAndPassword(email, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool logout() {
    return authRepo.logout();
  }
}
