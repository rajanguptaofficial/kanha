// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/pages/procurement/dock_collection.dart';
// import 'package:kanha_bmc/pages/procurement/lab_fat_snf.dart';
// import 'package:kanha_bmc/pages/procurement/truck_arrival.dart';
// import '../../common/custom_app_bar.dart';
// import '../../controller/reports/reports_homepage_controller.dart';

// class RMRDHomepageScreen extends StatefulWidget {
//   const RMRDHomepageScreen({super.key});

//   @override
//   State<RMRDHomepageScreen> createState() => _RMRDHomepageScreenState();
// }

// class _RMRDHomepageScreenState extends State<RMRDHomepageScreen> {
//   final ReportsHomepageController controller =
//       Get.put(ReportsHomepageController());

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
//                       title: 'Truck Arrival',
//                       imagePath: "assets/icons/truck.png",
//                       onTap: () {
//                         Get.to(() => TruckArrivalFormScreen());
//                         // Navigate to the relevant page
//                       },
//                     ),
//                     _buildCard(
//                       title: 'Dock Collection ',
//                       imagePath: "assets/icons/weight.png",
//                       onTap: () {
//                         Get.to(() => DockCollectionScreen());
//                       },
//                     ),
//                     _buildCard(
//                       title: 'Lab Collection',
//                       imagePath: "assets/icons/lab.png",
//                       onTap: () {
//                         Get.to(() => LabFatSnfFormScreen());
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
