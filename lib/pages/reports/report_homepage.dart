// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/pages/reports/bmc_collection_reports/bmc_collection_reports.dart';
// import '../../common/custom_app_bar.dart';
// import '../../controller/reports/reports_homepage_controller.dart';
// import 'member_collection_reports/member_collection_reports.dart';
// import 'rmrd_reports/rmrd_reports.dart';
//
// class ReportsHomepageScreen extends StatefulWidget {
//   const ReportsHomepageScreen({super.key});
//
//   @override
//   State<ReportsHomepageScreen> createState() => _ReportsHomepageScreenState();
// }
//
// class _ReportsHomepageScreenState extends State<ReportsHomepageScreen> {
//   final ReportsHomepageController controller =
//       Get.put(ReportsHomepageController());
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const CustomAppBar(
//           title: 'Reports',
//         ),
//         body: OrientationBuilder(
//           builder: (context, orientation) {
//             return SizedBox(
//               height: Get.height,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _buildCard(
//                       title: 'Member Collection',
//                       imagePath: "assets/icons/tank.png",
//                       onTap: () {
//                         Get.to(() => MemberCollReportsHomepage());
//                       },
//                     ),
//                     _buildCard(
//                       title: 'BMC Collection',
//                       imagePath: "assets/icons/bmc_collection.png",
//                       onTap: () {
//                         Get.to(() => BMCCollReportsHomepage());
//                       },
//                     ),
//                     _buildCard(
//                       title: 'RMRD',
//                       imagePath: "assets/icons/truck.png",
//                       onTap: () {
//                         Get.to(() => RMRDReportsHomepage());
//                         // Navigate to the relevant page
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard({
//     required String title,
//     required String imagePath,
//     required VoidCallback onTap,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Card(
//           elevation: 2,
//           margin: const EdgeInsets.symmetric(horizontal: 10),
//           child: SizedBox(
//             height: Get.height * 0.11,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Image.asset(
//                     imagePath,
//                     height: Get.height * 0.08,
//                     width: Get.width * 0.1,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/pages/reports/bmc_collection_reports/bmc_collection_reports.dart';
import '../../common/custom_app_bar.dart';
import '../../controller/reports/reports_homepage_controller.dart';
import 'member_collection_reports/member_collection_reports.dart';
import 'rmrd_reports/rmrd_reports.dart';

class ReportsHomepageScreen extends StatefulWidget {
  const ReportsHomepageScreen({super.key});

  @override
  State<ReportsHomepageScreen> createState() => _ReportsHomepageScreenState();
}

class _ReportsHomepageScreenState extends State<ReportsHomepageScreen> {
  final ReportsHomepageController controller =
  Get.put(ReportsHomepageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Reports',
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // First row
                    Row(
                      children: [
                        Expanded(
                          child: _buildCard(
                            title: 'Member\nCollection',
                            imagePath: "assets/icons/tank.png",
                            onTap: () {
                              Get.to(() => MemberCollReportsHomepage());
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildCard(
                            title: 'BMC\nCollection',
                            imagePath: "assets/icons/bmc_collection.png",
                            onTap: () {
                              Get.to(() => BMCCollReportsHomepage());
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Second row
                    Row(
                      children: [
                        Expanded(
                          child: _buildCard(
                            title: 'RMRD',
                            imagePath: "assets/icons/truck.png",
                            onTap: () {
                              Get.to(() => RMRDReportsHomepage());
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Container(), // Empty space to maintain grid structure
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 85,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 48,
              height: 48,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}