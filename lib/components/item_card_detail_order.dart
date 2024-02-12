import 'package:bakmi_jago_app/components/image_component.dart';
import 'package:bakmi_jago_app/models/order_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';

class ItemCardDetailOrder extends StatelessWidget {
  const ItemCardDetailOrder({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: orderModel.product!.name ?? "Error",
                    style: bold.copyWith(color: cYellowDark, fontSize: 17))),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageComponent(
                    source:
                        "${baseUrl}public/products/${orderModel.product!.image}"),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(orderModel.product?.code ?? "Error",
                        style: bold.copyWith(color: cYellowDark, fontSize: 20)),
                    const SizedBox(height: 8),
                    Text(
                      "${orderModel.qty} pcs",
                      style: bold.copyWith(color: cYellowPrimary, fontSize: 16),
                    ),
                    // RichText(
                    //     maxLines: 3,
                    //     overflow: TextOverflow.ellipsis,
                    //     text: TextSpan(
                    //         text: orderModel.product!.name ?? "Error",
                    //         style: bold.copyWith(
                    //             color: cYellowDark, fontSize: 17))),
                    // Text(orderModel.product!.name ?? "Error",
                    //     // maxLines: 4,
                    //     overflow: TextOverflow.visible,
                    //     style: bold.copyWith(color: cYellowDark, fontSize: 17)),
                    const SizedBox(height: 8),
                    Text(
                      RupiahUtils.beRupiah(orderModel.product?.price ?? 0),
                      style: bold.copyWith(color: cYellowPrimary, fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
