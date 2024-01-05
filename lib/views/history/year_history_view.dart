import 'package:bakmi_jago_app/components/item_history_component.dart';
import 'package:bakmi_jago_app/controllers/history_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/views/history/detail_history_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YearHistoryView extends StatelessWidget {
  const YearHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyC = Get.put(HistoryController());

    return Scaffold(
      backgroundColor: cWhite,
      body: Obx(() => historyC.isLoading.value
          ? const Center(child: CircularProgressIndicator(color: cYellowDark))
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: historyC.name.isEmpty
                  ? const Center(
                      child: Text('Tidak ada Pengajuan'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: historyC.name
                            .map((element) => ItemHistoryComponent(
                                invoiceName: "INV-1",
                                price: 30000,
                                totalBarang: 3,
                                onTap: () {
                                  Get.to(const DetailHistoryView());
                                }))
                            .toList(),
                      ),
                    ),
            )),
    );
  }
}
