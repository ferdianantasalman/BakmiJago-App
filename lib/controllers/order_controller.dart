import 'dart:convert';

import 'package:bakmi_jago_app/models/order_model.dart';
import 'package:bakmi_jago_app/utils/cart_database_helper.dart';
import 'package:bakmi_jago_app/views/order/order_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrderController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<TextEditingController> inputCashController = TextEditingController().obs;

  final name = [
    "Bakmi Jawa",
    "Bakmi Ayam",
    "Bakmi Daging",
    "Bakmi Jawa",
    "Bakmi Ayam",
    "Bakmi Daging",
    "Bakmi Jawa",
    "Bakmi Ayam",
    "Bakmi Daging",
    "Bakmi Daging",
  ].obs;

  final image = [
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
    "https://images.genpi.co/resize/1200x675-100/uploads/data/images/komunikasi.webp",
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
    "https://images.genpi.co/resize/1200x675-100/uploads/data/images/komunikasi.webp",
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
    "https://images.genpi.co/resize/1200x675-100/uploads/data/images/komunikasi.webp",
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
  ].obs;

  final price = [
    50000,
    40000,
    30000,
    50000,
    40000,
    30000,
    50000,
    40000,
    30000,
    50000,
  ].obs;

  Future addToCart(OrderModel orderModel) async {
    try {
      await CartDatabaseHelper.instance.insert(orderModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> addOrders() async {
    // static Future<dynamic> addOrders(List<OrderModel> orders) async {
    //   final Dio dio = Dio();
    //   String addOrderUrl = baseUrl + Endpoint.user_add_order;
    //   var box = GetStorage();
    //   String token = box.read(userToken);
    //   List<dynamic> listOrders = [];
    //   for (var order in orders) {
    //     listOrders.add({
    //       "barang_id": order.id!,
    //       "qty": order.quantity,
    //     });
    //   }

    //   try {
    //     var jsonData = {"ordered_items": listOrders};
    //     var response = await dio.post(
    //       addOrderUrl,
    //       data: jsonEncode(jsonData),
    //       options: Options(headers: {
    //         'Authorization': 'Bearer $token',
    //       }),
    //     );

    //     if (response.statusCode == 200) {
    //       // Get.offAll(SuccessView(
    //       //   invoiceId: response.data["invoice"]["invoice"].toString(),
    //       // ));
    //       Get.offAll(OrderView());
    //       Get.snackbar("Success", "Kamu berhasil membuat pesanan");
    //       return response.data["invoice"];
    //     } else {
    //       Get.snackbar("Error", response.statusMessage!);
    //       throw Exception(response.data);
    //     }
    //   } on DioError catch (e) {
    //     Get.snackbar("Error", e.response!.statusMessage!);
    //     throw Exception(e.response?.data);
    //   }
  }
}
