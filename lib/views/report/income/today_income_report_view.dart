import 'dart:developer';

import 'package:bakmi_jago_app/models/income_model.dart';
import 'package:bakmi_jago_app/models/revenue_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayIncomeReportView extends StatelessWidget {
  const TodayIncomeReportView({
    super.key,
    required this.incomeModel,
  });

  final String incomeModel;

  @override
  Widget build(BuildContext context) {
    log("INVOICE MODEL MAKAN == ${incomeModel}");

    return Scaffold(
        backgroundColor: cWhite,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Pendapatan Hari Ini",
                    style: bold.copyWith(fontSize: 22, color: cYellowDark),
                  ),
                ),
                const SizedBox(height: 20),
                Text("Total Pendapatan",
                    style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                const SizedBox(height: 5),
                Text(RupiahUtils.beRupiah(int.parse(incomeModel) ?? 5000),
                    style: bold.copyWith(fontSize: 17, color: cYellowPrimary)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }
}
