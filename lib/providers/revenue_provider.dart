import 'dart:convert';
import 'dart:developer';

import 'package:bakmi_jago_app/models/revenue_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../resources/constant.dart';
import '../resources/endpoint.dart';

class RevenueProvider {
  static Future getRevenueToday() async {
    String revenueUrl = baseUrl + Endpoint.user_revenue + "today";
    String revenueModel = "";

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(revenueUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("TODAY Revenue=> ${responseJson}");
      if (response.statusCode == 200) {
        log("behasil");

        // RevenueModel revenueModel = RevenueModel.fromJson(responseJson);
      }

      log("REVENUE TODAY == ${responseJson}");
      return responseJson['revenue'];
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future getRevenueWeek() async {
    String revenueUrl = baseUrl + Endpoint.user_revenue + "this_week";
    RevenueModel revenueModel = RevenueModel();

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(revenueUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("WEEK Revenue=> ${responseJson}");
      if (response.statusCode == 200) {
        log("behasil");
        // RevenueModel revenueModel = RevenueModel.fromJson(responseJson);
      }

      log("REVENUE WEEK == ${responseJson['revenue']}");

      return responseJson['revenue'];
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future getRevenueMonth() async {
    String revenueUrl = baseUrl + Endpoint.user_revenue + "this_month";
    RevenueModel revenueModel = RevenueModel();

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(revenueUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("TODAY Revenue=> ${responseJson}");
      if (response.statusCode == 200) {
        log("behasil");

        // RevenueModel revenueModel = RevenueModel.fromJson(responseJson);
      }
      log("REVENUE MONTH == ${responseJson['revenue']}");

      // return responseJson['revenue'] as int;
      return responseJson['revenue'];
    } catch (e) {
      throw Exception(e);
    }
  }
}
