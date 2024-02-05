import 'dart:io';

import 'package:bakmi_jago_app/components/button_component.dart';
import 'package:bakmi_jago_app/components/text_field_outlined_component.dart';
import 'package:bakmi_jago_app/controllers/product_controller.dart';
import 'package:bakmi_jago_app/controllers/select_image_controller.dart';
import 'package:bakmi_jago_app/models/product/product_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({
    super.key,
    this.isEdit = false,
    this.productModels,
  });

  final bool isEdit;
  final ProductModel? productModels;

  @override
  Widget build(BuildContext context) {
    final pController = Get.put(ProductController());
    if (isEdit == false) {
      pController.codeController.value.clear();
      pController.productController.value.clear();
      pController.categoryController.value.clear();
      pController.priceController.value.clear();
      pController.stockController.value.clear();
    }
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        foregroundColor: cYellowDark,
        title: Text(
          isEdit ? "Edit Produk" : "Tambah Produk",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Kode Produk",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    hintText: "Kode Produk",
                    textController: pController.codeController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Text("Nama Produk",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    hintText: "Nama Produk",
                    textController: pController.productController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Text("Harga Produk",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    hintText: "Harga Produk",
                    textController: pController.priceController.value,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                Text("Stok Produk",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    hintText: "Stok Produk",
                    textController: pController.stockController.value,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                Text("Kategori Produk",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    hintText: "Kategori",
                    textController: pController.categoryController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Text("Gambar", style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                GetX<SelectImageController>(
                  init: SelectImageController(),
                  builder: (imageController) => Column(
                    children: [
                      InkWell(
                        onTap: () => imageController.selectImage(),
                        child: isEdit && imageController.path.value == 'Pilih'
                            ? Container(
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(color: cYellowDark),
                                ),
                                child: Image.network(
                                  "${baseUrl}public/products/${productModels!.image}",
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                          'assets/images/placeholder.png'),
                                ),
                              )
                            : SizedBox(
                                width: double.infinity,
                                height: 200,
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: imageController.path.value != 'Pilih'
                                      ? Image.file(
                                          File(imageController.path.value))
                                      : const Center(
                                          child: Text(
                                            "Upload foto Pengajuan",
                                            style:
                                                TextStyle(color: cYellowDark),
                                          ),
                                        ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    !isEdit
                                        ? "Pilih File yang cocok untuk pengiriman data yang harus anda kirimkan"
                                        : "Klik gambar di atas untuk mengupload ulang gambar baru",
                                    textAlign: TextAlign.center,
                                  ),
                                  ButtonComponent(
                                    isEdit ? "Edit Produk" : "Tambah Produk",
                                    onPressed: () async {
                                      var res = false;
                                      if (isEdit) {
                                        res = await pController
                                            .editProduct(productModels!);
                                      } else {
                                        res = await pController.addProduct();
                                      }
                                      Navigator.pop(context, res);
                                    },
                                    color: cYellowDark,
                                  ),
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
