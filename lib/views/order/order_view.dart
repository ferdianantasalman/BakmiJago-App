import 'package:bakmi_jago_app/components/product_card_component.dart';
import 'package:bakmi_jago_app/controllers/cart_controller.dart';
import 'package:bakmi_jago_app/controllers/order_controller.dart';
import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/controllers/product_controller.dart';
import 'package:bakmi_jago_app/models/cart_model.dart';
import 'package:bakmi_jago_app/models/order_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/order/order_cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final pController = Get.put(ProductController());
    final cController = Get.put(CartController());
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        title: Text(
          "Pesanan",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 27),
            child: CircleAvatar(
              backgroundColor: cYellowDark,
              child: IconButton(
                onPressed: () => Get.to(const OrderCartView()),
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: cWhite,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
            child: Column(
              children: [
                Obx(() => pController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: cYellowDark,
                      ))
                    : pController.listProductModel.isEmpty
                        ? Center(
                            child: Text("Data tidak ditemukan",
                                style: regular.copyWith(
                                    color: cBlack, fontSize: 20)))
                        : GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: pController.listProductModel.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                    mainAxisExtent: 260),
                            itemBuilder: (context, index) {
                              var itemProduct =
                                  pController.listProductModel[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(color: cBlack),
                                    borderRadius: BorderRadius.circular(12),
                                    color: cWhite),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12)),
                                        child: Image.network(
                                            "${baseUrl}public/products/${itemProduct.image!}",
                                            height: 100,
                                            width: double.infinity,
                                            fit: BoxFit.contain, errorBuilder:
                                                (context, error, stackTrace) {
                                          return Image.asset(
                                            "assets/images/placeholder.png",
                                            width: 90,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          );
                                        })),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        itemProduct.name!,
                                        style: bold.copyWith(
                                            color: cBlack, fontSize: 15),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        "Rp. ${itemProduct.price}",
                                        style: bold.copyWith(
                                            color: cYellowDark, fontSize: 15),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            cController
                                                .addToCart(CartModel(
                                                  id: itemProduct.id,
                                                  name: itemProduct.name,
                                                  price: itemProduct.price,
                                                  quantity: 1,
                                                  image: itemProduct.image,
                                                  subtotalPerItem:
                                                      itemProduct.price,
                                                ))
                                                .then((value) => Get.to(
                                                    const OrderCartView()));
                                          },
                                          // child: Text("Tambah"),
                                          child: Icon(
                                            Icons.add,
                                            color: cYellowDark,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: cWhite,
                                              foregroundColor: cYellowDark),
                                        ))
                                  ],
                                ),
                              );
                              // ProductCardComponent(
                              //     image: orderC.image[index],
                              //     name: orderC.name[index],
                              //     price: orderC.price[index]);
                            })),
              ],
            )),
      ),
    );
  }
}
