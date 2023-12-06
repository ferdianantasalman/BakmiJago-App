import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
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
      Get.offAll(HomeProductView());
    }));
    return Scaffold(
      body: Center(
        child: Text("BakmiJago",
            style: bold.copyWith(fontSize: 20, color: cYellowDark)),
      ),
    );
  }
}
