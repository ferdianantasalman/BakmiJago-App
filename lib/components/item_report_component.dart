// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bakmi_jago_app/controllers/cart_controller.dart';
import 'package:bakmi_jago_app/models/cart_model.dart';
import 'package:bakmi_jago_app/models/report_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bakmi_jago_app/controllers/order_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:bakmi_jago_app/utils/rupiah_utils.dart';

class ItemReportComponent extends StatelessWidget {
  const ItemReportComponent({Key? key, required this.reportModel, this.onTap})
      : super(key: key);

  final ReportModel reportModel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 110,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 2,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  reportModel.name!,
                  style: bold.copyWith(color: cYellowPrimary, fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  RupiahUtils.beRupiah(reportModel.price!),
                  style: regular.copyWith(color: cYellowPrimary, fontSize: 15),
                ),
                const SizedBox(height: 5),
                Text(
                  reportModel.keterangan!,
                  style: bold.copyWith(color: cYellowPrimary, fontSize: 20),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
