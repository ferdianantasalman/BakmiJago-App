import 'dart:convert';
import 'dart:developer';
import 'package:bakmi_jago_app/models/error_register_model.dart';
import 'package:bakmi_jago_app/resources/endpoint.dart';
import 'package:bakmi_jago_app/views/bottom_navigation_bar/bottom_navigation_bar_owner.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../resources/constant.dart';

class AuthProvider {
  static Future<dynamic> login(String email, String password) async {
    String loginUrl = baseUrl + Endpoint.user_auth;
    try {
      http.Response response = await http.post(
        Uri.parse(loginUrl),
        body: {
          'email': email,
          'password': password,
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      log("RESPONSE => ${response.body}");
      final responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        log("Status Code => ${response.statusCode}");

        log("RETURN LOGIN => ${responseJson}");
        return responseJson;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> refreshToken(String token) async {
    String refreshTokenUrl = baseUrl + Endpoint.user_refresh_token;

    log("Token $token");
    try {
      http.Response response = await http.post(
        Uri.parse(refreshTokenUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final json = jsonDecode(response.body);
      return json;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> registerUser(
    int roleId,
    String name,
    String email,
    String password,
  ) async {
    final Dio dio = Dio();
    String registerUrl = baseUrl + Endpoint.user_register;
    var box = GetStorage();
    String token = box.read(userToken);
    try {
      var response = await dio.post(
        registerUrl,
        data: FormData.fromMap({
          'role_id': roleId,
          'name': name,
          'email': email,
          'password': password,
        }),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      var responseData = response.data;

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", response.data['message'].toString());
        Get.offAll(const BottomNavBarOwner());
        return responseData;
      } else {
        Get.snackbar("Error", response.data['message'].toString());
      }
    } on DioError catch (e) {
      var error = ErrorRegisterModel.fromJson(e.response!.data);
      Get.snackbar("Error", "${error.username!.first} \n${error.email!.first}");
      throw e.response?.data;
    }
  }
}
