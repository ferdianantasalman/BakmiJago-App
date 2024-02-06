import 'dart:convert';
import 'dart:developer';

import 'package:bakmi_jago_app/models/income_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../resources/constant.dart';
import '../resources/endpoint.dart';

class IncomeProvider {
  static Future<String> getIncomeToday() async {
    String incomeUrl = baseUrl + Endpoint.user_income + "today";
    IncomeModel incomeModel = IncomeModel();

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(incomeUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        IncomeModel incomeModel = IncomeModel.fromJson(responseJson);
      }
      log("TODAY HEHE => ${responseJson['income']}");

      log("TODAY HEHE wkw=> ${responseJson['income']}");

      return responseJson['income'];
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> getIncomeWeek() async {
    String incomeUrl = baseUrl + Endpoint.user_income + "this_week";
    IncomeModel incomeModel = IncomeModel();

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(incomeUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("WEEK => ${responseJson}");
      if (response.statusCode == 200) {
        IncomeModel incomeModel = IncomeModel.fromJson(responseJson);
      }

      return responseJson['income'];
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> getIncomeMonth() async {
    String incomeUrl = baseUrl + Endpoint.user_income + "this_month";
    IncomeModel incomeModel = IncomeModel();

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(incomeUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("Month => ${responseJson}");
      if (response.statusCode == 200) {
        IncomeModel incomeModel = IncomeModel.fromJson(responseJson);
      }

      return responseJson['income'];
    } catch (e) {
      throw Exception(e);
    }
  }
}
