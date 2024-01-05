import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: "Hari ini",
    ),
    const Tab(text: "Bulan ini"),
    const Tab(text: "Tahun ini"),
  ];
  RxBool isLoading = false.obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;

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
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
    "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
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

  void getHistoryDay() {
    isLoading.value = true;

    // Fetch Data

    isLoading.value = false;
  }

  void getHistoryMonth() {
    isLoading.value = true;

    // Fetch Data

    isLoading.value = false;
  }

  void getHistoryYear() {
    isLoading.value = true;

    // Fetch Data

    isLoading.value = false;
  }
}
