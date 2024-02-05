import 'dart:developer';

import 'package:bakmi_jago_app/models/product/products_model.dart';
import 'package:bakmi_jago_app/providers/product_provider.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:flutter/material.dart';
import 'package:bakmi_jago_app/models/product/product_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductController extends GetxController {
  Rx<bool> isLoading = false.obs;
  final _box = GetStorage();

  // Rx<ProductsModel> productsModel = ProductsModel().obs;
  RxList<ProductModel> listProductModel = <ProductModel>[].obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> codeController = TextEditingController().obs;
  Rx<TextEditingController> productController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> stockController = TextEditingController().obs;
  Rx<TextEditingController> categoryController = TextEditingController().obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  populateFieldWhenEdit(ProductModel productModel) {
    codeController.value.text = productModel.code!;
    productController.value.text = productModel.name!;
    categoryController.value.text = productModel.category!;
    priceController.value.text = productModel.price!.toString();
    stockController.value.text = productModel.qty!.toString();
  }

  void reset() {
    codeController.value.clear();
    productController.value.clear();
    categoryController.value.clear();
    priceController.value.clear();
    stockController.value.clear();
  }

  Future getProducts() async {
    try {
      isLoading.value = true;
      log("hehe");
      final products = await ProductProvider.getProducts();
      listProductModel.value = products;

      isLoading.value = false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addProduct() async {
    final imgPath = _box.read(currentPathImg);
    log("IMAGE => $imgPath");
    try {
      isLoading.value = true;
      var res = await ProductProvider.addProduct(
          codeController.value.text,
          productController.value.text,
          priceController.value.text,
          stockController.value.text,
          categoryController.value.text,
          imgPath);
      isLoading.value = false;
      reset();
      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> editProduct(ProductModel productModel) async {
    String? imgPath = _box.read(currentPathImg);
    log("NEW-IMAGE => $imgPath");

    try {
      isLoading.value = true;
      var res = await ProductProvider.editProduct(
        productModel.id!,
        codeController.value.text,
        productController.value.text,
        priceController.value.text,
        stockController.value.text,
        categoryController.value.text,
        productModel.image!,
        imgPath ?? '',
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

  Future<bool> deleteProduct(ProductModel productModel) async {
    try {
      isLoading.value = true;
      var res = await ProductProvider.deleteProduct(
        productModel.id!,
      );
      isLoading.value = false;

      return res;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  // final name = [
  //   "Bakmi Jawa",
  //   "Bakmi Ayam",
  //   "Bakmi Daging",
  //   "Bakmi Jawa",
  //   "Bakmi Ayam",
  //   "Bakmi Daging",
  //   "Bakmi Jawa",
  //   "Bakmi Ayam",
  //   "Bakmi Daging",
  //   "Bakmi Daging",
  // ].obs;

  // final image = [
  //   "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
  //   "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
  //   "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
  //   "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
  //   "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
  //   "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
  //   "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
  //   "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
  //   "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
  //   "https://img-cdn.medkomtek.com/0wCYZ1rjZxVTDRyy_fN3Gne8XjU=/730x411/smart/filters:quality(100):strip_icc():format(webp)/article/9ukfD6W7n0JJVny9QGRrD/original/034665600_1638512412-Cara-Teman-Tuli-Berlatih-Kemampuan-Bicara.jpg",
  // ].obs;

  // final price = [
  //   50000,
  //   40000,
  //   30000,
  //   50000,
  //   40000,
  //   30000,
  //   50000,
  //   40000,
  //   30000,
  //   50000,
  // ].obs;
}
