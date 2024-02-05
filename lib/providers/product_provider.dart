import 'dart:convert';
import 'dart:developer';

import 'package:bakmi_jago_app/models/product/product_model.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:bakmi_jago_app/resources/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

class ProductProvider {
  static Future<List<ProductModel>> getProducts() async {
    String productUrl = baseUrl + Endpoint.user_product;
    List<ProductModel> listProductsModel = [];

    var box = GetStorage();
    String token = box.read(userToken);

    log("Token == $token");

    try {
      var response = await http.get(
        Uri.parse(productUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      var responseJson = json.decode(response.body);
      log("RESPONSE => $responseJson");

      if (response.statusCode == 200) {
        log("RESPONSE Code==  ${response.statusCode}");
        for (var data in responseJson["datas"]) {
          ProductModel productModel = ProductModel.fromJson(data);
          listProductsModel.add(productModel);

          log("IMAGE == ${baseUrl}public/${productModel.image!}");
        }

        // productsModel = ProductsModel.fromJson(responseJson);
        // return productsModel;
      }

      return listProductsModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addProduct(
    String code,
    String name,
    String price,
    String qty,
    String category,
    String imgPath,
  ) async {
    final Dio dio = Dio();

    String editProductUrl = baseUrl + Endpoint.user_product;
    final box = GetStorage();
    String token = box.read(userToken);
    try {
      var response = await dio.post(
        editProductUrl,
        data: FormData.fromMap(
          {
            'code': code,
            'name': name,
            'price': price,
            'qty': qty,
            'category': category,
            'image': await MultipartFile.fromFile(imgPath),
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", response.data['message'].toString());

        box.remove(currentPathImg);
        return true;
      } else {
        Get.snackbar("Gagal", response.data['message'].toString());
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
    return false;
  }

  static Future<bool> editProduct(
    int id,
    String code,
    String name,
    String price,
    String qty,
    String category,
    String oldImgPath,
    String newImgPath,
  ) async {
    final Dio dio = Dio();

    String editProductUrl =
        baseUrl + Endpoint.user_product + "/" + id.toString();
    final box = GetStorage();
    String token = box.read(userToken);

    log("Produc ID == $id");
    log("new img == $newImgPath");
    try {
      var response = await dio.post(
        editProductUrl,
        data: FormData.fromMap(
          {
            'code': code,
            'name': name,
            'price': price,
            'qty': qty,
            'category': category,
            'image': newImgPath.isNotEmpty
                ? await MultipartFile.fromFile(newImgPath)
                : oldImgPath,
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      log("RESPONSE CODE == ${response.statusCode}");
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", response.data['message'].toString());

        box.remove(currentPathImg);
        return true;
      } else {
        Get.snackbar("Gagal", response.data['message'].toString());
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
    return false;
  }

  static Future<bool> deleteProduct(
    int id,
  ) async {
    String editProductUrl =
        baseUrl + Endpoint.user_product + "/" + id.toString();
    final box = GetStorage();
    String token = box.read(userToken);
    try {
      var response = await http.delete(Uri.parse(editProductUrl), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Produk berhasil dihapus");

        box.remove(currentPathImg);
        return true;
      } else {
        Get.snackbar("Gagal", "Produk gagal dihapus");
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data);
    }
    return false;
  }
}
