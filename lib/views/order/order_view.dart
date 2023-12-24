import 'package:bakmi_jago_app/components/product_card_component.dart';
import 'package:bakmi_jago_app/controllers/order_controller.dart';
import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/models/order_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/order/order_cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final orderC = Get.put(OrderController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        title: Text(
          "Pesanan",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Obx(() => GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orderC.name.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        mainAxisExtent: 220),
                    itemBuilder: (context, index) {
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
                                child: Image.network(orderC.image[index],
                                    width: double.infinity, fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
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
                                orderC.name[index],
                                style:
                                    bold.copyWith(color: cBlack, fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                "Rp. ${orderC.price[index]}",
                                style: bold.copyWith(
                                    color: cYellowDark, fontSize: 15),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(2),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // orderC
                                    //     .addToCart(CartModel(
                                    //         id: stockModel.id,
                                    //         name: stockModel.name,
                                    //         price: stockModel.price!,
                                    //         quantity: 1,
                                    //         image: stockModel.image!,
                                    //         subtotalPerItem: stockModel.price!,
                                    //         tax: (stockModel.price! * 10 / 100)
                                    //             .round()))
                                    //     .then((value) =>
                                    //         Get.off(const OrderCartView()));
                                    Get.to(const OrderCartView());
                                  },
                                  child: Text("Tambah"),
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
