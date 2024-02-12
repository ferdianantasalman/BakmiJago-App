import 'dart:developer';

import 'package:bakmi_jago_app/components/item_history_component.dart';
import 'package:bakmi_jago_app/controllers/order_controller.dart';
import 'package:bakmi_jago_app/models/invoice/invoice_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/history/detail_history_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayHistoryView extends StatelessWidget {
  const TodayHistoryView({
    super.key,
    required this.listInvoiceModelToday,
  });

  final List<InvoiceModel> listInvoiceModelToday;

  @override
  Widget build(BuildContext context) {
    final oController = Get.put(OrderController());
    log("INVOICE MODEL == ${listInvoiceModelToday}");
    return Scaffold(
      backgroundColor: cWhite,
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: listInvoiceModelToday.isEmpty
                ? Center(
                    child: Text('Tidak ada riwayat',
                        style: regular.copyWith(
                            fontSize: 15, color: cYellowPrimary)),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: listInvoiceModelToday
                          .map((element) => ItemHistoryComponent(
                              invoiceName: element.invoice!,
                              price: element.totalPrice!,
                              totalBarang: element.totalPrice!,
                              onTap: () async {
                                await oController
                                    .getDetailOrderByInvoice(element.id!);

                                // print(element.id);
                                Get.to(DetailHistoryView(
                                    listOrderModelInvoice:
                                        oController.listOrderModelInvoice));
                              }))
                          .toList(),
                    ),
                  ),
          )),
    );
  }
}
