import 'package:bakmi_jago_app/components/icon_button_component.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';

class ProfileSettingView extends StatefulWidget {
  const ProfileSettingView({super.key});

  @override
  State<ProfileSettingView> createState() => _ProfileSettingViewState();
}

class _ProfileSettingViewState extends State<ProfileSettingView> {
  List<BluetoothDevice>? devices;
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDevices();
  }

  void getDevices() async {
    devices = await printer.getBondedDevices();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        foregroundColor: cYellowDark,
        title: Text(
          "Atur Printer",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 110,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton(
                        value: selectedDevice,
                        hint: const Text("Pilih Bluetooth"),
                        onChanged: (device) {
                          setState(() {
                            selectedDevice = device!;
                          });
                        },
                        items: devices!
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.name!),
                                  value: e,
                                ))
                            .toList()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButtonComponent(
                          "Connect",
                          icon: const Icon(
                            Icons.bluetooth_connected,
                          ),
                          color: cYellowPrimary,
                          onPressed: () {
                            printer.connect(selectedDevice!);
                          },
                        ),
                        const SizedBox(width: 5),
                        IconButtonComponent(
                          "Disconnect",
                          icon: const Icon(
                            Icons.bluetooth_disabled,
                          ),
                          color: cYellowPrimary,
                          onPressed: () {
                            printer.disconnect();
                          },
                        ),
                        const SizedBox(width: 5),
                        IconButtonComponent(
                          "Print",
                          icon: const Icon(
                            Icons.print,
                          ),
                          color: cYellowPrimary,
                          onPressed: () async {
                            if ((await printer.isConnected)!) {
                              // SIZE
                              //0: Normal, 1:nORMAL-Bold, 2:Medium-Bold, 3:Large-Bold
                              // ALIGN
                              //0: LEFT, 1:CENTER, 2:RIFGT
                              printer.printCustom("Test Printer", 2, 1);
                              printer.printCustom("Test Printer", 2, 1);
                              printer.printNewLine();
                            }
                          },
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       printer.connect(selectedDevice!);
                        //     },
                        //     child: const Text("Connect")),
                        // const SizedBox(width: 5),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       printer.disconnect();
                        //     },
                        //     child: const Text("Disconnect")),
                        // const SizedBox(width: 5),
                        // ElevatedButton(
                        //     onPressed: () async {
                        //       if ((await printer.isConnected)!) {
                        //         // SIZE
                        //         //0: Normal, 1:nORMAL-Bold, 2:Medium-Bold, 3:Large-Bold
                        //         // ALIGN
                        //         //0: LEFT, 1:CENTER, 2:RIFGT
                        //         printer.printCustom("Test Printer", 2, 1);
                        //         printer.printCustom("Test Printer", 2, 1);

                        //         printer.printNewLine();
                        //       }
                        //     },
                        //     child: const Text("Test"))
                      ],
                    ),
                  ],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// DropdownButton(
//               value: selectedDevice,
//               hint: const Text("Pilih Bluetooth"),
//               onChanged: (device) {
//                 setState(() {
//                   selectedDevice = device!;
//                 });
//               },
//               items: devices!
//                   .map((e) => DropdownMenuItem(
//                         child: Text(e.name!),
//                         value: e,
//                       ))
//                   .toList()),
//           const SizedBox(height: 5),
//           ElevatedButton(
//               onPressed: () {
//                 printer.connect(selectedDevice!);
//               },
//               child: const Text("Connect")),
//           ElevatedButton(
//               onPressed: () {
//                 printer.disconnect();
//               },
//               child: const Text("Disconnect")),
//           ElevatedButton(
//               onPressed: () async {
//                 if ((await printer.isConnected)!) {
//                   printer.printCustom("Test Printer", 3, 1);

//                   printer.printNewLine();
//                 }
//               },
//               child: const Text("Print"))
