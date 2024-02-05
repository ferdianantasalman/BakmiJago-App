import 'dart:convert';
import 'dart:developer';

import 'package:bakmi_jago_app/models/user_model.dart';
import 'package:bakmi_jago_app/resources/endpoint.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../resources/constant.dart';

class UserProvider {
  static Future<UserModel> getUser() async {
    String userInfoUrl = baseUrl + Endpoint.user_info;
    UserModel userModel = UserModel();
    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(userInfoUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // log("RESPONSE BODY == ${response.body}");
      var userData = json.decode(response.body);

      if (response.statusCode == 200) {
        var userModel = UserModel.fromJson(userData);
        log("USERMODEL => $userModel");
        return userModel;
      }
      return userModel;
    } catch (e) {
      throw Exception(e);
    }
  }
}
