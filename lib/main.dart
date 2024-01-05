import 'package:bakmi_jago_app/controllers/auth_controller.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:bakmi_jago_app/views/auth/login_view.dart';
import 'package:bakmi_jago_app/views/bottom_navigation_bar/bottom_navigation_bar_cashier.dart';
import 'package:bakmi_jago_app/views/bottom_navigation_bar/bottom_navigation_bar_owner.dart';
import 'package:bakmi_jago_app/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Future.delayed(const Duration(seconds: 3));
  // FlutterNativeSplash.remove();
  await GetStorage.init();

  runApp(const MyApp());
  initializeDateFormatting();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final controller = Get.put(AuthController());
    controller.refreshToken();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SplashScreenView()
      home: box.read(userToken) != null
          ? Obx(
              () => controller.redirectToLogin.value
                  ? const LoginView()
                  : homeViewPerRole(box.read(keyRoleId)),
            )
          : const LoginView(),
    );
  }

  homeViewPerRole(roleId) {
    switch (roleId) {
      case 2:
        return const BottomNavBarOwner();
      case 3:
        return const BottomNavBarCashier();
      default:
        break;
    }
  }
}
