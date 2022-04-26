import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_laravel/screens/auth/register_screen.dart';
import 'package:food_delivery_laravel/screens/main_screen.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../colors.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
      body: GetBuilder<AuthController>(builder: (_authController) {
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
                      onTap: () {
                        _login(_authController);
                      },
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
                          ]),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.title,
    required this.isPassword,
    required this.textInputType,
  }) : super(key: key);

  final TextEditingController controller;
  final IconData icon;
  final String title;
  final bool isPassword;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: const Offset(1, 10),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: title,
          prefixIcon: Icon(
            icon,
            color: Colors.yellow,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
