import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bakmi_jago_app/components/button_component.dart';
import 'package:bakmi_jago_app/components/icon_button_component.dart';
import 'package:bakmi_jago_app/components/invoice_component.dart';
import 'package:bakmi_jago_app/components/item_order_cart_component.dart';
import 'package:bakmi_jago_app/components/text_field_outlined_component.dart';
import 'package:bakmi_jago_app/controllers/order_controller.dart';
import 'package:bakmi_jago_app/controllers/cart_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:bakmi_jago_app/utils/rupiah_utils.dart';
import 'package:bakmi_jago_app/views/order/order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class OrderCartView extends StatefulWidget {
  const OrderCartView({super.key});

  @override
  State<OrderCartView> createState() => _OrderCartViewState();
}

class _OrderCartViewState extends State<OrderCartView> {
  Uint8List? bytes;

  // Bluetooth Printer
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  Widget build(BuildContext context) {
    final appDocumentsDire = getApplicationDocumentsDirectory();
    final cartC = Get.put(CartController());
    final orderC = Get.put(OrderController());
    cartC.getCartItems();
    cartC.getItemSubtotal();
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        foregroundColor: cYellowDark,
        title: Text(
          "Keranjang",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      body: Obx(() => cartC.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: cPrimaryGreen,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: cartC.cartItems.isEmpty
                  ? const Center(
                      child: Text('Tidak ada Laporan'),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: cartC.cartItems.length,
                      itemBuilder: (context, index) {
                        var itemCart = cartC.cartItems[index];
                        return ItemOrderCartComponent(
                          cartModel: itemCart,
                          itemQuantity: itemCart.quantity!,
                        );
                      }))),
      bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.all(10),
          height: 170,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Total",
                    textAlign: TextAlign.center,
                    style: bold.copyWith(fontSize: 20, color: cYellowDark)),
                const SizedBox(height: 5),
                Text(RupiahUtils.beRupiah(cartC.subtotal.toInt()),
                    textAlign: TextAlign.center,
                    style: bold.copyWith(fontSize: 17, color: cYellowPrimary)),
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
                                            MaterialStatePropertyAll(
                                                cYellowDark),
                                        side: MaterialStatePropertyAll(
                                          BorderSide(color: cYellowDark),
                                        ),
                                      ),
                                      child: Text("Batal",
                                          style: regular.copyWith(
                                              fontSize: 15,
                                              color: cYellowDark)),
                                    ),
                                    const SizedBox(width: 10),
                                    OutlinedButton(
                                      style: const ButtonStyle(
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                                cYellowDark),
                                        side: MaterialStatePropertyAll(
                                          BorderSide(color: cYellowDark),
                                        ),
                                      ),
                                      child: Text("Proses",
                                          style: regular.copyWith(
                                              fontSize: 15,
                                              color: cYellowDark)),
                                      onPressed: () async {
                                        if (orderC.inputCashController.value
                                            .text.isEmpty) {
                                          Get.snackbar("Kesalahan",
                                              "Harap masukkan nilai pembayaran");
                                        }
                                        if (orderC.inputCashController.value
                                            .text.isNotEmpty) {
                                          await orderC
                                              .addOrders(cartC.cartItems);
                                        }
                                        // var res = true;
                                        // if (res is bool) {
                                        //   if (res) {
                                        //     Get.snackbar("Berhasil",
                                        //         "Transaksi berhasil");
                                        //   }
                                        // } else {
                                        //   Get.snackbar(
                                        //       "Gagal", "Transaksi gagal");
                                        // }
                                        log("cartItems ${cartC.cartItems}");
                                        Navigator.pop(context, true);

                                        Get.dialog(Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            width: 350,
                                            height: 450,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Text(
                                                      "Pembayaran Berhasil",
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
                                                        color: cYellowPrimary)),
                                                const SizedBox(height: 15),
                                                Text("Total Pembelian",
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowDark)),
                                                const SizedBox(height: 10),
                                                Text(
                                                    RupiahUtils.beRupiah(
                                                        cartC.subtotal.toInt()),
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowPrimary)),
                                                const SizedBox(height: 15),
                                                Text("Nominal Bayar",
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowDark)),
                                                const SizedBox(height: 10),
                                                Text(
                                                    RupiahUtils.beRupiah(int.parse(
                                                        "${orderC.inputCashController.value.text}")),
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowPrimary)),
                                                const SizedBox(height: 15),
                                                Text("Kembalian",
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowDark)),
                                                const SizedBox(height: 10),
                                                Text(
                                                    RupiahUtils.beRupiah(int.parse(
                                                            "${orderC.inputCashController.value.text}") -
                                                        cartC.subtotal.toInt()),
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowPrimary)),
                                                const SizedBox(height: 15),
                                                Text("Waktu Pembayaran",
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowDark)),
                                                const SizedBox(height: 10),
                                                Text(
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(DateTime.now()),
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowPrimary)),
                                                const SizedBox(height: 25),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, true);
                                                        Get.off(OrderView());
                                                        orderC
                                                            .inputCashController
                                                            .value
                                                            .clear();
                                                        cartC.deleteAllData();
                                                      },
                                                      style: const ButtonStyle(
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
                                                      child: Text("Selesai",
                                                          style: regular.copyWith(
                                                              fontSize: 15,
                                                              color:
                                                                  cYellowDark)),
                                                    ),
                                                    OutlinedButton(
                                                      onPressed: () async {
                                                        // orderC
                                                        //     .inputCashController
                                                        //     .value
                                                        //     .clear();
                                                        if ((await printer
                                                            .isConnected)!) {
                                                          // SIZE
                                                          //0: Normal, 1:nORMAL-Bold, 2:Medium-Bold, 3:Large-Bold
                                                          // ALIGN
                                                          //0: LEFT, 1:CENTER, 2:RIFGT
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Bakmi Jago",
                                                              2,
                                                              1);
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Jl. Pulasaren No. 102, Kota Cirebon",
                                                              1,
                                                              1);
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              DateFormat(
                                                                      'dd-MM-yyyy')
                                                                  .format(DateTime
                                                                      .now()),
                                                              1,
                                                              1);
                                                          printer
                                                              .printNewLine();
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Pesanan", 1, 1);
                                                          printer
                                                              .printNewLine();
                                                          printer
                                                              .printNewLine();
                                                          for (var cartItem
                                                              in cartC
                                                                  .cartItems) {
                                                            printer.printCustom(
                                                                cartItem.name!,
                                                                1,
                                                                1);
                                                            printer.printCustom(
                                                                "${cartItem.quantity!} x " +
                                                                    RupiahUtils.beRupiah(
                                                                        cartItem
                                                                            .price!) +
                                                                    "       " +
                                                                    RupiahUtils.beRupiah(cartItem
                                                                            .quantity! *
                                                                        cartItem
                                                                            .price!),
                                                                1,
                                                                1);
                                                            printer
                                                                .printNewLine();
                                                          }
                                                          printer
                                                              .printNewLine();
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Total                  " +
                                                                  RupiahUtils.beRupiah(cartC
                                                                      .subtotal
                                                                      .toInt()),
                                                              1,
                                                              1);
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Bayar                  " +
                                                                  RupiahUtils.beRupiah(
                                                                      int.parse(
                                                                          "${orderC.inputCashController.value.text}")),
                                                              1,
                                                              1);
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Kembalian              " +
                                                                  RupiahUtils.beRupiah(cartC
                                                                          .subtotal
                                                                          .toInt() -
                                                                      cartC
                                                                          .subtotal
                                                                          .toInt()),
                                                              1,
                                                              1);
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Terima Kasih",
                                                              1,
                                                              1);
                                                        }
                                                      },
                                                      style: const ButtonStyle(
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
                                                      child: Text("Print",
                                                          style: regular.copyWith(
                                                              fontSize: 15,
                                                              color:
                                                                  cYellowDark)),
                                                    ),
                                                    OutlinedButton(
                                                      onPressed: () async {
                                                        final controller =
                                                            ScreenshotController();
                                                        final bytes = await controller
                                                            .captureFromWidget(
                                                                Material(
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
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            // height: 500,
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                    "Nota Pesanan",
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
                                                                            MaterialStatePropertyAll(cYellowDark),
                                                                        side:
                                                                            MaterialStatePropertyAll(
                                                                          BorderSide(
                                                                              color: cYellowDark),
                                                                        ),
                                                                      ),
                                                                      child: Text(
                                                                          "Kembali",
                                                                          style: regular.copyWith(
                                                                              fontSize: 15,
                                                                              color: cYellowDark)),
                                                                    ),
                                                                    // const SizedBox(
                                                                    //     width:
                                                                    //         10),
                                                                    // OutlinedButton(
                                                                    //   onPressed:
                                                                    //       () {
                                                                    //     // log("https://www.w3schools.com/w3images/avatar2.png");
                                                                    //     // FileDownloader.downloadFile(
                                                                    //     //     url: "https://www.w3schools.com/w3images/avatar2.png",
                                                                    //     //     onProgress: (name, progress) {
                                                                    //     //       log("Download Nota");
                                                                    //     //     },
                                                                    //     //     onDownloadCompleted: (value) {
                                                                    //     //       log("Download Succes");
                                                                    //     //       Get.snackbar(
                                                                    //     //           "Download Berhasil",
                                                                    //     //           "Cek Pada Folder Download File Manager");
                                                                    //     //     });
                                                                    //     saveImageInvoice(
                                                                    //         bytes);
                                                                    //     // log("$bytes");
                                                                    //     Get.snackbar(
                                                                    //         "Download Berhasil",
                                                                    //         "Cek Pada");
                                                                    //   },
                                                                    //   style:
                                                                    //       const ButtonStyle(
                                                                    //     foregroundColor:
                                                                    //         MaterialStatePropertyAll(cYellowDark),
                                                                    //     side:
                                                                    //         MaterialStatePropertyAll(
                                                                    //       BorderSide(
                                                                    //           color: cYellowDark),
                                                                    //     ),
                                                                    //   ),
                                                                    //   child: Text(
                                                                    //       "Download",
                                                                    //       style: regular.copyWith(
                                                                    //           fontSize: 15,
                                                                    //           color: cYellowDark)),
                                                                    // ),
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
                                                              color:
                                                                  cYellowDark),
                                                        ),
                                                      ),
                                                      child: Text("Lihat Nota",
                                                          style: regular.copyWith(
                                                              fontSize: 15,
                                                              color:
                                                                  cYellowDark)),
                                                    ),
                                                    // OutlinedButton(
                                                    //   onPressed: () {
                                                    //     Get.dialog(Dialog(
                                                    //       shape:
                                                    //           RoundedRectangleBorder(
                                                    //         borderRadius:
                                                    //             BorderRadius
                                                    //                 .circular(
                                                    //                     15),
                                                    //       ),
                                                    //       child: Container(
                                                    //           padding:
                                                    //               const EdgeInsets
                                                    //                   .all(10),
                                                    //           width: 350,
                                                    //           height: 400,
                                                    //           child: _devices
                                                    //                   .isEmpty
                                                    //               ? Center(
                                                    //                   child: Text(
                                                    //                       _devicesMsg ??
                                                    //                           ''),
                                                    //                 )
                                                    //               : ListView
                                                    //                   .builder(
                                                    //                   itemCount:
                                                    //                       _devices
                                                    //                           .length,
                                                    //                   itemBuilder:
                                                    //                       (context,
                                                    //                           index) {
                                                    //                     return ListTile(
                                                    //                       leading:
                                                    //                           Icon(Icons.print),
                                                    //                       title:
                                                    //                           Text(_devices[index].name!),
                                                    //                       subtitle:
                                                    //                           Text(_devices[index].address!),
                                                    //                       onTap:
                                                    //                           () {
                                                    //                         _startPrint(_devices[index]);
                                                    //                       },
                                                    //                     );
                                                    //                   },
                                                    //                 )),
                                                    //     ));
                                                    //   },
                                                    //   style: const ButtonStyle(
                                                    //     foregroundColor:
                                                    //         MaterialStatePropertyAll(
                                                    //             cYellowDark),
                                                    //     side:
                                                    //         MaterialStatePropertyAll(
                                                    //       BorderSide(
                                                    //           color:
                                                    //               cYellowDark),
                                                    //     ),
                                                    //   ),
                                                    //   child: Text("Print",
                                                    //       style: regular.copyWith(
                                                    //           fontSize: 15,
                                                    //           color:
                                                    //               cYellowDark)),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                      },
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
                                            MaterialStatePropertyAll(
                                                cYellowDark),
                                        side: MaterialStatePropertyAll(
                                          BorderSide(color: cYellowDark),
                                        ),
                                      ),
                                      child: Text("Batal",
                                          style: regular.copyWith(
                                              fontSize: 15,
                                              color: cYellowDark)),
                                    ),
                                    const SizedBox(width: 10),
                                    OutlinedButton(
                                      style: const ButtonStyle(
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                                cYellowDark),
                                        side: MaterialStatePropertyAll(
                                          BorderSide(color: cYellowDark),
                                        ),
                                      ),
                                      child: Text("Proses",
                                          style: regular.copyWith(
                                              fontSize: 15,
                                              color: cYellowDark)),
                                      onPressed: () async {
                                        await orderC.addOrders(cartC.cartItems);
                                        // var res = true;
                                        // // await orderC.addOrders(cartC.cartItems);
                                        // if (res is bool) {
                                        //   if (res) {
                                        //     Get.snackbar("Berhasil",
                                        //         "Transaksi berhasil");
                                        //   }
                                        // }
                                        Navigator.pop(context, true);
                                        Get.dialog(Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            width: 350,
                                            height: 450,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Text(
                                                      "Pembayaran Berhasil",
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
                                                Text("QRIS",
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowPrimary)),
                                                const SizedBox(height: 15),
                                                Text("Total Pembelian",
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowDark)),
                                                const SizedBox(height: 10),
                                                Text(
                                                    RupiahUtils.beRupiah(
                                                        cartC.subtotal.toInt()),
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowPrimary)),
                                                const SizedBox(height: 15),
                                                Text("Nominal Bayar",
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowDark)),
                                                const SizedBox(height: 10),
                                                Text(
                                                    RupiahUtils.beRupiah(
                                                        cartC.subtotal.toInt()),
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowPrimary)),
                                                const SizedBox(height: 15),
                                                Text("Kembalian",
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowDark)),
                                                const SizedBox(height: 10),
                                                Text(
                                                    RupiahUtils.beRupiah(cartC
                                                            .subtotal
                                                            .toInt() -
                                                        cartC.subtotal.toInt()),
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowPrimary)),
                                                const SizedBox(height: 15),
                                                Text("Waktu Pembayaran",
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowDark)),
                                                const SizedBox(height: 10),
                                                Text(
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(DateTime.now()),
                                                    style: bold.copyWith(
                                                        fontSize: 15,
                                                        color: cYellowPrimary)),
                                                const SizedBox(height: 25),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, true);
                                                        Get.off(OrderView());
                                                        orderC
                                                            .inputCashController
                                                            .value
                                                            .clear();
                                                        cartC.deleteAllData();
                                                      },
                                                      style: const ButtonStyle(
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
                                                      child: Text("Selesai",
                                                          style: regular.copyWith(
                                                              fontSize: 15,
                                                              color:
                                                                  cYellowDark)),
                                                    ),
                                                    OutlinedButton(
                                                      onPressed: () async {
                                                        // orderC
                                                        //     .inputCashController
                                                        //     .value
                                                        //     .clear();

                                                        if ((await printer
                                                            .isConnected)!) {
                                                          // SIZE
                                                          //0: Normal, 1:nORMAL-Bold, 2:Medium-Bold, 3:Large-Bold
                                                          // ALIGN
                                                          //0: LEFT, 1:CENTER, 2:RIFGT
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Bakmi Jago",
                                                              2,
                                                              1);
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Jl. Pulasaren No. 102, Kota Cirebon",
                                                              1,
                                                              1);
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              DateFormat(
                                                                      'dd-MM-yyyy')
                                                                  .format(DateTime
                                                                      .now()),
                                                              1,
                                                              1);
                                                          printer
                                                              .printNewLine();
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Pesanan", 1, 1);
                                                          printer
                                                              .printNewLine();
                                                          printer
                                                              .printNewLine();
                                                          for (var cartItem
                                                              in cartC
                                                                  .cartItems) {
                                                            printer.printCustom(
                                                                cartItem.name!,
                                                                1,
                                                                1);
                                                            printer.printCustom(
                                                                "${cartItem.quantity!} x " +
                                                                    RupiahUtils.beRupiah(
                                                                        cartItem
                                                                            .price!) +
                                                                    "       " +
                                                                    RupiahUtils.beRupiah(cartItem
                                                                            .quantity! *
                                                                        cartItem
                                                                            .price!),
                                                                1,
                                                                1);
                                                            printer
                                                                .printNewLine();
                                                          }
                                                          printer
                                                              .printNewLine();
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Total                  " +
                                                                  RupiahUtils.beRupiah(cartC
                                                                      .subtotal
                                                                      .toInt()),
                                                              1,
                                                              1);
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Bayar                  " +
                                                                  RupiahUtils.beRupiah(
                                                                      int.parse(
                                                                          "${orderC.inputCashController.value.text}")),
                                                              1,
                                                              1);
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Kembalian              " +
                                                                  RupiahUtils.beRupiah(cartC
                                                                          .subtotal
                                                                          .toInt() -
                                                                      cartC
                                                                          .subtotal
                                                                          .toInt()),
                                                              1,
                                                              1);
                                                          printer
                                                              .printNewLine();
                                                          printer.printCustom(
                                                              "Terima Kasih",
                                                              1,
                                                              1);
                                                        }
                                                      },
                                                      style: const ButtonStyle(
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
                                                      child: Text("Print",
                                                          style: regular.copyWith(
                                                              fontSize: 15,
                                                              color:
                                                                  cYellowDark)),
                                                    ),
                                                    OutlinedButton(
                                                      onPressed: () async {
                                                        final controller =
                                                            ScreenshotController();
                                                        final bytes = await controller
                                                            .captureFromWidget(
                                                                Material(
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
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            // height: 500,
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                    "Nota Pesanan",
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
                                                                            MaterialStatePropertyAll(cYellowDark),
                                                                        side:
                                                                            MaterialStatePropertyAll(
                                                                          BorderSide(
                                                                              color: cYellowDark),
                                                                        ),
                                                                      ),
                                                                      child: Text(
                                                                          "Kembali",
                                                                          style: regular.copyWith(
                                                                              fontSize: 15,
                                                                              color: cYellowDark)),
                                                                    ),
                                                                    // const SizedBox(
                                                                    //     width:
                                                                    //         10),
                                                                    // OutlinedButton(
                                                                    //   onPressed:
                                                                    //       () {
                                                                    //     // log("https://www.w3schools.com/w3images/avatar2.png");
                                                                    //     // FileDownloader.downloadFile(
                                                                    //     //     url: "https://www.w3schools.com/w3images/avatar2.png",
                                                                    //     //     onProgress: (name, progress) {
                                                                    //     //       log("Download Nota");
                                                                    //     //     },
                                                                    //     //     onDownloadCompleted: (value) {
                                                                    //     //       log("Download Succes");
                                                                    //     //       Get.snackbar(
                                                                    //     //           "Download Berhasil",
                                                                    //     //           "Cek Pada Folder Download File Manager");
                                                                    //     //     });
                                                                    //     saveImageInvoice(
                                                                    //         bytes);
                                                                    //     // log("$bytes");
                                                                    //     Get.snackbar(
                                                                    //         "Download Berhasil",
                                                                    //         "Cek Pada");
                                                                    //   },
                                                                    //   style:
                                                                    //       const ButtonStyle(
                                                                    //     foregroundColor:
                                                                    //         MaterialStatePropertyAll(cYellowDark),
                                                                    //     side:
                                                                    //         MaterialStatePropertyAll(
                                                                    //       BorderSide(
                                                                    //           color: cYellowDark),
                                                                    //     ),
                                                                    //   ),
                                                                    //   child: Text(
                                                                    //       "Download",
                                                                    //       style: regular.copyWith(
                                                                    //           fontSize: 15,
                                                                    //           color: cYellowDark)),
                                                                    // ),
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
                                                              color:
                                                                  cYellowDark),
                                                        ),
                                                      ),
                                                      child: Text("Lihat Nota",
                                                          style: regular.copyWith(
                                                              fontSize: 15,
                                                              color:
                                                                  cYellowDark)),
                                                    ),
                                                    // OutlinedButton(
                                                    //   onPressed: () {
                                                    //     Get.dialog(Dialog(
                                                    //       shape:
                                                    //           RoundedRectangleBorder(
                                                    //         borderRadius:
                                                    //             BorderRadius
                                                    //                 .circular(
                                                    //                     15),
                                                    //       ),
                                                    //       child: Container(
                                                    //           padding:
                                                    //               const EdgeInsets
                                                    //                   .all(10),
                                                    //           width: 350,
                                                    //           height: 400,
                                                    //           child: _devices
                                                    //                   .isEmpty
                                                    //               ? Center(
                                                    //                   child: Text(
                                                    //                       _devicesMsg ??
                                                    //                           ''),
                                                    //                 )
                                                    //               : ListView
                                                    //                   .builder(
                                                    //                   itemCount:
                                                    //                       _devices
                                                    //                           .length,
                                                    //                   itemBuilder:
                                                    //                       (context,
                                                    //                           index) {
                                                    //                     return ListTile(
                                                    //                       leading:
                                                    //                           Icon(Icons.print),
                                                    //                       title:
                                                    //                           Text(_devices[index].name!),
                                                    //                       subtitle:
                                                    //                           Text(_devices[index].address!),
                                                    //                       onTap:
                                                    //                           () {
                                                    //                         _startPrint(_devices[index]);
                                                    //                       },
                                                    //                     );
                                                    //                   },
                                                    //                 )),
                                                    //     ));
                                                    //   },
                                                    //   style: const ButtonStyle(
                                                    //     foregroundColor:
                                                    //         MaterialStatePropertyAll(
                                                    //             cYellowDark),
                                                    //     side:
                                                    //         MaterialStatePropertyAll(
                                                    //       BorderSide(
                                                    //           color:
                                                    //               cYellowDark),
                                                    //     ),
                                                    //   ),
                                                    //   child: Text("Print",
                                                    //       style: regular.copyWith(
                                                    //           fontSize: 15,
                                                    //           color:
                                                    //               cYellowDark)),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                      },
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
          )),
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

// void showDialog() {
//   Get.dialog(Dialog());
// }
}
