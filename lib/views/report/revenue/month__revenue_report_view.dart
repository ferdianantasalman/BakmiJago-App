import 'dart:developer';

import 'package:bakmi_jago_app/models/revenue_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthRevenueReportView extends StatelessWidget {
  const MonthRevenueReportView({
    super.key,
    required this.revenueModel,
  });

  final RevenueModel revenueModel;

  @override
  Widget build(BuildContext context) {
    log("INVOICE MODEL == ${revenueModel}");

    return Scaffold(
      backgroundColor: cWhite,
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Keuntungan Bulan Ini",
                      style: bold.copyWith(fontSize: 22, color: cYellowDark),
                    ),
                  ),
                  Text("Total Pendapatan",
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 5),
                  Text(RupiahUtils.beRupiah(revenueModel.income!),
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 10),
                  Text("Total Pengeluaran",
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 5),
                  Text(RupiahUtils.beRupiah(revenueModel.outcome!),
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 10),
                  Text("Total Keuntungan",
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 5),
                  Text(RupiahUtils.beRupiah(revenueModel.revenue!),
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )),
    );
  }
}
