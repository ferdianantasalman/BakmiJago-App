import 'package:bakmi_jago_app/controllers/order_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemOrderCartComponent extends StatelessWidget {
  const ItemOrderCartComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final orderC = Get.put(OrderController());
    return SizedBox(
      height: 110,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 2,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(
                  // "$baseUrl/public/${cartModel.image!}",
                  "https://picsum.photos/id/1/200/300",
                  width: 90,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/placeholder.png",
                      width: 90,
                      height: 80,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Nama Produk",
                        style:
                            const TextStyle(color: cYellowDark, fontSize: 20),
                      ),
                      Text(
                        "asdsa",
                        style: const TextStyle(color: cDarkGray, fontSize: 16),
                      ),
                      Row(children: [
                        GestureDetector(
                          child: const Icon(
                            Icons.remove,
                            color: cYellowDark,
                          ),
                          onTap: () {
                            // itemQuantity == 1
                            //     ? controller.deleteCartItem(cartModel.id!)
                            //     : controller.decreaseQuantity(cartModel);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("10"),
                        ),
                        GestureDetector(
                            child: const Icon(
                              Icons.add,
                              color: cYellowDark,
                            ),
                            onTap: () {
                              // controller.increaseQuantity(cartModel);
                            }),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
                icon: const Icon(Icons.delete_outline, color: cYellowDark),
                onPressed: () {
                  // controller.deleteCartItem(cartModel.id!);
                }),
          ],
        )),
      ),
    );
  }
}
