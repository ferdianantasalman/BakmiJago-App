import 'dart:developer';

import 'package:bakmi_jago_app/components/item_report_component.dart';
import 'package:bakmi_jago_app/controllers/outcome_controller.dart';
import 'package:bakmi_jago_app/models/outcome_model.dart';
import 'package:bakmi_jago_app/models/report_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/utils/rupiah_utils.dart';
import 'package:bakmi_jago_app/views/report/outcome/add_outcome_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeekOutcomeReportView extends StatelessWidget {
  const WeekOutcomeReportView({
    super.key,
    required this.outcomeModel,
    required this.listReportModel,
  });

  final OutcomeModel outcomeModel;
  final List<ReportModel> listReportModel;

  @override
  Widget build(BuildContext context) {
    final outcomeC = Get.put(OutcomeController());

    log("OUTCOME MODEL == $outcomeModel");
    log("LIST REPORT MODEL == $listReportModel");

    return Scaffold(
      backgroundColor: cWhite,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var res = await Get.to(AddOutcomeView());

          if (res is bool) {
            if (res) {
              await outcomeC.getReportsToday();
              await outcomeC.getReportsWeek();
              await outcomeC.getReportsMonth();
              await outcomeC.getOutcomeToday;
              await outcomeC.getOutcomeWeek;
              await outcomeC.getOutcomeMonth;
            }
          }
        },
        backgroundColor: cYellowDark,
        child: const Icon(Icons.add),
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Pengeluaran Bulan Ini",
                      style: bold.copyWith(fontSize: 22, color: cYellowDark),
                    ),
                  ),
                  Text("Total Pengeluaran",
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 5),
                  Text(RupiahUtils.beRupiah(outcomeModel.outcome!),
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 15),
                  Text("Daftar Pengeluaran",
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 5),
                  listReportModel.isEmpty
                      ? const Center(
                          child: Text('Tidak ada Pengajuan'),
                        )
                      : Column(
                          children: listReportModel
                              .map((element) =>
                                  ItemReportComponent(reportModel: element))
                              .toList()),
                ],
              ),
            ),
          )),
    );
  }
}