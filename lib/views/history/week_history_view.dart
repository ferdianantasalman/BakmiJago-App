import 'dart:developer';

import 'package:bakmi_jago_app/components/item_history_component.dart';
import 'package:bakmi_jago_app/controllers/order_controller.dart';
import 'package:bakmi_jago_app/models/invoice/invoice_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/history/detail_history_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeekHistoryView extends StatelessWidget {
  const WeekHistoryView({
    super.key,
    required this.listInvoiceModelWeek,
  });

  final List<InvoiceModel> listInvoiceModelWeek;

  @override
  Widget build(BuildContext context) {
    final oController = Get.put(OrderController());

    log("INVOICE MODEL == ${listInvoiceModelWeek}");

    return Scaffold(
      backgroundColor: cWhite,
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: listInvoiceModelWeek.isEmpty
                ? Center(
                    child: Text('Tidak ada riwayat',
                        style: regular.copyWith(
                            fontSize: 15, color: cYellowPrimary)),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: listInvoiceModelWeek
                          .map((element) => ItemHistoryComponent(
                              invoiceName: element.invoice!,
                              price: element.totalPrice!,
                              totalBarang: 3,
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
