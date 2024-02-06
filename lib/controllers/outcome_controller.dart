import 'dart:developer';

import 'package:bakmi_jago_app/models/outcome_model.dart';
import 'package:bakmi_jago_app/models/report_model.dart';
import 'package:bakmi_jago_app/providers/outcome_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutcomeController extends GetxController
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
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> descController = TextEditingController().obs;

  RxList<ReportModel> listReportModel = <ReportModel>[].obs;
  RxList<ReportModel> listReportModelToday = <ReportModel>[].obs;
  RxList<ReportModel> listReportModelWeek = <ReportModel>[].obs;
  RxList<ReportModel> listReportModelMonth = <ReportModel>[].obs;
  Rx<String> outcomeModelToday = "".obs;
  Rx<String> outcomeModelWeek = "".obs;
  Rx<String> outcomeModelMonth = "".obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: myTabs.length);
    // getReports();
    getReportsToday();
    getReportsWeek();
    getReportsMonth();
    getOutcomeToday();
    getOutcomeWeek();
    getOutcomeMonth();

    log("""
    ==== Init Controller====
    OutcomeModelToday === $outcomeModelToday
    OutcomeModelWeek === $outcomeModelWeek
    OutcomeModelMonth === $outcomeModelMonth
    === END =====
    """);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  populateFieldWhenEdit(ReportModel reportModel) {
    nameController.value.text = reportModel.name!;
    priceController.value.text = reportModel.price!.toString();
    descController.value.text = reportModel.keterangan!;
  }

  void reset() {
    nameController.value.clear();
    priceController.value.clear();
    descController.value.clear();
  }

  Future getReports() async {
    try {
      isLoading.value = true;
      final reports = await OutcomeProvider.getReports();
      listReportModel.value = reports;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getReportsToday() async {
    try {
      isLoading.value = true;
      final Reports = await OutcomeProvider.getReportsToday();
      listReportModelToday.value = Reports;

      log("RES REPORT TODAY ===  ${listReportModelToday.value}");

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getReportsWeek() async {
    try {
      isLoading.value = true;
      final Reports = await OutcomeProvider.getReportsWeek();
      log("WEEK RES === $Reports");
      listReportModelWeek.value = Reports;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getReportsMonth() async {
    try {
      isLoading.value = true;
      final Reports = await OutcomeProvider.getReportsMonth();
      listReportModelMonth.value = Reports;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addReports() async {
    try {
      isLoading.value = true;
      var res = await OutcomeProvider.addReports(
        nameController.value.text,
        priceController.value.text,
        descController.value.text,
      );
      isLoading.value = false;
      reset();
      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> editReports(ReportModel reportModel) async {
    try {
      isLoading.value = true;
      var res = await OutcomeProvider.editReports(
        reportModel.id!,
        nameController.value.text,
        priceController.value.text,
        descController.value.text,
      );
      isLoading.value = false;

      reset();

      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteReports(ReportModel reportModel) async {
    try {
      isLoading.value = true;
      var res = await OutcomeProvider.deleteReports(
        reportModel.id!,
      );
      isLoading.value = false;

      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future getOutcomeToday() async {
    try {
      isLoading.value = true;
      final Reports = await OutcomeProvider.getOutcomeToday();
      outcomeModelToday.value = Reports;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getOutcomeWeek() async {
    try {
      isLoading.value = true;
      final Reports = await OutcomeProvider.getOutcomeWeek();
      log("WEEK RES === $Reports");
      outcomeModelWeek.value = Reports;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future getOutcomeMonth() async {
    try {
      isLoading.value = true;
      final Reports = await OutcomeProvider.getOutcomeMonth();
      outcomeModelMonth.value = Reports;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
