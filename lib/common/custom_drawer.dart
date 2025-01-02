import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/shared_preferences.dart';
import 'package:kanha_bmc/pages/dashboard.dart';
import 'package:kanha_bmc/pages/master/master.dart';
import 'package:kanha_bmc/pages/procurement/procurement.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        // Get width and height dynamically
        double width = Get.width;
        double height = Get.height;

        return Drawer(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_image.png"), // Background image
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: height * 0.1, 
                ),
                SizedBox(
                  width: width,
                  height: height * 0.2,
                  child: Image.asset("assets/images/logo.png"),
                ),
                SizedBox(
                  height: height * 0.05, 
                ),
                // Drawer Items
                ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text("Profile"),
                  onTap: () {
                    // Navigator.pushReplacementNamed(context, '/profile');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.dashboard_outlined),
                  title: Text("Dashboard"),
                  onTap: () {
                    Get.back(); // Close the drawer
                    Get.to(DashboardScreen());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.manage_accounts_outlined),
                  title: Text("Masters"),
                  onTap: () {
                    Get.back(); // Close the drawer
                    Get.to(MasterScreen());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.wallet_giftcard_outlined),
                  title: Text("Procurement"),
                  onTap: () {
                    Get.back(); // Close the drawer
                    Get.to(ProcurementScreen());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.report_outlined),
                  title: Text("Reports"),
                  onTap: () {
                    // Navigator.pushReplacementNamed(context, '/settings');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text("Settings"),
                  onTap: () {
                    // Navigator.pushReplacementNamed(context, '/settings');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text("Logout"),
                  onTap: () {
                    SharedPrefHelper.clearAllData();
                    // Add any other logout logic here if necessary
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
