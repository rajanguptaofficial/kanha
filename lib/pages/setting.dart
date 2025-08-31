// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/common/colors.dart';
// import 'package:kanha_bmc/common/custom_app_bar.dart';
// import 'package:kanha_bmc/controller/setting_controller.dart';
//
//
// class SettingsScreen extends StatelessWidget {
//   final SettingsController controller = Get.put(SettingsController());
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const CustomAppBar(
//             title: 'Setting',
//           ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: const Text(
//                       'Device Configuration',
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Card(
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child:  SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                         child: DataTable(  headingRowColor: WidgetStateProperty.all(CustomColors.appColor,),
//                             headingTextStyle: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             columnSpacing:12,
//                              //orientation == Orientation.portrait
//                                // ? 15
//                               //  : 30,
//                              // Adjust spacing based on orientation
//                             dataRowMinHeight: 20,
//                             dataRowMaxHeight: 40,headingRowHeight: 33,
//                           columns: const [
//                             DataColumn(label: Text('List Devices')),
//                             DataColumn(label: Text('On/Off')),
//                             DataColumn(label: Text('Device Make')),
//                             DataColumn(label: Text('Baud Rate')),
//                           ],
//                           rows: List.generate(5, (index) {
//                             return DataRow(cells: [
//                               DataCell(Row(spacing: 33,
//                                 children: [
//                                   Text('Device ${index + 1}',style: TextStyle(fontWeight: FontWeight.bold),),
//                                   Obx(() => DropdownButton<String>(
//                                       value: controller.selectedDeviceMake[index].value,
//                                       onChanged: (value) {
//                                         controller.selectedDeviceMake[index].value = value!;
//                                       },
//                                       items: ['KM002', 'KM003', 'KM004']
//                                           .map((e) => DropdownMenuItem(
//                                                 value: e,
//                                                 child: Text(e),
//                                               ))
//                                           .toList(),
//                                     )),
//                                 ],
//                               )),
//                               DataCell(
//                                 Obx(() => Switch(
//                                       value: controller.devices[index].value,
//                                       onChanged: (value) {
//                                         controller.devices[index].value = value;
//                                       }, activeColor: CustomColors.appColor, // This sets the active color to blue.
//                                     )),
//                               ),
//                               DataCell(
//                                 Obx(() => DropdownButton<String>(
//                                       value: controller.selectedDeviceMake[index].value,
//                                       onChanged: (value) {
//                                         controller.selectedDeviceMake[index].value = value!;
//                                       },
//                                       items: ['KM002', 'KM003', 'KM004']
//                                           .map((e) => DropdownMenuItem(
//                                                 value: e,
//                                                 child: Text(e),
//                                               ))
//                                           .toList(),
//                                     )),
//                               ),
//                               DataCell(
//                                 Obx(() => DropdownButton<String>(
//                                       value: controller.selectedBaudRate[index].value,
//                                       onChanged: (value) {
//                                         controller.selectedBaudRate[index].value = value!;
//                                       },
//                                       items: ['KM002', 'KM003', 'KM004']
//                                           .map((e) => DropdownMenuItem(
//                                                 value: e,
//                                                 child: Text(e),
//                                               ))
//                                           .toList(),
//                                     )),
//                               ),
//                             ]);
//                           }),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   Center(
//                     child: const Text(
//                       'Print Speed',
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Card(
//                 child: DataTable(
//                   headingRowColor: WidgetStateProperty.all(CustomColors.appColor),
//                   headingTextStyle: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   columnSpacing: 22, // Adjust spacing as needed
//                   dataRowMinHeight: 30,
//                   dataRowMaxHeight: 40,
//                   columns: const [
//                     DataColumn(label: Text('Delay (On/Off)')),
//                     DataColumn(label: Text('Input Speed')),
//                     DataColumn(label: Text('Set Button')),
//                   ],
//                   headingRowHeight: 33,
//                   horizontalMargin: 33,
//                   rows: List.generate(1, (index) {
//                     return DataRow(
//                       cells: [
//                         // Delay (On/Off) Cell
//                         DataCell(
//             Obx(
//               () => Switch(
//                 value: controller.printdevices[index].value,
//                 onChanged: (value) {
//                   controller.printdevices[index].value = value;
//                 },
//                 activeColor: CustomColors.appColor, // Custom color for "On" state
//               ),
//             ),
//                         ),
//                         // Input Speed Cell
//                         DataCell(
//             // Obx(
//             //   () =>
//               TextField(
//                 onChanged: (value) {
//                   controller.inputSpeed.value = value; // Updates observable value
//                 },
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Enter speed',
//                 ),
//               ),
//                          // ),
//                         ),
//                         // Set Button Cell
//                         DataCell(
//             // Obx(
//             //   () =>
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: Get.width * 0.01,
//                     vertical: Get.height * 0.001,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   backgroundColor: CustomColors.appGreenButtomColor, // Custom button color
//                 ),
//                 onPressed: () {
//                   // Perform desired action (e.g., save entry)
//                 },
//                 child: Text(
//                   'Set',
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: CustomColors.bgColor, // Custom text color
//                   ),
//                 ),
//               ),
//             //),
//                         ),
//                       ],
//                     );
//                   }),
//                 ),
//               ),
//             ),
//              //     const SizedBox(height: 24),
//
//
//               //     Row(
//               //       children: [
//               //         const Text('Delay (On/Off)'),
//               //         const SizedBox(width: 16),
//               //         Obx(() => Switch(
//               //               value: controller.delayEnabled.value,
//               //                activeColor: CustomColors.appColor,
//               //               onChanged: (value) {
//               //                 controller.delayEnabled.value = value;
//               //               },
//               //             )),
//               //       ],
//               //     ),
//
//
//               //     Row(
//               //           children: [
//               // const Text('Input Speed:'),
//               // const SizedBox(width: 16),
//               // Expanded(
//               //         // Remove Obx here because TextField doesn't need to rebuild.
//               //         child: TextField(
//               //           onChanged: (value) {
//               // controller.inputSpeed.value = value; // Updates observable value.
//               //           },
//               //           decoration: const InputDecoration(
//               // border: OutlineInputBorder(),
//               // hintText: 'Enter speed',
//               //           ),
//               //         ),
//               // ),
//               // const SizedBox(width: 16),
//               //    ElevatedButton(
//               //               style: ElevatedButton.styleFrom(
//               //                 padding: EdgeInsets.symmetric(
//               //                   horizontal: Get.width * 0.01,
//               //                   vertical: Get.height * 0.01,
//               //                 ),
//               //                 shape: RoundedRectangleBorder(
//               //                   borderRadius: BorderRadius.circular(10),
//               //                 ),
//               //                 backgroundColor: CustomColors.appGreenButtomColor,
//               //               ),
//               //               onPressed: () {
//               //               //  controller.saveEntry();
//               //               },
//               //               child: Text('Set',
//               //                   style: TextStyle(
//               //                       fontSize: 20, color: CustomColors.bgColor)),
//               //             ),
//
//               //           ],
//               //         ),
//               //         const SizedBox(height: 24),
//                         ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/common/custom_app_bar.dart';
import 'package:kanha_bmc/controller/setting_controller.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Setting',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Device Configuration Section
                Center(
                  child: const Text(
                    'Device Configuration',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(Color(0xFF00BFFF)),
                      headingTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      columnSpacing: 20,
                      dataRowMinHeight: 35,
                      dataRowMaxHeight: 40,
                      headingRowHeight: 40,
                      columns: const [
                        DataColumn(label: Text('List Devices')),
                        DataColumn(label: Text('On/Off')),
                        DataColumn(label: Text('Device Make')),
                        DataColumn(label: Text('Bude Rate')),
                      ],
                      rows: List.generate(5, (index) {
                        return DataRow(
                          cells: [
                            // List Devices Cell
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Device ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    height: 24, // Reduced by 30%
                                    padding: EdgeInsets.symmetric(horizontal: 6),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: 'EWS',
                                        style: TextStyle(fontSize: 10, color: Colors.black), // Reduced font size
                                        onChanged: (value) {
                                          // Handle change if needed
                                        },
                                        items: ['EWS', 'KM003', 'KM004']
                                            .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e, style: TextStyle(fontSize: 10)),
                                        ))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // On/Off Switch Cell
                            DataCell(
                              Obx(() => Transform.scale(
                                scale: 0.4, // Reduced by 30%
                                child: Switch(
                                  value: controller.devices[index].value,
                                  onChanged: (value) {
                                    controller.devices[index].value = value;
                                  },
                                  activeColor: Color(0xFF00BFFF),
                                ),
                              )),
                            ),
                            // Device Make Cell
                            DataCell(
                              Container(
                                height: 24, // Reduced by 30%
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: 'KM002',
                                    style: TextStyle(fontSize: 10, color: Colors.black), // Reduced font size
                                    onChanged: (value) {
                                      // Handle change if needed
                                    },
                                    items: ['KM002', 'KM003', 'KM004']
                                        .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e, style: TextStyle(fontSize: 10)),
                                    ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                            // Baud Rate Cell
                            DataCell(
                              Container(
                                height: 24, // Reduced by 30%
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: 'KM002',
                                    style: TextStyle(fontSize: 10, color: Colors.black), // Reduced font size
                                    onChanged: (value) {
                                      // Handle change if needed
                                    },
                                    items: ['KM002', 'KM003', 'KM004']
                                        .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e, style: TextStyle(fontSize: 10)),
                                    ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Print Speed Section
                Center(
                  child: const Text(
                    'Print Speed',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(Color(0xFF00BFFF)),
                      headingTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      columnSpacing: 30,
                      dataRowMinHeight: 35,
                      dataRowMaxHeight: 40,
                      headingRowHeight: 40,
                      columns: const [
                        DataColumn(label: Text('Delay (On/Off)')),
                        DataColumn(label: Text('Input Speed')),
                        DataColumn(label: Text('Set Button')),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            // Delay Switch Cell
                            DataCell(
                              Obx(() => Transform.scale(
                                scale: 0.4, // Reduced by 30%
                                child: Switch(
                                  value: controller.printdevices[0].value,
                                  onChanged: (value) {
                                    controller.printdevices[0].value = value;
                                  },
                                  activeColor: Color(0xFF00BFFF),
                                ),
                              )),
                            ),
                            // Input Speed Cell
                            DataCell(
                              Container(
                                width: 100,
                                child: Text(
                                  'KM002',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            // Set Button Cell
                            DataCell(
                              SizedBox(
                                height: 24,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Color(0xFF4CAF50), // Green color
                                  ),
                                  onPressed: () {
                                    // Perform desired action
                                  },
                                  child: Text(
                                    'Set',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}