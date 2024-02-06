import 'dart:developer';

import 'package:bakmi_jago_app/providers/revenue_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RevenueController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: "Hari ini",
    ),
    const Tab(text: "Minggu ini"),
    const Tab(text: "Bulan ini"),
  ];

  RxBool isLoading = false.obs;
  Rx<TextEditingController> inputCashController = TextEditingController().obs;
  Rx<String> revenueModelToday = "".obs;
  Rx<String> revenueModelWeek = "".obs;
  Rx<String> revenueModelMonth = "".obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: myTabs.length);
    getRevenueToday();
    getRevenueWeek();
    getRevenueMonth();

    log("""
    ==== Init Controller====
    revenueModelToday === $revenueModelToday
    revenueModelWeek === $revenueModelWeek
    revenueModelMonth === $revenueModelMonth
    === END =====
    """);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future getRevenueToday() async {
    try {
      isLoading.value = true;
      final invoices = await RevenueProvider.getRevenueToday();
      revenueModelToday.value = invoices;

      log("mangan");

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getRevenueWeek() async {
    try {
      isLoading.value = true;
      final invoices = await RevenueProvider.getRevenueWeek();
      log("WEEK RES === $invoices sk");
      revenueModelWeek.value = invoices;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getRevenueMonth() async {
    try {
      isLoading.value = true;
      final invoices = await RevenueProvider.getRevenueMonth();
      log("hehe $invoices");
      revenueModelMonth.value = invoices;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
