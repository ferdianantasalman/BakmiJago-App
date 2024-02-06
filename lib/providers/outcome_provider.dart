import 'dart:convert';
import 'dart:developer';

import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:bakmi_jago_app/resources/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

import 'package:bakmi_jago_app/models/outcome_model.dart';
import 'package:bakmi_jago_app/models/report_model.dart';

class OutcomeProvider {
  static Future<List<ReportModel>> getReports() async {
    String reportUrl = baseUrl + Endpoint.user_reports;
    List<ReportModel> listReportModel = [];

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(reportUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("RESPONSE => ${responseJson["reports"]}");
      if (response.statusCode == 200) {
        for (var data in responseJson["reports"]) {
          ReportModel reportModel = ReportModel.fromJson(data);
          listReportModel.add(reportModel);

          // log("IMAGE == ${baseUrl}public/${productModel.image!}");
        }
      }

      return listReportModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<ReportModel>> getReportsToday() async {
    String reportUrl = baseUrl + Endpoint.user_reports_time + "today";
    List<ReportModel> listReportModel = [];

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(reportUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("RESPONSE => ${responseJson["reports"]}");
      if (response.statusCode == 200) {
        for (var data in responseJson["reports"]) {
          ReportModel reportModel = ReportModel.fromJson(data);
          listReportModel.add(reportModel);

          // log("IMAGE == ${baseUrl}public/${productModel.image!}");
        }
      }

      log("List REPORT MODEL TODAY == $listReportModel");

      return listReportModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<ReportModel>> getReportsWeek() async {
    String reportUrl = baseUrl + Endpoint.user_reports_time + "this_week";
    List<ReportModel> listReportModel = [];

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(reportUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("RESPONSE => ${responseJson["reports"]}");
      if (response.statusCode == 200) {
        for (var data in responseJson["reports"]) {
          ReportModel reportModel = ReportModel.fromJson(data);
          listReportModel.add(reportModel);

          // log("IMAGE == ${baseUrl}public/${productModel.image!}");
        }
      }

      return listReportModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<ReportModel>> getReportsMonth() async {
    String reportUrl = baseUrl + Endpoint.user_reports_time + "this_month";
    List<ReportModel> listReportModel = [];

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(reportUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("RESPONSE => ${responseJson["reports"]}");
      if (response.statusCode == 200) {
        for (var data in responseJson["reports"]) {
          ReportModel reportModel = ReportModel.fromJson(data);
          listReportModel.add(reportModel);

          // log("IMAGE == ${baseUrl}public/${productModel.image!}");
        }
      }

      return listReportModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addReports(
    String name,
    String price,
    String keterangan,
  ) async {
    final Dio dio = Dio();

    String reportUrl = baseUrl + Endpoint.user_reports;
    final box = GetStorage();
    String token = box.read(userToken);
    try {
      var response = await dio.post(
        reportUrl,
        data: FormData.fromMap(
          {
            'name': name,
            'price': price,
            'keterangan': keterangan,
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", response.data['message'].toString());

        return true;
      } else {
        Get.snackbar("Gagal", response.data['message'].toString());
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
    return false;
  }

  static Future<bool> editReports(
    int id,
    String name,
    String price,
    String keterangan,
  ) async {
    final Dio dio = Dio();

    String reportUrl = baseUrl + Endpoint.user_reports + "/" + id.toString();
    final box = GetStorage();
    String token = box.read(userToken);

    log("Produc ID == $id");
    try {
      var response = await dio.post(
        reportUrl,
        data: FormData.fromMap(
          {
            'name': name,
            'price': price,
            'keterangan': keterangan,
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      log("RESPONSE CODE == ${response.statusCode}");
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", response.data['message'].toString());

        return true;
      } else {
        Get.snackbar("Gagal", response.data['message'].toString());
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
    return false;
  }

  static Future<bool> deleteReports(
    int id,
  ) async {
    String reportUrl = baseUrl + Endpoint.user_reports + "/" + id.toString();
    final box = GetStorage();
    String token = box.read(userToken);
    try {
      var response = await http.delete(Uri.parse(reportUrl), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Laporan berhasil dihapus");

        return true;
      } else {
        Get.snackbar("Gagal", "Laporan gagal dihapus");
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
    return false;
  }

  static Future<String> getOutcomeToday() async {
    String outcomeUrl = baseUrl + Endpoint.user_outcome + "today";
    OutcomeModel outcomeModel = OutcomeModel();

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(outcomeUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("TODAY OUTCOME=> ${responseJson}");
      if (response.statusCode == 200) {
        OutcomeModel outcomeModel = OutcomeModel.fromJson(responseJson);
      }

      return responseJson['outcome'];
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> getOutcomeWeek() async {
    String outcomeUrl = baseUrl + Endpoint.user_outcome + "this_week";
    OutcomeModel outcomeModel = OutcomeModel();

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(outcomeUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("WEEK OUTCOME => ${responseJson}");
      if (response.statusCode == 200) {
        OutcomeModel outcomeModel = OutcomeModel.fromJson(responseJson);
      }
      log("OUTCOME MODEL TODAY == $outcomeModel");

      return responseJson['outcome'];
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> getOutcomeMonth() async {
    String outcomeUrl = baseUrl + Endpoint.user_outcome + "this_month";
    OutcomeModel outcomeModel = OutcomeModel();

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(outcomeUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("MONTH OUTCOME => ${responseJson}");
      if (response.statusCode == 200) {
        OutcomeModel outcomeModel = OutcomeModel.fromJson(responseJson);
      }

      return responseJson['outcome'];
    } catch (e) {
      throw Exception(e);
    }
  }
}
