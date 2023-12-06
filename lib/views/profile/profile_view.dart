import 'package:bakmi_jago_app/components/menu_profile_component.dart';
import 'package:bakmi_jago_app/controllers/page_index_controller.dart';
import 'package:bakmi_jago_app/resources/color.dart';
import 'package:bakmi_jago_app/resources/font.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Text("Admin",
                      style: bold.copyWith(color: cBlack, fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text("admin@gmail.com",
                      style: bold.copyWith(color: cDarkGray, fontSize: 15)),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: MenuProfileComponent(
                        icon: Icons.abc, name: "Riwayat Order")),
                const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: MenuProfileComponent(
                        icon: Icons.ac_unit_rounded, name: "Pengaturan")),
                const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: MenuProfileComponent(
                        icon: Icons.logout, name: "Keluar")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
