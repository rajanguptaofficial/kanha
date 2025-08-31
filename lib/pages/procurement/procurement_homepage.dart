// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/pages/procurement/bmc_collection.dart';
// import 'package:kanha_bmc/pages/procurement/member_collection.dart';
// import 'package:kanha_bmc/pages/procurement/truck_arrival.dart';
// import '../../common/custom_app_bar.dart';
// import '../../controller/procurement/procurement_homepage_controller.dart';
// import 'dock_collection.dart';
// import 'lab_fat_snf.dart';
//
// class ProcurementHomepageScreen extends StatefulWidget {
//   ProcurementHomepageScreen({super.key});
//
//   @override
//   State<ProcurementHomepageScreen> createState() => _ProcurementHomepageScreenState();
// }
//
// class _ProcurementHomepageScreenState extends State<ProcurementHomepageScreen> {
//   // Instance of GetX controller
//   final ProcurementHomepageController controller =
//       Get.put(ProcurementHomepageController());
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: ProcCustomAppBar(title: 'Procurement'),
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
//                         Get.to(() => MemberCollectionScreen());
//                       },
//                     ),
//                     _buildCard(
//                       title: 'Truck Arrival',
//                       imagePath: "assets/icons/truck.png",
//                       onTap: () {
//                         Get.to(() => TruckArrivalFormScreen());
//                         // Navigate to the relevant page
//                       },
//                     ),
//                     _buildCard(
//                       title: 'Doc/Weight Collection',
//                       imagePath: "assets/icons/weight.png",
//                       onTap: () {
//                         Get.to(() => DockCollectionScreen());
//                       },
//                     ),
//                     _buildCard(
//                       title: 'Lab (FAT/SNF)',
//                       imagePath: "assets/icons/lab.png",
//                       onTap: () {
//                         Get.to(() => LabFatSnfFormScreen());
//                       },
//                     ),
//                     _buildCard(
//                       title: 'BMC Collection',
//                       imagePath: "assets/icons/bmc_collection.png",
//                       onTap: () {
//                         Get.to(() => BMCCollectionScreen());
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
import 'package:kanha_bmc/pages/procurement/bmc_collection.dart';
import 'package:kanha_bmc/pages/procurement/member_collection.dart';
import 'package:kanha_bmc/pages/procurement/truck_arrival.dart';
import '../../common/custom_app_bar.dart';
import '../../controller/procurement/procurement_homepage_controller.dart';
import 'dock_collection.dart';
import 'lab_fat_snf.dart';

class ProcurementHomepageScreen extends StatefulWidget {
  ProcurementHomepageScreen({super.key});

  @override
  State<ProcurementHomepageScreen> createState() => _ProcurementHomepageScreenState();
}

class _ProcurementHomepageScreenState extends State<ProcurementHomepageScreen> {
  // Instance of GetX controller
  final ProcurementHomepageController controller =
  Get.put(ProcurementHomepageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProcCustomAppBar(title: 'Procurement'),
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
                              Get.to(() => MemberCollectionScreen());
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildCard(
                            title: 'Truck\nArrival',
                            imagePath: "assets/icons/truck.png",
                            onTap: () {
                              Get.to(() => TruckArrivalFormScreen());
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
                            title: 'Doc/Weight\nCollection',
                            imagePath: "assets/icons/weight.png",
                            onTap: () {
                              Get.to(() => DockCollectionScreen());
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildCard(
                            title: 'Lab (FAT/\nSNF)',
                            imagePath: "assets/icons/lab.png",
                            onTap: () {
                              Get.to(() => LabFatSnfFormScreen());
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Third row - BMC Collection spans full width but styled like grid item
                    Row(
                      children: [
                        Expanded(
                          child: _buildCard(
                            title: 'BMC\nCollection',
                            imagePath: "assets/icons/bmc_collection.png",
                            onTap: () {
                              Get.to(() => BMCCollectionScreen());
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
