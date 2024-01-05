import 'package:bakmi_jago_app/components/menu_profile_component.dart';
import 'package:bakmi_jago_app/controllers/auth_controller.dart';
import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        title: Text(
          "Profile",
          style: bold.copyWith(fontSize: 25, color: cYellowDark),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 32,
                  width: 32,
                  // child: CircleAvatar(
                  //   backgroundImage: NetworkImage(
                  //     "https://www.w3schools.com/w3images/avatar2.png",
                  //   ),
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Owner",
                      style: bold.copyWith(color: cYellowDark, fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text("owner@gmail.com",
                      style: bold.copyWith(color: cYellowDark, fontSize: 15)),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: MenuProfileComponent(
                        icon: Icons.abc, name: "Riwayat Order")),
                const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: MenuProfileComponent(
                        icon: Icons.ac_unit_rounded, name: "Pengaturan")),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: MenuProfileComponent(
                        onTap: () {
                          Get.dialog(
                            Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                width: 350,
                                height: 180,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Konfirmasi untuk keluar?",
                                        style: TextStyle(
                                          color: cYellowDark,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Dengan mengkonfirmasi anda mensetujui bahwa anda akan log out dari akun yang sekarang anda gunakan",
                                        style: TextStyle(
                                          color: Color(0xff808D9D),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: const ButtonStyle(
                                              elevation:
                                                  MaterialStatePropertyAll(0),
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                      Color>(
                                                cYellowDark,
                                              ),
                                            ),
                                            onPressed: () =>
                                                authController.logout(),
                                            child: const Text("Konfirmasi"),
                                          ),
                                          OutlinedButton(
                                            onPressed: () => Get.back(),
                                            style: const ButtonStyle(
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                      cYellowDark),
                                              side: MaterialStatePropertyAll(
                                                BorderSide(color: cYellowDark),
                                              ),
                                            ),
                                            child: const Text("Batalkan"),
                                          )
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                          );
                        },
                        icon: Icons.logout,
                        name: "Keluar")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
