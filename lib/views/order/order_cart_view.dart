import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bakmi_jago_app/components/button_component.dart';
import 'package:bakmi_jago_app/components/icon_button_component.dart';
import 'package:bakmi_jago_app/components/invoice_component.dart';
import 'package:bakmi_jago_app/components/item_order_cart_component.dart';
import 'package:bakmi_jago_app/components/text_field_outlined_component.dart';
import 'package:bakmi_jago_app/controllers/order_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';

class OrderCartView extends StatefulWidget {
  const OrderCartView({super.key});

  @override
  State<OrderCartView> createState() => _OrderCartViewState();
}

class _OrderCartViewState extends State<OrderCartView> {
  Uint8List? bytes;

  // Bluetooth Printer
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _devices = [];
  String _devicesMsg = "";

  final List<Map<String, dynamic>> data = [
    {'title': 'Bakmi Ayam', 'price': 20000, 'qty': 2},
    {'title': 'Bakmi Sapi', 'price': 30000, 'qty': 2},
    {'title': 'Air Putih', 'price': 1000, 'qty': 2},
    {'title': 'Es Teh', 'price': 4000, 'qty': 2},
    {'title': 'Krupuk', 'price': 1000, 'qty': 2},
  ];

  final f = NumberFormat("\$###,###.00", "en_US");

  @override
  void initState() {
    super.initState();

    loadImageInvoice();

    WidgetsBinding.instance.addPostFrameCallback((_) => {initPrinter()});
  }

  @override
  Widget build(BuildContext context) {
    final appDocumentsDire = getApplicationDocumentsDirectory();

    final orderC = Get.put(OrderController());
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        foregroundColor: cYellowDark,
        title: Text(
          "Pesanan",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      body: Obx(() => orderC.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: cPrimaryGreen,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: orderC.name.isEmpty
                  ? const Center(
                      child: Text('Tidak ada Laporan'),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: orderC.name.length,
                      itemBuilder: (context, index) {
                        return ItemOrderCartComponent();
                      }))),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(10),
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Total",
                textAlign: TextAlign.center,
                style: bold.copyWith(fontSize: 20, color: cYellowDark)),
            const SizedBox(height: 5),
            Text(RupiahUtils.beRupiah(50000 + 50000),
                textAlign: TextAlign.center,
                style: bold.copyWith(fontSize: 17, color: cYellowLight)),
            const SizedBox(height: 10),
            Text("Pilih Pembayaran",
                textAlign: TextAlign.center,
                style: bold.copyWith(fontSize: 20, color: cYellowDark)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButtonComponent(
                  "Tunai",
                  onPressed: () {
                    // orderC.addOrders();
                    Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 350,
                        height: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pembayaran Tunai",
                                style: bold.copyWith(
                                    fontSize: 20, color: cYellowDark)),
                            const SizedBox(height: 15),
                            TextFieldOutlinedComponent(
                                hintText: "Uang diterima",
                                textController:
                                    orderC.inputCashController.value,
                                keyboardType: TextInputType.number),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(cYellowDark),
                                    side: MaterialStatePropertyAll(
                                      BorderSide(color: cYellowDark),
                                    ),
                                  ),
                                  child: Text("Batal",
                                      style: regular.copyWith(
                                          fontSize: 15, color: cYellowDark)),
                                ),
                                const SizedBox(width: 10),
                                OutlinedButton(
                                  onPressed: () {
                                    Get.dialog(Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: 350,
                                        height: 400,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text("Pembayaran Berhasil",
                                                  style: bold.copyWith(
                                                      fontSize: 20,
                                                      color: cYellowDark)),
                                            ),
                                            const SizedBox(height: 30),
                                            Text("Metode Pembayaran",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("Tunai",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 15),
                                            Text("Total Pembelian",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("Rp. 50000",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 15),
                                            Text("Nominal Bayar",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("Rp. 50000",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 15),
                                            Text("Waktu Pembayaran",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("12 Desember",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 25),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            cYellowDark),
                                                    side:
                                                        MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: cYellowDark),
                                                    ),
                                                  ),
                                                  child: Text("Selesai",
                                                      style: regular.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () async {
                                                    final controller =
                                                        ScreenshotController();
                                                    final bytes = await controller
                                                        .captureFromWidget(Material(
                                                            child:
                                                                invoiceCard()));

                                                    setState(() {
                                                      this.bytes = bytes;
                                                    });

                                                    // saveImageInvoice(bytes);

                                                    Get.dialog(Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        // height: 500,
                                                        child: Column(
                                                          children: [
                                                            Text("Nota Pesanan",
                                                                style: bold.copyWith(
                                                                    fontSize:
                                                                        20,
                                                                    color:
                                                                        cYellowDark)),
                                                            const SizedBox(
                                                                height: 10),
                                                            if (this.bytes !=
                                                                null)
                                                              Image.memory(
                                                                  this.bytes!),
                                                            // Image.network(
                                                            //   "https://www.w3schools.com/w3images/avatar2.png",
                                                            //   width: 300,
                                                            //   height: 280,
                                                            // ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  style:
                                                                      const ButtonStyle(
                                                                    foregroundColor:
                                                                        MaterialStatePropertyAll(
                                                                            cYellowDark),
                                                                    side:
                                                                        MaterialStatePropertyAll(
                                                                      BorderSide(
                                                                          color:
                                                                              cYellowDark),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                      "Kembali",
                                                                      style: regular.copyWith(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              cYellowDark)),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    // log("https://www.w3schools.com/w3images/avatar2.png");
                                                                    // FileDownloader.downloadFile(
                                                                    //     url: "https://www.w3schools.com/w3images/avatar2.png",
                                                                    //     onProgress: (name, progress) {
                                                                    //       log("Download Nota");
                                                                    //     },
                                                                    //     onDownloadCompleted: (value) {
                                                                    //       log("Download Succes");
                                                                    //       Get.snackbar(
                                                                    //           "Download Berhasil",
                                                                    //           "Cek Pada Folder Download File Manager");
                                                                    //     });
                                                                    saveImageInvoice(
                                                                        bytes);
                                                                    // log("$bytes");
                                                                    Get.snackbar(
                                                                        "Download Berhasil",
                                                                        "Cek Pada");
                                                                  },
                                                                  style:
                                                                      const ButtonStyle(
                                                                    foregroundColor:
                                                                        MaterialStatePropertyAll(
                                                                            cYellowDark),
                                                                    side:
                                                                        MaterialStatePropertyAll(
                                                                      BorderSide(
                                                                          color:
                                                                              cYellowDark),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                      "Download",
                                                                      style: regular.copyWith(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              cYellowDark)),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                                  },
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            cYellowDark),
                                                    side:
                                                        MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: cYellowDark),
                                                    ),
                                                  ),
                                                  child: Text("Lihat Nota",
                                                      style: regular.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Get.dialog(Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          width: 350,
                                                          height: 400,
                                                          child:
                                                              _devices.isEmpty
                                                                  ? Center(
                                                                      child: Text(
                                                                          _devicesMsg ??
                                                                              ''),
                                                                    )
                                                                  : ListView
                                                                      .builder(
                                                                      itemCount:
                                                                          _devices
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return ListTile(
                                                                          leading:
                                                                              Icon(Icons.print),
                                                                          title:
                                                                              Text(_devices[index].name!),
                                                                          subtitle:
                                                                              Text(_devices[index].address!),
                                                                          onTap:
                                                                              () {
                                                                            _startPrint(_devices[index]);
                                                                          },
                                                                        );
                                                                      },
                                                                    )),
                                                    ));
                                                  },
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            cYellowDark),
                                                    side:
                                                        MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: cYellowDark),
                                                    ),
                                                  ),
                                                  child: Text("Print",
                                                      style: regular.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                                  },
                                  style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(cYellowDark),
                                    side: MaterialStatePropertyAll(
                                      BorderSide(color: cYellowDark),
                                    ),
                                  ),
                                  child: Text("Proses",
                                      style: regular.copyWith(
                                          fontSize: 15, color: cYellowDark)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
                  },
                  color: cYellowDark,
                  icon: const Icon(Icons.attach_money),
                ),
                const SizedBox(width: 10),
                IconButtonComponent(
                  "QRIS",
                  onPressed: () {
                    Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 350,
                        height: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pembayaran QRIS",
                                style: bold.copyWith(
                                    fontSize: 20, color: cYellowDark)),
                            const SizedBox(height: 8),
                            Image.asset(
                              "assets/images/qrcode.jpg",
                              width: 300,
                              height: 280,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(cYellowDark),
                                    side: MaterialStatePropertyAll(
                                      BorderSide(color: cYellowDark),
                                    ),
                                  ),
                                  child: Text("Batal",
                                      style: regular.copyWith(
                                          fontSize: 15, color: cYellowDark)),
                                ),
                                const SizedBox(width: 10),
                                OutlinedButton(
                                  onPressed: () {
                                    Get.dialog(Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: 350,
                                        height: 400,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text("Pembayaran Berhasil",
                                                  style: bold.copyWith(
                                                      fontSize: 20,
                                                      color: cYellowDark)),
                                            ),
                                            const SizedBox(height: 30),
                                            Text("Metode Pembayaran",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("Tunai",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 15),
                                            Text("Total Pembelian",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("Rp. 50000",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 15),
                                            Text("Nominal Bayar",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("Rp. 50000",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 15),
                                            Text("Waktu Pembayaran",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowDark)),
                                            const SizedBox(height: 10),
                                            Text("12 Desember",
                                                style: bold.copyWith(
                                                    fontSize: 15,
                                                    color: cYellowLight)),
                                            const SizedBox(height: 25),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            cYellowDark),
                                                    side:
                                                        MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: cYellowDark),
                                                    ),
                                                  ),
                                                  child: Text("Selesai",
                                                      style: regular.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () async {
                                                    final controller =
                                                        ScreenshotController();
                                                    final bytes = await controller
                                                        .captureFromWidget(Material(
                                                            child:
                                                                invoiceCard()));

                                                    setState(() {
                                                      this.bytes = bytes;
                                                    });

                                                    // saveImageInvoice(bytes);

                                                    Get.dialog(Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        // height: 500,
                                                        child: Column(
                                                          children: [
                                                            Text("Nota Pesanan",
                                                                style: bold.copyWith(
                                                                    fontSize:
                                                                        20,
                                                                    color:
                                                                        cYellowDark)),
                                                            const SizedBox(
                                                                height: 10),
                                                            if (this.bytes !=
                                                                null)
                                                              Image.memory(
                                                                  this.bytes!),
                                                            // Image.network(
                                                            //   "https://www.w3schools.com/w3images/avatar2.png",
                                                            //   width: 300,
                                                            //   height: 280,
                                                            // ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  style:
                                                                      const ButtonStyle(
                                                                    foregroundColor:
                                                                        MaterialStatePropertyAll(
                                                                            cYellowDark),
                                                                    side:
                                                                        MaterialStatePropertyAll(
                                                                      BorderSide(
                                                                          color:
                                                                              cYellowDark),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                      "Kembali",
                                                                      style: regular.copyWith(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              cYellowDark)),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    // log("https://www.w3schools.com/w3images/avatar2.png");
                                                                    // FileDownloader.downloadFile(
                                                                    //     url: "https://www.w3schools.com/w3images/avatar2.png",
                                                                    //     onProgress: (name, progress) {
                                                                    //       log("Download Nota");
                                                                    //     },
                                                                    //     onDownloadCompleted: (value) {
                                                                    //       log("Download Succes");
                                                                    //       Get.snackbar(
                                                                    //           "Download Berhasil",
                                                                    //           "Cek Pada Folder Download File Manager");
                                                                    //     });
                                                                    saveImageInvoice(
                                                                        bytes);
                                                                    // log("$bytes");
                                                                    Get.snackbar(
                                                                        "Download Berhasil",
                                                                        "Cek Pada");
                                                                  },
                                                                  style:
                                                                      const ButtonStyle(
                                                                    foregroundColor:
                                                                        MaterialStatePropertyAll(
                                                                            cYellowDark),
                                                                    side:
                                                                        MaterialStatePropertyAll(
                                                                      BorderSide(
                                                                          color:
                                                                              cYellowDark),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                      "Download",
                                                                      style: regular.copyWith(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              cYellowDark)),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                                  },
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            cYellowDark),
                                                    side:
                                                        MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: cYellowDark),
                                                    ),
                                                  ),
                                                  child: Text("Lihat Nota",
                                                      style: regular.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Get.dialog(Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          width: 350,
                                                          height: 400,
                                                          child:
                                                              _devices.isEmpty
                                                                  ? Center(
                                                                      child: Text(
                                                                          _devicesMsg ??
                                                                              ''),
                                                                    )
                                                                  : ListView
                                                                      .builder(
                                                                      itemCount:
                                                                          _devices
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return ListTile(
                                                                          leading:
                                                                              Icon(Icons.print),
                                                                          title:
                                                                              Text(_devices[index].name!),
                                                                          subtitle:
                                                                              Text(_devices[index].address!),
                                                                          onTap:
                                                                              () {
                                                                            _startPrint(_devices[index]);
                                                                          },
                                                                        );
                                                                      },
                                                                    )),
                                                    ));
                                                  },
                                                  style: const ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStatePropertyAll(
                                                            cYellowDark),
                                                    side:
                                                        MaterialStatePropertyAll(
                                                      BorderSide(
                                                          color: cYellowDark),
                                                    ),
                                                  ),
                                                  child: Text("Print",
                                                      style: regular.copyWith(
                                                          fontSize: 15,
                                                          color: cYellowDark)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                                  },
                                  style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(cYellowDark),
                                    side: MaterialStatePropertyAll(
                                      BorderSide(color: cYellowDark),
                                    ),
                                  ),
                                  child: Text("Proses",
                                      style: regular.copyWith(
                                          fontSize: 15, color: cYellowDark)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
                  },
                  color: cYellowDark,
                  icon: const Icon(Icons.qr_code_scanner_outlined),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future loadImageInvoice() async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final file = File('${appDocumentsDir.path}/image.png');
    if (file.existsSync()) {
      final bytes = await file.readAsBytes();

      setState(() {
        this.bytes = bytes;
      });
    }
  }

  Future saveImageInvoice(Uint8List bytes) async {
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    final file = File('${appDocumentsDir.path}/image.png');
    file.writeAsBytes(bytes);

    log("PATH => ${appDocumentsDir.path}");
    log("File => $file");
  }

  // ========= Bluetooth Printer ===========
  Future<void> _startPrint(BluetoothDevice device) async {
    if (device != null && device.address != null) {
      await bluetoothPrint.connect(device);

      Map<String, dynamic> config = Map();
      List<LineText> list = [];

      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: "Bakmi Jago",
          weight: 2,
          width: 2,
          height: 2,
          align: LineText.ALIGN_CENTER,
          linefeed: 1,
        ),
      );

      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: "Jl. Lawanggada No. 12, Cirebon",
          weight: 1,
          width: 1,
          height: 1,
          align: LineText.ALIGN_CENTER,
          linefeed: 1,
        ),
      );

      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: "12 Desember 2023 - 22.00",
          weight: 1,
          width: 1,
          height: 1,
          align: LineText.ALIGN_CENTER,
          linefeed: 1,
        ),
      );

      for (var i = 0; i < data.length; i++) {
        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: data[i]['title'],
            weight: 0,
            align: LineText.ALIGN_LEFT,
            linefeed: 1,
          ),
        );

        list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content:
                "${RupiahUtils.beRupiah(data[i]['price'])} x ${data[i]['qty']}",
            align: LineText.ALIGN_LEFT,
            linefeed: 1,
          ),
        );
      }
    }
  }

  Future<void> initPrinter() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 2));

    if (!mounted) return;
    bluetoothPrint.scanResults.listen(
      (val) {
        if (!mounted) return;
        setState(() => {_devices = val});
        if (_devices.isEmpty)
          setState(() {
            _devicesMsg = "No Devices";
          });
      },
    );
  }

// void showDialog() {
//   Get.dialog(Dialog());
// }
}
