// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bakmi_jago_app/models/invoice/invoice_model.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bakmi_jago_app/components/item_card_detail_order.dart';
import 'package:bakmi_jago_app/controllers/order_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';

class DetailHistoryView extends StatelessWidget {
  const DetailHistoryView({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    final oController = Get.put(OrderController(id: id));
    log("id == $id");
    oController.getDetailOrderByInvoice(id);
    log("model == ${oController.listOrderModelInvoice}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        foregroundColor: cYellowDark,
        title: Text(
          "Detail Riwayat",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      backgroundColor: cWhite,
      body: Obx(() => oController.isLoading.value
          ? const Center(child: CircularProgressIndicator(color: cYellowDark))
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: oController.listOrderModelInvoice.isEmpty
                  ? const Center(
                      child: Text('Tidak ada Pengajuan'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: oController.listOrderModelInvoice
                            .map((element) =>
                                ItemCardDetailOrder(orderModel: element))
                            .toList(),
                      ),
                    ),
            )),
    );
  }
}
