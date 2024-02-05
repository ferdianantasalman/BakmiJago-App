import 'dart:developer';

import 'package:bakmi_jago_app/components/item_history_component.dart';
import 'package:bakmi_jago_app/models/invoice/invoice_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
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

    log("INVOICE MODEL == ${listInvoiceModelWeek}");

    return Scaffold(
      backgroundColor: cWhite,
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: listInvoiceModelWeek.isEmpty
                ? const Center(
                    child: Text('Tidak ada Pengajuan'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: listInvoiceModelWeek
                          .map((element) => ItemHistoryComponent(
                              invoiceName: element.invoice!,
                              price: element.totalPrice!,
                              totalBarang: 3,
                              onTap: () {
                                Get.to(DetailHistoryView(id: element.id!));
                              }))
                          .toList(),
                    ),
                  ),
          )),
    );
  }
}
