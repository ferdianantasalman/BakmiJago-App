import 'dart:developer';

import 'package:bakmi_jago_app/models/income_model.dart';
import 'package:bakmi_jago_app/providers/income_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeController extends GetxController
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
  Rx<IncomeModel> incomeModelToday = IncomeModel().obs;
  Rx<IncomeModel> incomeModelWeek = IncomeModel().obs;
  Rx<IncomeModel> incomeModelMonth = IncomeModel().obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: myTabs.length);
    getIncomeToday();
    getIncomeWeek();
    getIncomeMonth();

    log("""
    ==== Init Controller====
    IncomeModelToday === $incomeModelToday
    IncomeModelWeek === $incomeModelWeek
    IncomeModelMonth === $incomeModelMonth
    === END =====
    """);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future getIncomeToday() async {
    try {
      isLoading.value = true;
      final invoices = await IncomeProvider.getIncomeToday();
      incomeModelToday.value = invoices;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getIncomeWeek() async {
    try {
      isLoading.value = true;
      final invoices = await IncomeProvider.getIncomeWeek();
      log("WEEK RES === $invoices");
      incomeModelWeek.value = invoices;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getIncomeMonth() async {
    try {
      isLoading.value = true;
      final invoices = await IncomeProvider.getIncomeMonth();
      incomeModelMonth.value = invoices;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
