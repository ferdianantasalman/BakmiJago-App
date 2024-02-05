import 'package:bakmi_jago_app/components/button_component.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/utils/rupiah_utils.dart';
import 'package:bakmi_jago_app/views/history/history_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemHistoryComponent extends StatelessWidget {
  const ItemHistoryComponent({
    super.key,
    required this.price,
    required this.invoiceName,
    required this.totalBarang,
    required this.onTap,
  });

  final int price;
  final String invoiceName;
  final int totalBarang;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: [
          Column(
            children: [
              const Icon(
                Icons.shopping_bag,
                color: cYellowDark,
                size: 80,
              ),
              Text(
                "Total Harga",
                style: bold.copyWith(color: cYellowDark, fontSize: 17),
              ),
              Text(
                RupiahUtils.beRupiah(price),
                style: regular.copyWith(color: cYellowDark, fontSize: 15),
              )
            ],
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 190,
            height: 100,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                invoiceName,
                style: bold.copyWith(color: cYellowDark, fontSize: 15),
              ),
              // const SizedBox(height: 3),
              // Text(
              //   "$totalBarang barang",
              //   style: regular.copyWith(color: cYellowPrimary, fontSize: 15),
              // ),
              const SizedBox(height: 3),
              ButtonComponent("Detail", onPressed: onTap, color: cYellowDark)
            ]),
          )
        ]),
      ),
    );
  }
}
