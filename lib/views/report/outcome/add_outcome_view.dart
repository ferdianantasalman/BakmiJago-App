import 'dart:io';

import 'package:bakmi_jago_app/components/button_component.dart';
import 'package:bakmi_jago_app/components/date_field_component.dart';
import 'package:bakmi_jago_app/components/text_field_outline_large_component.dart';
import 'package:bakmi_jago_app/components/text_field_outlined_component.dart';
import 'package:bakmi_jago_app/controllers/product_controller.dart';
import 'package:bakmi_jago_app/controllers/report.controller.dart';
import 'package:bakmi_jago_app/controllers/select_image_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/constant.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';

class AddOutcomeView extends StatelessWidget {
  const AddOutcomeView({
    super.key,
    this.isEdit = false,
    // this.sphData,
  });

  final bool isEdit;
  // final Datas? sphData;

  @override
  Widget build(BuildContext context) {
    final rController = Get.put(ReportController());
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        foregroundColor: cYellowDark,
        title: Text(
          isEdit ? "Edit Pengeluaran" : "Tambah Pengeluaran",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              children: [
                TextFieldOutlinedComponent(
                    hintText: "Nama Pengeluaran",
                    textController: rController.nameController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                DateTimeFieldComponent(
                    controller: rController.dateController.value,
                    hintText: "Tanggal Pengeluaran",
                    obsecureText: false),
                const SizedBox(
                  height: 20,
                ),
                TextFieldOutlinedComponent(
                    hintText: "Jumlah Pengeluaran",
                    textController: rController.totalController.value,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                TextFieldOutlinedLargeComponent(
                    hintText: "Keterangan",
                    textController: rController.descController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Center(
                  child: ButtonComponent(
                    "Kirim Berkas",
                    onPressed: () async {
                      // var res = false;
                      // if (!isEdit) {
                      //   res =
                      //       await controller.addSphMarketing();
                      // } else {
                      //   res = await controller
                      //       .editSphMarketing(sphData!);
                      // }
                      // Navigator.pop(context, res);
                    },
                    color: cYellowDark,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
