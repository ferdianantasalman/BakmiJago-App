import 'dart:convert';
import 'dart:developer';
import 'package:bakmi_jago_app/controllers/user_controller.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:bakmi_jago_app/resources/endpoint.dart';
import 'package:bakmi_jago_app/views/auth/login_view.dart';
import 'package:bakmi_jago_app/views/bottom_navigation_bar/bottom_navigation_bar_cashier.dart';
import 'package:bakmi_jago_app/views/bottom_navigation_bar/bottom_navigation_bar_owner.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../providers/auth_provider.dart';

class AuthController extends GetxController {
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  final formKey = GlobalKey<FormState>().obs;
  final RxList<String> roles = <String>[
    "owner",
    "cashier",
  ].obs;
  RxInt role = RxInt(0);
  RxBool isLoading = false.obs;
  final box = GetStorage();
  RxBool redirectToLogin = false.obs;

  convertRole(String roleName) {
    switch (roleName) {
      case "owner":
        role.value = 2;
        log(role.value.toString());
        return role.value;
      case "cashier":
        role.value = 3;
        log(role.value.toString());
        return role.value;
      default:
        break;
    }
  }

  Future registerUser() async {
    try {
      isLoading.value = true;
      await AuthProvider.registerUser(
        role.value,
        nameController.value.text,
        emailController.value.text,
        passwordController.value.text,
      );
      nameController.value.clear();
      emailController.value.clear();
      passwordController.value.clear();
    } on DioError catch (e) {
      throw Exception("$e with ${e.message}");
    } finally {
      isLoading.value = false;
    }
  }

  Future loginUser() async {
    try {
      isLoading.value = true;
      log("email = ${emailController.value.text}");
      log("password = ${passwordController.value.text}");
      await AuthProvider.login(
        emailController.value.text,
        passwordController.value.text,
      ).then((value) async {
        log("LOGIN VALUE => $value");
        log("LOGIN Role => ${value['role_id']}");

        int roleId = value['role_id'];
        log("roleId => $roleId");
        // int roleId = int.parse(value['role_id'].toString());
        box.write(userToken, value['access_token']);
        box.write(keyRoleId, roleId);
        log("ROLE => ${box.read(keyRoleId)}");
        log("Token => ${box.read(userToken)}");
        emailController.value.clear();
        passwordController.value.clear();
        // await UserController()
        //     .getInfoUser()
        //     .then((value) => box.write(currentUserId, value['id']));
        log("Token => ${box.read(userToken)}");

        switch (roleId) {
          case 1:
            log(roleId.toString());
            return Get.snackbar(
              'Pemberitahuan',
              'Admin tidak memiliki akses ke dalam aplikasi',
            );
          case 2:
            log(roleId.toString());
            return Get.offAll(const BottomNavBarOwner());
          case 3:
            log(roleId.toString());
            return Get.offAll(const BottomNavBarCashier());
          default:
            break;
        }
      });
    } catch (e) {
      Get.snackbar("Invalid Data", "Email/Password kamu salah :(");
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> logout() async {
    String logoutUrl = baseUrl + Endpoint.user_logout;
    var token = box.read(userToken);
    try {
      var response = await http.post(
        Uri.parse(logoutUrl),
        headers: {"Authorization": "Bearer $token"},
      );
      emailController.value.clear();
      passwordController.value.clear();
      box.remove(userToken);
      Get.offAll(const LoginView());

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        return responseJson;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future refreshToken() async {
    final token = box.read(userToken);

    try {
      final json = await AuthProvider.refreshToken(token);
      final newToken = json["access_token"].toString();
      if (newToken.isNotEmpty) {
        box.write(userToken, newToken);
        box.write(keyRoleId, json["role_id"]);
        redirectToLogin.value = false;
        await UserController()
            .getInfoUser()
            .then((value) => box.write(currentUserId, value.id));
      }
    } catch (e) {
      redirectToLogin.value = true;
    }
  }
}
