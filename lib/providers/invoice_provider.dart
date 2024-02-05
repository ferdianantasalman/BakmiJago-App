import 'dart:convert';
import 'dart:developer';

import 'package:bakmi_jago_app/models/invoice/invoice_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../resources/constant.dart';
import '../resources/endpoint.dart';

class InvoiceProvider {
  static Future<List<InvoiceModel>> getInvoices() async {
    String invoiceAllUrl = baseUrl + Endpoint.user_invoices;
    List<InvoiceModel> listInvoiceModel = [];

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(invoiceAllUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("RESPONSE => ${responseJson["invoices"]}");
      if (response.statusCode == 200) {
        for (var data in responseJson["invoices"]) {
          InvoiceModel invoiceModel = InvoiceModel.fromJson(data);
          listInvoiceModel.add(invoiceModel);

          // log("IMAGE == ${baseUrl}public/${productModel.image!}");
        }
      }

      return listInvoiceModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<InvoiceModel>> getInvoicesToday() async {
    String invoiceAllUrl = baseUrl + Endpoint.user_invoice_time + "today";
    List<InvoiceModel> listInvoiceModel = [];

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(invoiceAllUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("TODAY => ${responseJson["invoices"]}");
      if (response.statusCode == 200) {
        for (var data in responseJson["invoices"]) {
          InvoiceModel invoiceModel = InvoiceModel.fromJson(data);
          listInvoiceModel.add(invoiceModel);

          // log("IMAGE == ${baseUrl}public/${productModel.image!}");
        }
      }

      return listInvoiceModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<InvoiceModel>> getInvoicesWeek() async {
    String invoiceAllUrl = baseUrl + Endpoint.user_invoice_time + "this_week";
    List<InvoiceModel> listInvoiceModel = [];

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(invoiceAllUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("WEEK=> $responseJson");
      if (response.statusCode == 200) {
        for (var data in responseJson["invoices"]) {
          InvoiceModel invoiceModel = InvoiceModel.fromJson(data);
          listInvoiceModel.add(invoiceModel);

          // log("IMAGE == ${baseUrl}public/${productModel.image!}");
        }
      }

      return listInvoiceModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<InvoiceModel>> getInvoicesMonth() async {
    String invoiceAllUrl = baseUrl + Endpoint.user_invoice_time + "this_month";
    List<InvoiceModel> listInvoiceModel = [];

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(invoiceAllUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("MONTH => $responseJson");
      if (response.statusCode == 200) {
        for (var data in responseJson["invoices"]) {
          InvoiceModel invoiceModel = InvoiceModel.fromJson(data);
          listInvoiceModel.add(invoiceModel);

          // log("IMAGE == ${baseUrl}public/${productModel.image!}");
        }
      }

      return listInvoiceModel;
    } catch (e) {
      throw Exception(e);
    }
  }
}
