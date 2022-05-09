import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/screens/auth/register_screen.dart';
import 'package:food_delivery_laravel/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../colors.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      // var authController = Get.find<AuthController>();

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (!GetUtils.isEmail(email)) {
        Get.snackbar('Error', 'email address is not valid.');
      } else if (password.isEmpty) {
        Get.snackbar('Error', 'password field is mandatory.');
      } else if (password.length < 6) {
        Get.snackbar(
            'Error', 'password length should be greater than 6 characters');
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            // ignore: avoid_print
            print('Login Successful');
            Get.to(() => const MainScreen());
          } else {
            Get.snackbar('Error', status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (_authController) {
          return _authController.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      120.heightBox,
                      VxCircle(
                        radius: 100,
                        backgroundColor: Colors.white,
                        backgroundImage: const DecorationImage(
                          image: AssetImage('assets/images/logopart1.png'),
                          fit: BoxFit.cover,
                        ),
                      ).centered(),
                      20.heightBox,
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Hello'.text.bold.xl6.make(),
                            'Login to your account'.text.make(),
                          ],
                        ),
                      ),
                      50.heightBox,
                      CustomTextField(
                        controller: emailController,
                        isPassword: false,
                        icon: Icons.email,
                        title: 'Email',
                        textInputType: TextInputType.emailAddress,
                      ),
                      20.heightBox,
                      CustomTextField(
                        controller: passwordController,
                        isPassword: true,
                        icon: Icons.lock,
                        title: 'Password',
                        textInputType: TextInputType.text,
                      ),
                      50.heightBox,
                      InkWell(
                        onTap: () => _login(_authController),
                        child: VxBox(
                          child: 'Login'.text.white.xl.makeCentered(),
                        )
                            .make()
                            .backgroundColor(primaryColor)
                            .cornerRadius(30)
                            .wh(120, 60),
                      ),
                      10.heightBox,
                      RichText(
                        text: TextSpan(
                          text: 'Not have an account?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[500],
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => Get.to(() => const RegisterScreen()),
                              text: 'Register',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
