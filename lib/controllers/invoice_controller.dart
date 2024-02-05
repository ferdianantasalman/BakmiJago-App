import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bakmi_jago_app/models/invoice/invoice_model.dart';
import 'package:bakmi_jago_app/providers/invoice_provider.dart';
import 'package:bakmi_jago_app/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController
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
  RxList<InvoiceModel> listInvoiceModel = <InvoiceModel>[].obs;
  RxList<InvoiceModel> listInvoiceModelToday = <InvoiceModel>[].obs;
  RxList<InvoiceModel> listInvoiceModelWeek = <InvoiceModel>[].obs;
  RxList<InvoiceModel> listInvoiceModelMonth = <InvoiceModel>[].obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: myTabs.length);
    getInvoices();
    getInvoicesToday();
    getInvoicesWeek();
    getInvoicesMonth();

    log("""
    ==== Init Controller====
    InvoiceModelToday === $listInvoiceModelToday
    InvoiceModelWeek === $listInvoiceModelWeek
    InvoiceModelMonth === $listInvoiceModelMonth
    === END =====
    """);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future getInvoices() async {
    try {
      isLoading.value = true;
      final invoices = await InvoiceProvider.getInvoices();
      listInvoiceModel.value = invoices;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getInvoicesToday() async {
    try {
      isLoading.value = true;
      final invoices = await InvoiceProvider.getInvoicesToday();
      listInvoiceModelToday.value = invoices;

      log("RES INVOICE MODE ===  ${listInvoiceModel.value}");

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getInvoicesWeek() async {
    try {
      isLoading.value = true;
      final invoices = await InvoiceProvider.getInvoicesWeek();
      log("WEEK RES === $invoices");
      listInvoiceModelWeek.value = invoices;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getInvoicesMonth() async {
    try {
      isLoading.value = true;
      final invoices = await InvoiceProvider.getInvoicesMonth();
      listInvoiceModelMonth.value = invoices;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
