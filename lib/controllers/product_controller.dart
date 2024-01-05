import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> codeController = TextEditingController().obs;
  Rx<TextEditingController> productController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> stockController = TextEditingController().obs;

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

  Future getImage() async {}
}
