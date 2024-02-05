import 'dart:developer';

import 'package:bakmi_jago_app/models/revenue_model.dart';
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
  Rx<RevenueModel> revenueModelToday = RevenueModel().obs;
  Rx<RevenueModel> revenueModelWeek = RevenueModel().obs;
  Rx<RevenueModel> revenueModelMonth = RevenueModel().obs;

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
      log("WEEK RES === $invoices");
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
      revenueModelMonth.value = invoices;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
