import 'package:bakmi_jago_app/components/button_component.dart';
import 'package:bakmi_jago_app/components/text_field_outline_large_component.dart';
import 'package:bakmi_jago_app/components/text_field_outlined_component.dart';
import 'package:bakmi_jago_app/controllers/outcome_controller.dart';
import 'package:bakmi_jago_app/models/report_model.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOutcomeView extends StatelessWidget {
  const AddOutcomeView({
    super.key,
    this.isEdit = false,
    this.reportModel,
  });

  final bool isEdit;
  final ReportModel? reportModel;

  @override
  Widget build(BuildContext context) {
    final outcomeC = Get.put(OutcomeController());
    if (isEdit == false) {
      outcomeC.nameController.value.clear();
      outcomeC.priceController.value.clear();
      outcomeC.descController.value.clear();
    }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Nama Pengeluaran",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    hintText: "Nama Pengeluaran",
                    textController: outcomeC.nameController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                // DateTimeFieldComponent(
                //     controller: outcomeC.dateController.value,
                //     hintText: "Tanggal Pengeluaran",
                //     obsecureText: false),
                // const SizedBox(
                //   height: 20,
                // ),
                Text("Jumlah Pengeluaran",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedComponent(
                    hintText: "Jumlah Pengeluaran",
                    textController: outcomeC.priceController.value,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 10),
                Text("Keterangan Pengeluaran",
                    style: regular.copyWith(color: cDarkYellow)),
                const SizedBox(height: 5),
                TextFieldOutlinedLargeComponent(
                    hintText: "Keterangan",
                    textController: outcomeC.descController.value,
                    keyboardType: TextInputType.text),
                const SizedBox(height: 10),
                Center(
                  child: ButtonComponent(
                    "Kirim Berkas",
                    onPressed: () async {
                      var res = false;
                      if (!isEdit) {
                        res = await outcomeC.addReports();
                      } else {
                        res = await outcomeC.editReports(reportModel!);
                      }
                      Navigator.pop(context, res);
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
