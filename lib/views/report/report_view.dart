import 'package:bakmi_jago_app/components/list_tile_component.dart';
import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/controllers/report_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/views/report/income/income_report_view.dart';
import 'package:bakmi_jago_app/views/report/outcome/add_outcome_view.dart';
import 'package:bakmi_jago_app/views/report/outcome/outcome_report_view.dart';
import 'package:bakmi_jago_app/views/report/revenue/revenue_report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final reportC = Get.put(ReportController());

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: cWhite,
          title: Text(
            "Laporan Penjualan",
            style: bold.copyWith(fontSize: 25, color: cYellowDark),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTileComponent(
                title: "Laporan Pendapatan",
                desc: "Manu untuk melihat laporan pendapatan",
                onTap: () {
                  Get.to(const IncomeReportView());
                },
              ),
              ListTileComponent(
                title: "Laporan Pengeluaran",
                desc: "Manu untuk melihat laporan pengeluaran",
                onTap: () {
                  Get.to(const OutcomeReportView());
                },
              ),
              ListTileComponent(
                title: "Data User",
                desc: "Manu untuk melihat laporan keuntungan",
                onTap: () {
                  Get.to(const RevenueReportView());
                },
              ),
            ],
          ),
        ));
  }
}
