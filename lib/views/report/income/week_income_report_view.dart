import 'dart:developer';

import 'package:bakmi_jago_app/models/income_model.dart';
import 'package:bakmi_jago_app/models/revenue_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeekIncomeReportView extends StatelessWidget {
  const WeekIncomeReportView({
    super.key,
    required this.incomeModel,
  });

  final IncomeModel incomeModel;

  @override
  Widget build(BuildContext context) {
    log("INVOICE MODEL == ${incomeModel}");

    return Scaffold(
      backgroundColor: cWhite,
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Pendapatan Bulan Ini",
                      style: bold.copyWith(fontSize: 22, color: cYellowDark),
                    ),
                  ),
                  Text("Total Pendapatan",
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 5),
                  Text(RupiahUtils.beRupiah(incomeModel.income!),
                      style: bold.copyWith(fontSize: 17, color: cYellowDark)),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )),
    );
  }
}
