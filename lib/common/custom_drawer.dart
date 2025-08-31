// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/common/shared_preferences.dart';
// import 'package:kanha_bmc/core/app_assets.dart';
// import 'package:kanha_bmc/pages/dashboard.dart';
// import 'package:kanha_bmc/pages/profile.dart';
// import '../pages/master/master_homepage.dart';
// import '../pages/procurement/procurement_homepage.dart';
// import '../pages/reports/report_homepage.dart';
// import '../pages/setting.dart';
//
// class CustomDrawer extends StatefulWidget {
//   const CustomDrawer({super.key});
//
//   @override
//   State<CustomDrawer> createState() => _CustomDrawerState();
// }
//
// class _CustomDrawerState extends State<CustomDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return OrientationBuilder(
//       builder: (context, orientation) {
//         // Get width and height dynamically
//         double width = Get.width;
//         double height = Get.height;
//
//         return Drawer(
//           child: Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                     "assets/images/bg_image.png"), // Background image
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 SizedBox(
//                   height: height * 0.1,
//                 ),
//                 SizedBox(
//                   //width: width,
//                   height: height * 0.1,
//                   child: Image.asset("assets/images/logo.png"),
//                 ),
//                 SizedBox(
//                   height: height * 0.05,
//                 ),
//                 // Drawer Items
//                 ListTile(
//                   leading: Icon(Icons.account_circle_outlined),
//                   title: Text("Profile"),
//                   onTap: () {
//                     Get.back(); // Close the drawer
//                     Get.to(ProfileScreen());
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.dashboard_outlined),
//                   title: Text("Dashboard"),
//                   onTap: () {
//                     Get.back(); // Close the drawer
//                     Get.to(DashboardScreen());
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.manage_accounts_outlined),
//                   title: Text("Masters"),
//                   onTap: () {
//                     Get.back(); // Close the drawer
//                     Get.to(MasterHomepageScreen());
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.wallet_giftcard_outlined),
//                   title: Text("Procurement"),
//                   onTap: () {
//                     Get.back(); // Close the drawer
//                     Get.to(ProcurementHomepageScreen());
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.report_outlined),
//                   title: Text("Reports"),
//                   onTap: () {
//                     Get.back(); // Close the drawer
//                     Get.to(ReportsHomepageScreen());
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.settings_outlined),
//                   title: Text("Settings"),
//                   onTap: () {
//                     Get.back(); // Close the drawer
//                     Get.to(SettingsScreen());
//                     // Navigator.pushReplacementNamed(context, '/settings');
//                   },
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.logout_outlined),
//                   title: Text("Logout"),
//                   onTap: () {
//                     // SecureStorageService.clearAll();
//                      // Get.off(LoginScreen());
//                  SharedPrefHelper.clearAllData();
//                     // Add any other logout logic here if necessary
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/common/shared_preferences.dart';
import 'package:kanha_bmc/core/app_assets.dart';
import 'package:kanha_bmc/pages/dashboard.dart';
import 'package:kanha_bmc/pages/profile.dart';
import '../pages/master/master_homepage.dart';
import '../pages/procurement/procurement_homepage.dart';
import '../pages/reports/report_homepage.dart';
import '../pages/setting.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        double width = Get.width;
        double height = Get.height;

        return Drawer(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_image.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                // Header section with logo
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 20,
                    left: 0,
                    bottom: 10,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 70,
                    width: 120,
                    fit: BoxFit.contain,
                  ),
                ),

                // Main menu items
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        _buildDrawerItem(
                          icon: Icons.dashboard_outlined,
                          title: "Dashboard",
                          onTap: () {
                            Get.back();
                            Get.to(DashboardScreen());
                          },
                        ),
                        _buildDrawerItem(
                          icon: Icons.people_outline,
                          title: "Masters",
                          onTap: () {
                            Get.back();
                            Get.to(MasterHomepageScreen());
                          },
                        ),
                        _buildDrawerItem(
                          icon: Icons.shopping_cart_outlined,
                          title: "Procurement",
                          onTap: () {
                            Get.back();
                            Get.to(ProcurementHomepageScreen());
                          },
                        ),
                        _buildDrawerItem(
                          icon: Icons.description_outlined,
                          title: "Reports",
                          onTap: () {
                            Get.back();
                            Get.to(ReportsHomepageScreen());
                          },
                        ),
                        _buildDrawerItem(
                          icon: Icons.person_outline,
                          title: "Profile",
                          onTap: () {
                            Get.back();
                            Get.to(ProfileScreen());
                          },
                        ),

                        Spacer(), // Push bottom items to the bottom

                        // Bottom section with divider
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(vertical: 16),
                        ),

                        _buildDrawerItem(
                          icon: Icons.settings_outlined,
                          title: "Setting",
                          onTap: () {
                            Get.back();
                            Get.to(SettingsScreen());
                          },
                        ),
                        _buildDrawerItem(
                          icon: Icons.logout_outlined,
                          title: "Logout",
                          onTap: () {
                            SharedPrefHelper.clearAllData();
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color:  CustomColors.accentColor,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}