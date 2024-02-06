// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bakmi_jago_app/controllers/cart_controller.dart';
import 'package:bakmi_jago_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bakmi_jago_app/controllers/order_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:bakmi_jago_app/utils/rupiah_utils.dart';

class ItemOrderCartComponent extends StatelessWidget {
  const ItemOrderCartComponent({
    Key? key,
    required this.cartModel,
    required this.itemQuantity,
  }) : super(key: key);

  final CartModel cartModel;
  final int itemQuantity;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
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
                  "${baseUrl}public/products/${cartModel.image!}",
                  // "https://picsum.photos/id/1/200/300",
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
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cartModel.name!,
                        style: bold.copyWith(color: cYellowDark, fontSize: 18),
                      ),
                      Text(
                        RupiahUtils.beRupiah(cartModel.subtotalPerItem!),
                        style:
                            bold.copyWith(color: cYellowPrimary, fontSize: 15),
                      ),
                      Row(children: [
                        GestureDetector(
                          child: const Icon(
                            Icons.remove,
                            color: cYellowDark,
                          ),
                          onTap: () {
                            itemQuantity == 1
                                ? controller.deleteCartItem(cartModel.id!)
                                : controller.decreaseQuantity(cartModel);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(itemQuantity.toString()),
                        ),
                        GestureDetector(
                            child: const Icon(
                              Icons.add,
                              color: cYellowDark,
                            ),
                            onTap: () {
                              controller.increaseQuantity(cartModel);
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
                  controller.deleteCartItem(cartModel.id!);
                  // itemQuantity == 1
                  //     ? controller.deleteCartItem(cartModel.id!)
                  //     : controller.decreaseQuantity(cartModel);
                }),
          ],
        )),
      ),
    );
  }
}
