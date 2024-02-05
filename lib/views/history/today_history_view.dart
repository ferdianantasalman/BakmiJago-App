import 'dart:developer';

import 'package:bakmi_jago_app/components/item_history_component.dart';
import 'package:bakmi_jago_app/models/invoice/invoice_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
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
    log("INVOICE MODEL == ${listInvoiceModelToday}");
    return Scaffold(
      backgroundColor: cWhite,
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: listInvoiceModelToday.isEmpty
                ? const Center(
                    child: Text('Tidak ada Pengajuan'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: listInvoiceModelToday
                          .map((element) => ItemHistoryComponent(
                              invoiceName: element.invoice!,
                              price: element.totalPrice!,
                              totalBarang: element.totalPrice!,
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
