import 'dart:convert';
import 'dart:developer';

import 'package:bakmi_jago_app/models/cart_model.dart';
import 'package:bakmi_jago_app/models/order_model.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../resources/constant.dart';
import '../resources/endpoint.dart';

class OrderProvider {
  static Future<List<OrderModel>> getOrders() async {
    String orderAllUrl = baseUrl + Endpoint.user_orders;
    List<OrderModel> listOrderModel = [];

    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await http.get(
        Uri.parse(orderAllUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("RESPONSE => $responseJson");
      if (response.statusCode == 200) {
        for (var data in responseJson["datas"]) {
          OrderModel orderModel = OrderModel.fromJson(data);
          listOrderModel.add(orderModel);

          // log("IMAGE == ${baseUrl}public/${productModel.image!}");
        }
      }

      return listOrderModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<OrderModel>> getDetailOrderByInvoice(int id) async {
    try {
      String invoiceUrl =
          baseUrl + Endpoint.user_orders_invoice + id.toString();
      var box = GetStorage();
      String token = box.read(userToken);
      List<OrderModel> listOrderModel = [];

      var response = await http.get(
        Uri.parse(invoiceUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);

      log("RESPONSE => ${responseJson["orders"]}");
      if (response.statusCode == 200) {
        for (var data in responseJson["orders"]) {
          OrderModel orderModel = OrderModel.fromJson(data);
          listOrderModel.add(orderModel);
          // log("IMAGE == ${baseUrl}public/${productModel.image!}");
        }
      }

      return listOrderModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<OrderModel> getDetailOrderById(int id) async {
    try {
      String invoiceUrl = baseUrl + Endpoint.user_orders_id + id.toString();
      var box = GetStorage();
      String token = box.read(userToken);
      OrderModel orderModel = OrderModel();

      var response = await http.get(
        Uri.parse(invoiceUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);

      log("RESPONSE => $responseJson");
      if (response.statusCode == 200) {
        orderModel = OrderModel.fromJson(responseJson);
        return orderModel;
      }

      return orderModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<dynamic> addOrder(int prodctId, int qty, int totalPrice) async {
    final Dio dio = Dio();
    String addOrderUrl = baseUrl + Endpoint.user_orders;
    var box = GetStorage();
    String token = box.read(userToken);

    try {
      var response = await dio.post(
        addOrderUrl,
        data: FormData.fromMap({
          'prodct_id': prodctId,
          'qty': qty,
        }),
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
      Get.snackbar("Error", e.response!.statusMessage!);
      throw Exception(e.response?.data);
    }
  }

  static Future<bool> addOrders(List<CartModel> orders) async {
    final Dio dio = Dio();
    String addOrderUrl = baseUrl + Endpoint.user_orders;
    var box = GetStorage();
    String token = box.read(userToken);
    List<dynamic> listOrders = [];
    for (var order in orders) {
      listOrders.add({
        "prodct_id": order.id!,
        "qty": order.quantity,
      });
    }

    try {
      var jsonData = {"ordered_items": listOrders};
      var response = await dio.post(
        addOrderUrl,
        data: jsonEncode(jsonData),
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
      Get.snackbar("Error", e.response!.statusMessage!);
      throw Exception(e.response?.data);
    }
    return false;
  }
}
