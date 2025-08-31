// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/common/colors.dart';
// import 'package:kanha_bmc/common/custom_drawer.dart';
// import 'package:kanha_bmc/controller/dashboard_controller.dart';
// import 'package:kanha_bmc/pages/procurement/bmc_collection.dart';
// import 'package:kanha_bmc/pages/procurement/member_collection.dart';
// import 'package:kanha_bmc/pages/reports/report_homepage.dart';
// import 'package:kanha_bmc/pages/rmrd_dashboard_proc.dart';
// import '../common/custom_app_bar.dart';
//
// class DashboardScreen extends StatelessWidget {
//   DashboardScreen({super.key});
//
//   final DashboardController controller = Get.put(DashboardController());
//
//   @override
//   Widget build(BuildContext context) {
//  return SafeArea(
//       child: Scaffold(
//         appBar: CustomAppBar(
//           title:"Dashboard"
//         ),
//          drawer:  CustomDrawer(),
//         body:
//         OrientationBuilder(
//             builder: (context, orientation) {
//               return
//              SingleChildScrollView(
//               padding: EdgeInsets.all(Get.width * 0.02),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(Get.width * 0.02),
//                     child: const Text(
//                       'BMA-0011 Pawan Dwivedi',
//                       style: TextStyle(
//                           color: CustomColors.appColor,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   SizedBox(height: Get.height * 0.02),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Date Picker
//                         Expanded(
//                           flex: 1,
//                           child:
//
//                            Obx(
//                             () => TextFormField(
//                               readOnly: true,
//                               controller: TextEditingController(
//                                 text:controller.selectedDate.value.isEmpty ? "Select Date" : controller.selectedDate.value
//
//
//                                 //  controller.selectedDate.value.isNotEmpty
//                                 //     ? controller.selectedDate.value
//                                 //     : "Select Date",
//                               ),
//
//                               decoration: const InputDecoration(
//                                 labelText: "Select Date",
//                                 border: OutlineInputBorder(),
//                                 suffixIcon: Icon(Icons.calendar_month),
//
//     labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),
//
//
//
//
//                               ),
//                               onTap: () async {
//                                 DateTime? pickedDate = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(2000),
//                                   lastDate: DateTime(2101),
//                                 );
//                                 if (pickedDate != null) {
//                                   controller.updateDate(
//                                       "${pickedDate.toLocal()}".split(' ')[0]);
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: Get.width * 0.04),
//                         // Dropdown for Morning/Evening
//                         Expanded(
//                           flex: 1,
//                           child: Obx(
//                             () => DropdownButtonFormField<String>(
//                               decoration: const InputDecoration(
//                                 labelText: "Select Time",
//                                 border: OutlineInputBorder(),
//     labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     )
//                               ),
//                               value: controller.selectedTime.value,
//                               items: ["Morning", "Evening"]
//                                   .map(
//                                     (String time) => DropdownMenuItem<String>(
//                                       value: time,
//                                       child: Text(time),
//                                     ),
//                                   )
//                                   .toList(),
//                               onChanged: (newValue) {
//                                 if (newValue != null) {
//                                   controller.updateTime(newValue);
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: Get.height * 0.02),
//                   // RMRD Collection Section
//                   _buildSectionCard(
//                     title: 'RMRD Collection',
//                     data: [
//                       _buildInfoCard('5', 'Total MPP'),
//                       _buildInfoCard('5', 'Pouring MPP'),
//                       _buildInfoCard('100/6.5/8.5', 'Total - Quantity/FAT/SNF'),
//                     ],
//                   ),
//                   SizedBox(height: Get.height * 0.02),
//                   // Member Collection Section
//                   _buildSectionCard(
//                     title: 'Member Collection',
//                     data: [
//                       _buildInfoCard('200', 'Total Member'),
//                       _buildInfoCard('5/5', 'Pouring Member/Sample'),
//                       _buildInfoCard('100/6.5/8.5', 'Total - Quantity/FAT/SNF'),
//                     ],
//                   ),
//                   SizedBox(height: Get.height * 0.02),
//                   // Transactions Section
//                   _buildTransactionsRow(),
//                 ],
//               ),
//             );
//        }),
//           bottomNavigationBar: Padding(
//             padding: EdgeInsets.all(Get.width * 0.02),
//             child: const Text(
//               '© KMTEPL | App Version-1.0 | 5 Feb 2025',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 12, color: Colors.black),
//             ),
//           )));}}
//
//
//
//
//   Widget _buildSectionCard(
//       {required String title, required List<Widget> data}) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: Get.height * 0.01),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(height: Get.height * 0.02),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: data,
//           ),
//           SizedBox(height: Get.height * 0.02),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoCard(String value, String label) {
//     return Expanded(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: CustomColors.appColor,
//             ),
//           ),
//           SizedBox(height: Get.height * 0.01),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               label,
//               textAlign: TextAlign.center,
//               softWrap: true,
//               overflow: TextOverflow.visible,
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTransactionsRow() {
//     return Card(
//       child: Column(
//         children: [
//           const Text(
//             "Transactions",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(height: Get.height * 0.02),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               // Navigate to Login Screen
//               _buildTransactionButton("Member", () {
//                 Get.to(() => MemberCollectionScreen());
//               }),
//               _buildTransactionButton("BMC", () {
//                 Get.to(() => BMCCollectionScreen());
//               }),
//               _buildTransactionButton("RMRD", () {
//                 Get.to(() => RMRDHomepageScreen());
//               }),
//               _buildTransactionButton("Reports", () {
//                 Get.to(() => ReportsHomepageScreen());
//               }),
//             ],
//           ),
//           SizedBox(height: Get.height * 0.02),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTransactionButton(
//     String label,
//     VoidCallback onTap,
//   ) {
//     return ElevatedButton(
//       onPressed: onTap,
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.symmetric(
//           horizontal: Get.width * 0.01,
//           vertical: Get.height * 0.01,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         backgroundColor: CustomColors.appColor,
//       ),
//       child: Text(
//         label,
//         style: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/common/custom_drawer.dart';
import 'package:kanha_bmc/controller/dashboard_controller.dart';
import 'package:kanha_bmc/pages/procurement/bmc_collection.dart';
import 'package:kanha_bmc/pages/procurement/member_collection.dart';
import 'package:kanha_bmc/pages/reports/report_homepage.dart';
import 'package:kanha_bmc/pages/rmrd_dashboard_proc.dart';
import '../common/custom_app_bar.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            title: "Dashboard KMTEPL"
        ),
        drawer: CustomDrawer(),
        body: OrientationBuilder(
            builder: (context, orientation) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(Get.width * 0.04),
                child: Column(
                  children: [
                    // User info and date/time selection row
                    Row(
                      children: [
                        // User info
                        Expanded(
                          flex: 2,
                          child: Text(
                            'BMA-001 Yaksh Verma',
                            style: TextStyle(
                              color: Color(0xFF00BFFF), // Light blue color
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // Date picker
                        Container(
                          width: 100,
                          height: 36,
                          child: Obx(
                                () => Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    controller.updateDate(
                                        "${pickedDate.toLocal()}".split(' ')[0]);
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        controller.selectedDate.value.isEmpty
                                            ? "19 Dec 24"
                                            : controller.selectedDate.value,
                                        style: TextStyle(fontSize: 10),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Icon(Icons.calendar_today, size: 14),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        // Time dropdown
                        Container(
                          width: 90,
                          height: 36,
                          child: Obx(
                                () => Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.selectedTime.value.isEmpty
                                      ? "Morning"
                                      : controller.selectedTime.value,
                                  isExpanded: true,
                                  style: TextStyle(fontSize: 10, color: Colors.black),
                                  icon: Icon(Icons.arrow_drop_down, size: 16),
                                  items: ["Morning", "Evening"]
                                      .map(
                                        (String time) => DropdownMenuItem<String>(
                                      value: time,
                                      child: Text(time, style: TextStyle(fontSize: 10)),
                                    ),
                                  )
                                      .toList(),
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      controller.updateTime(newValue);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.03),

                    // RMRD Collection Section
                    _buildSectionCard(
                      title: 'RMRD Collection',
                      data: [
                        _buildInfoCard('5', 'Total MPP', Color(0xFF00BFFF)),
                        _buildInfoCard('5', 'Pouring MPP', Color(0xFF00BFFF)),
                        _buildInfoCard('100/6.5/8.5', 'Total/FAT/SNF', Color(0xFF00BFFF)),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),

                    // Member Collection Section
                    _buildSectionCard(
                      title: 'Member Collection',
                      data: [
                        _buildInfoCard('200', 'Total Member', Color(0xFF00BFFF)),
                        _buildInfoCard('5/5', 'Pouring Member/Sample', Color(0xFF00BFFF)),
                        _buildInfoCard('100/6.5/8.5', 'Total/FAT/SNF', Color(0xFF00BFFF)),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),

                    // Transactions Section
                    _buildTransactionsRow(),
                  ],
                ),
              );
            }),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(Get.width * 0.02),
          child: const Text(
            '@KMTEPL | App Version-1.0 | 17 Dec 2024',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> data}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
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
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Row(
            children: data,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String value, String label, Color valueColor) {
    return Expanded(
      child: Container(
        height: 80, // Fixed height for all cards
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black87,
                fontWeight: FontWeight.w600
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsRow() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
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
      child: Column(
        children: [
          const Text(
            "Transactions",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTransactionButton("Member", () {
                Get.to(() => MemberCollectionScreen());
              }),
              _buildTransactionButton("BMC", () {
                Get.to(() => BMCCollectionScreen());
              }),
              _buildTransactionButton("RMRD", () {
                Get.to(() => RMRDHomepageScreen());
              }),
              _buildTransactionButton("Reports", () {
                Get.to(() => ReportsHomepageScreen());
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionButton(String label, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.05,
          vertical: Get.height * 0.008,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: CustomColors.appColor,
        elevation: 2,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}