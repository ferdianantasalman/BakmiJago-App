import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/auth/login_view.dart';
import 'package:bakmi_jago_app/views/bottom_navigation_bar/bottom_navigation_bar_owner.dart';
import 'package:bakmi_jago_app/views/product/home_product_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:isibi/app/routes/app_pages.dart';

// import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends StatelessWidget {
  // const SplashScreenView({Key? key}) : super(key: key);
  // final getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), (() {
      Get.offAll(const BottomNavBarOwner());
    }));
    return Scaffold(
      backgroundColor: cWhite,
      body: Center(
          child: Image.asset("assets/images/logo.jpg", width: 300, height: 300)
          // Text("BakmiJago",
          //     style: bold.copyWith(fontSize: 20, color: cYellowDark)),
          ),
    );
  }
}
