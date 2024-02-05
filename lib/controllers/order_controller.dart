// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bakmi_jago_app/models/cart_model.dart';
import 'package:bakmi_jago_app/models/order_model.dart';
import 'package:bakmi_jago_app/providers/order_provider.dart';

class OrderController extends GetxController {
  OrderController({
    this.id,
  });

  final int? id;

  RxBool isLoading = false.obs;
  Rx<TextEditingController> inputCashController = TextEditingController().obs;
  Rx<OrderModel> orderModel = OrderModel().obs;
  RxList<OrderModel> listOrderModel = <OrderModel>[].obs;
  RxList<OrderModel> listOrderModelInvoice = <OrderModel>[].obs;

  @override
  void onInit() {
    if (id != null) {
      log("jalan");
      getDetailOrderByInvoice(id!);
      log("jalan model == $listOrderModelInvoice");
    }
    super.onInit();
  }

  Future getOrders() async {
    try {
      isLoading.value = true;
      final orders = await OrderProvider.getOrders();
      listOrderModel.value = orders;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getDetailOrderByInvoice(int id) async {
    try {
      isLoading.value = true;
      final orders = await OrderProvider.getDetailOrderByInvoice(id);
      listOrderModelInvoice.value = orders;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getDetailOrderById(int id) async {
    try {
      isLoading.value = true;
      final order = await OrderProvider.getDetailOrderById(id);
      orderModel.value = order;
      return orderModel.value;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future addOrder(int productId, int qty, int totalPrice) async {
    try {
      isLoading.value = true;
      await OrderProvider.addOrder(productId, qty, totalPrice);
      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future addOrders(List<CartModel> orders) async {
    try {
      isLoading.value = true;
      await OrderProvider.addOrders(orders);
      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
