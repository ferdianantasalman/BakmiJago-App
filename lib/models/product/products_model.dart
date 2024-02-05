import 'package:bakmi_jago_app/models/product/product_model.dart';

class ProductsModel {
  String? status;
  String? message;
  List<ProductModel>? makanan;
  List<ProductModel>? minuman;
  List<ProductModel>? datas;

  ProductsModel({
    this.status,
    this.message,
    this.makanan,
    this.minuman,
    this.datas,
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['makanan'] != null) {
      makanan = <ProductModel>[];
      json['makanan'].forEach((v) {
        makanan!.add(ProductModel.fromJson(v));
      });
    }

    if (json['minuman'] != null) {
      minuman = <ProductModel>[];
      json['minuman'].forEach((v) {
        minuman!.add(ProductModel.fromJson(v));
      });
    }
    if (json['datas'] != null) {
      datas = <ProductModel>[];
      json['datas'].forEach((v) {
        datas!.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (makanan != null) {
      data['makanan'] = makanan!.map((v) => v.toJson()).toList();
    }
    if (minuman != null) {
      data['minuman'] = minuman!.map((v) => v.toJson()).toList();
    }
    if (datas != null) {
      data['datas'] = datas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
