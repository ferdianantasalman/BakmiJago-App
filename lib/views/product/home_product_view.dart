import 'package:bakmi_jago_app/components/product_card_component.dart';
import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/controllers/product_controller.dart';
import 'package:bakmi_jago_app/main.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/product/add_product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeProductView extends StatelessWidget {
  const HomeProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final pController = Get.put(ProductController());
    pController.getProducts();
    var box = GetStorage();
    String userName = box.read(uName);

    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        title: Text(
          "Bakmi Jago",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text("Selamat Datang",
                        style: bold.copyWith(color: cYellowDark, fontSize: 15)),
                    // Container(
                    //   height: 32,
                    //   width: 32,
                    //   child: CircleAvatar(
                    //     backgroundImage: NetworkImage(
                    //       "https://www.w3schools.com/w3images/avatar2.png",
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(width: 10),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       "Owner",
                    //       // userName ?? "Admin",
                    //       style:
                    //           bold.copyWith(color: cYellowDark, fontSize: 15),
                    //     ),
                    //     // Text(
                    //     //   "Pengguna",
                    //     //   style: regular.copyWith(color: cBlack),
                    //     // )
                    //   ],
                    // ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        var res = await Get.to(AddProductView());

                        if (res is bool) {
                          if (res) {
                            await pController.getProducts();
                          }
                        }
                      },
                      child: Text("Tambah"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: cWhite,
                          foregroundColor: cYellowDark),
                    )
                    // IconButton(
                    //     icon: const Icon(Icons.create),
                    //     onPressed: () {
                    //       Get.to(const MyApp());
                    //     }),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: TextField(
              //     style: const TextStyle(color: cDarkYellow),
              //     cursorColor: cDarkYellow,
              //     controller: pController.searchController.value,
              //     decoration: InputDecoration(
              //         hintText: "Search",
              //         hintStyle: const TextStyle(color: cDarkYellow),
              //         focusColor: cDarkYellow,
              //         suffixIcon: IconButton(
              //             icon: const Icon(Icons.clear, color: cDarkYellow),
              //             onPressed: () {
              //               pController.searchController.value.clear();
              //             }),
              //         prefixIcon: IconButton(
              //             icon: const Icon(Icons.search, color: cDarkYellow),
              //             onPressed: () {}),
              //         enabledBorder: OutlineInputBorder(
              //             borderSide: const BorderSide(color: cDarkYellow),
              //             borderRadius: BorderRadius.circular(20)),
              //         focusedBorder: OutlineInputBorder(
              //             borderSide: const BorderSide(color: cDarkYellow),
              //             borderRadius: BorderRadius.circular(20))),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Daftar Produk",
                  textAlign: TextAlign.left,
                  style: bold.copyWith(
                    color: cYellowDark,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => pController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(color: cYellowDark),
                    )
                  : pController.listProductModel.isEmpty
                      ? Center(
                          child: Text("Data tidak ditemukan",
                              style: regular.copyWith(
                                  color: cBlack, fontSize: 20)))
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: pController.listProductModel.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  mainAxisExtent: 260),
                          itemBuilder: (context, index) {
                            return ProductCardComponent(
                                onTapEdit: () async {
                                  pController.populateFieldWhenEdit(
                                      pController.listProductModel[index]);
                                  var res = await Get.to(AddProductView(
                                      productModels:
                                          pController.listProductModel[index],
                                      isEdit: true));

                                  if (res is bool) {
                                    if (res) {
                                      await pController.getProducts();
                                    }
                                  }
                                },
                                onTapDelete: () async {
                                  Navigator.pop(context, true);

                                  await pController.deleteProduct(
                                      pController.listProductModel[index]);
                                  await pController.getProducts();
                                },
                                productModel:
                                    pController.listProductModel[index]);
                          })),
            ],
          ),
        ),
      ),
    );
  }
}
