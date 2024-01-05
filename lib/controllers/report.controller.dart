import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: "Pemasukan",
    ),
    const Tab(text: "Pengeluaran"),
    const Tab(text: "Penjualan"),
  ];
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> totalController = TextEditingController().obs;
  Rx<TextEditingController> descController = TextEditingController().obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: myTabs.length);

    // getHistoryDay();
    // getHistoryMonth();
    // getHistoryYear();
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
