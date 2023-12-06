import 'package:bakmi_jago_app/components/text_field_component.dart';
import 'package:bakmi_jago_app/controllers/auth_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: cWhite,
      body: Center(
        child: Form(
          key: controller.formKey.value,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      color: cPrimaryGreen,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    'assets/images/login.jpg',
                    width: 300,
                    height: 250,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        child: TextFieldComponent(
                            controller: controller.emailController.value,
                            hintText: "Email",
                            icon: Icons.person,
                            obsecureText: false,
                            keyboarType: TextInputType.emailAddress),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        child: TextFieldComponent(
                            controller: controller.passwordController.value,
                            hintText: "Password",
                            icon: Icons.lock,
                            obsecureText: true,
                            keyboarType: TextInputType.emailAddress),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          child: Text("Login"),
                          onPressed: () {},
                          // controller.formKey.value.currentState!.validate()
                          //     ? controller.loginUser()
                          //     : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: cWhite,
                              foregroundColor: cYellowDark),
                        ),
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
