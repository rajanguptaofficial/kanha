import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/common/custom_app_bar.dart';
import '../../controller/procurement/member_collection.dart';

class MemberCollectionScreen extends StatelessWidget {
  final controller = Get.put(MemberCollectionController());
  MemberCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProcCustomAppBar(title: 'Member Collection'),
        body: OrientationBuilder(
          builder: (context, orientation) {
            bool isPortrait = orientation == Orientation.portrait;
            double padding =
                Get.width * 0.04; // Use Get.width for consistent padding
            double fontSize =
                Get.width * 0.04; // Font size based on screen width

            return Padding(
              padding: EdgeInsets.all(padding),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Date and time in a row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${controller.currentDate.value.toLocal()}'
                                    .split(' ')[0],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                            )),
                        Obx(() => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controller.timeShift.value,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                            )),
                      ],
                    ),

                    SizedBox(height: padding),

                    // Code and Member Name input fields in row, adjust based on orientation
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Member Code',
                              border: OutlineInputBorder(),
                            ),

                            onChanged: (value) {
                              controller.code.value = value;
                              controller.fetchMemberNameDetails(value);
                            },

                            controller: TextEditingController(
                                    text: controller.code.value),
                          ),
                        ),
                        SizedBox(width: padding),
                        Expanded(
                          child: TextFormField(
                               // readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Member Name',
                                  border: OutlineInputBorder(),
                                ),
                                
                            onChanged: (value) {
                              controller.memberName.value = value;
                              controller.fetchOtherCodeByFirstName(value);
                            },
                                controller: TextEditingController(
                                    text: controller.memberName.value),
                              ),
                        ),
                      ],
                    ),

                    SizedBox(height: padding),
       
        // Milk Type dropdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(padding * 0.5),
                          child: Text(
                            'Milk Type:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => DropdownButton<String>(
                              value: controller.milkType.value.isNotEmpty
                                  ? controller.milkType.value
                                  : null,
                              hint: Text('Select Milk Type'),
                              isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                  value: 'Cow',
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/cow.png",
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBox(width: 8),
                                      Text('Cow'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Buff',
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/buff.png",
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBox(width: 8),
                                      Text('Buff'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Mix',
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/mix.png",
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBox(width: 8),
                                      Text('Mix'),
                                    ],
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  controller.milkType.value = value;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: padding),

                    // QTY, Fat, SNF input fields (adjusted based on orientation)

                    if (isPortrait)
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'QTY (L)',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              // onChanged: (value) {
                              //   controller.qty.value = value;
                              //   controller.calculateRateAndAmount();
                              // },
                            ),
                          ),
                          SizedBox(width: padding),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Fat',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              // onChanged: (value) {
                              //   controller.fat.value = value;
                              //   controller.calculateRateAndAmount();
                              // },
                            ),
                          ),
                          SizedBox(width: padding),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'SNF',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              // onChanged: (value) {
                              //   controller.snf.value = value;
                              //   controller.calculateRateAndAmount();
                              // },
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'QTY (L)',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  // onChanged: (value) {
                                  //   controller.qty.value = value;
                                  //   controller.calculateRateAndAmount();
                                  // },
                                ),
                              ),
                              SizedBox(width: padding),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Fat',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  // onChanged: (value) {
                                  //   controller.fat.value = value;
                                  //   controller.calculateRateAndAmount();
                                  // },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: padding),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'SNF',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  // onChanged: (value) {
                                  //   controller.snf.value = value;
                                  //   controller.calculateRateAndAmount();
                                  // },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    SizedBox(height: padding),

                    // Rate and Amount input fields
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Rate',
                                  border: OutlineInputBorder(),
                                ),
                                controller: TextEditingController(
                                    text: controller.rate.value),
                              )),
                        ),
                        SizedBox(width: padding),
                        Expanded(
                          child: Obx(() => TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Amount',
                                  border: OutlineInputBorder(),
                                ),
                                controller: TextEditingController(
                                    text: controller.amount.value),
                              )),
                        ),
                      ],
                    ),

                    SizedBox(height: padding),

                    // Save Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.01,
                              vertical: Get.height * 0.01,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: CustomColors.appGreenButtomColor,
                          ),
                          onPressed: () {
                        //    controller.saveEntry();
                          },
                          child: Text('Save',
                              style: TextStyle(
                                  fontSize: 20, color: CustomColors.bgColor)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.01,
                              vertical: Get.height * 0.01,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: CustomColors.appRedButtomColor,
                          ),
                          onPressed: () {
                          //  controller.clearCollections();
                          },
                          child: Text('Clear Data',
                              style: TextStyle(
                                  fontSize: 20, color: CustomColors.bgColor)),
                        ),
                      ],
                    ),

                    SizedBox(height: padding),

                    // Saved Entries Table
                    Obx(() => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                            child: DataTable(
                              columnSpacing: Get.width *
                                  0.02, // Use Get.width for consistent spacing
                              columns: [
                                DataColumn(label: Text('Sample No')),
                                DataColumn(label: Text('Code')),
                                DataColumn(label: Text('QTY')),
                                DataColumn(label: Text('Fat')),
                                DataColumn(label: Text('SNF')),
                                DataColumn(label: Text('Rate')),
                                DataColumn(label: Text('Amount')),
                              ],
                              rows: controller.savedEntries
                                  .map(
                                    (entry) => DataRow(cells: [
                                      DataCell(Text(entry['sampleNo']!)),
                                      DataCell(Text(entry['code']!)),
                                      DataCell(Text(entry['qty']!)),
                                      DataCell(Text(entry['fat']!)),
                                      DataCell(Text(entry['snf']!)),
                                      DataCell(Text(entry['rate']!)),
                                      DataCell(Text(entry['amount']!)),
                                    ]),
                                  )
                                  .toList(),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/common/colors.dart';
// import 'package:kanha_bmc/common/custom_app_bar.dart';
// import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';
// import '../../controller/procurement/member_collection.dart';

// class MemberCollectionScreen extends StatelessWidget {
//   final controller = Get.put(MemberCollectionController());
//   final controller2 = Get.put(RateCheckMasterController());

//   MemberCollectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: ProcCustomAppBar(title: 'Member Collection'),
//         body: OrientationBuilder(
//           builder: (context, orientation) {
//             final isPortrait = orientation == Orientation.portrait;
//             final double padding = Get.width * 0.04;

//             return Obx(() {
//               controller.rate.value = controller2.rtpl.value;
//               double rateValue = double.tryParse(controller.rate.value) ?? 0.0;
//               double qtyValue = double.tryParse(controller.qty.value) ?? 0.0;
//               controller.amountValue.value = rateValue * qtyValue;

//               return Padding(
//                 padding: EdgeInsets.all(padding),
//                 child: SingleChildScrollView(
//                   child: isPortrait
//                       ? _buildPortraitLayout(padding)
//                       : _buildLandscapeLayout(padding),
//                 ),
//               );
//             });
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildPortraitLayout(double padding) {
//     return Column(
//       children: [
//         // Date and Time Row
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Obx(() => Text(
//                   '${controller.currentDate.value.toLocal()}'.split(' ')[0],
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//                 )),
//             Obx(() => Text(
//                   controller.timeShift.value,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//                 )),
//           ],
//         ),
//         SizedBox(height: padding),

//         // Member Details
//         _buildMemberDetailsRow(padding),

//         SizedBox(height: padding),

//         // Fat and SNF Fields
//         _buildFatSnfRow(padding),

//         SizedBox(height: padding),

//         // Quantity and Milk Type Fields
//         _buildQtyMilkTypeRow(padding),

//         SizedBox(height: padding),

//         // Rate and Amount Fields
//         _buildRateAmountRow(padding),

//         SizedBox(height: padding),

//         // Buttons
//         _buildButtons(),

//         SizedBox(height: padding),

//         // Saved Entries Table
//         _buildSavedEntriesTable(),
//       ],
//     );
//   }

//   Widget _buildLandscapeLayout(double padding) {
//     return Column(
//       children: [
//         // Date and Time Row
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Obx(() => Text(
//                   '${controller.currentDate.value.toLocal()}'.split(' ')[0],
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//                 )),
//             Obx(() => Text(
//                   controller.timeShift.value,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//                 )),
//           ],
//         ),
//         SizedBox(height: padding),

//         // Member, Fat, and SNF Fields in a Single Row
//         Row(
//           children: [
//             Expanded(child: _buildMemberDetailsRow(padding)),
//             SizedBox(width: padding),
//             Expanded(child: _buildFatSnfRow(padding)),
//           ],
//         ),

//         SizedBox(height: padding),

//         // Quantity, Milk Type, Rate, and Amount in a Single Row
//         Row(
//           children: [
//             Expanded(child: _buildQtyMilkTypeRow(padding)),
//             SizedBox(width: padding),
//             Expanded(child: _buildRateAmountRow(padding)),
//           ],
//         ),

//         SizedBox(height: padding),

//         // Buttons and Table
//         _buildButtons(),
//         SizedBox(height: padding),
//         _buildSavedEntriesTable(),
//       ],
//     );
//   }

//   Widget _buildMemberDetailsRow(double padding) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextFormField(
//             decoration: InputDecoration(
//               labelText: 'Member Code',
//               border: OutlineInputBorder(),
//             ),
//             onChanged: (value) {
//               controller.code.value = value;
//               controller.fetchMemberNameDetails(value);
//             },
//             controller: TextEditingController(text: controller.code.value),
//           ),
//         ),
//         SizedBox(width: padding),
//         Expanded(
//           child: TextFormField(
//             decoration: InputDecoration(
//               labelText: 'Member Name',
//               border: OutlineInputBorder(),
//             ),
//             onChanged: (value) {
//               controller.memberName.value = value;
//               controller.fetchOtherCodeByFirstName(value);
//             },
//             controller: TextEditingController(text: controller.memberName.value),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFatSnfRow(double padding) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextFormField(
//             decoration: InputDecoration(
//               labelText: 'Fat',
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.number,
//             onChanged: (value) {
//               controller2.fat.value = value;
//               controller2.filterData();
//               controller.calculateAmountValue();
//             },
//           ),
//         ),
//         SizedBox(width: padding),
//         Expanded(
//           child: TextFormField(
//             decoration: InputDecoration(
//               labelText: 'SNF',
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.number,
//             onChanged: (value) {
//               controller2.snf.value = value;
//               controller2.filterData();
//               controller.calculateAmountValue();
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildQtyMilkTypeRow(double padding) {
//     return Row(
//       children: [
//         Expanded(
//           child: TextFormField(
//             decoration: InputDecoration(
//               labelText: 'QTY (L)',
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.number,
//             onChanged: (value) {
//               controller.qty.value = value;
//               controller.calculateAmountValue();
//             },
//             controller: TextEditingController(text: controller.qty.value),
//           ),
//         ),
//         SizedBox(width: padding),
//         Expanded(
//           child: Obx(() => DropdownButton<String>(
//                 value: controller2.selectedMilkType.value.isEmpty
//                     ? null
//                     : controller2.selectedMilkType.value,
//                 hint: Text('Select Milk Type'),
//                 isExpanded: true,
//                 items: [
//                   DropdownMenuItem(
//                     value: 'Cow',
//                     child: Row(
//                       children: [
//                         Image.asset("assets/icons/cow.png", width: 24, height: 24),
//                         SizedBox(width: 8),
//                         Text('Cow'),
//                       ],
//                     ),
//                   ),
//                   DropdownMenuItem(
//                     value: 'Buff',
//                     child: Row(
//                       children: [
//                         Image.asset("assets/icons/buff.png", width: 24, height: 24),
//                         SizedBox(width: 8),
//                         Text('Buff'),
//                       ],
//                     ),
//                   ),
//                   DropdownMenuItem(
//                     value: 'Mixed',
//                     child: Row(
//                       children: [
//                         Image.asset("assets/icons/mix.png", width: 24, height: 24),
//                         SizedBox(width: 8),
//                         Text('Mixed'),
//                       ],
//                     ),
//                   ),
//                 ],
//                 onChanged: (value) {
//                   controller2.selectedMilkType.value = value!;
//                   controller2.filterData();
//                   controller.calculateAmountValue();
//                 },
//               )),
//         ),
//       ],
//     );
//   }

//   Widget _buildRateAmountRow(double padding) {
//     return Row(
//       children: [
//         Expanded(
//           child: Obx(() => TextFormField(
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   labelText: 'Rate',
//                   border: OutlineInputBorder(),
//                 ),
//                 controller: TextEditingController(text: controller.rate.value),
//               )),
//         ),
//         SizedBox(width: padding),
//         Expanded(
//           child: Obx(() => TextFormField(
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   labelText: 'Amount',
//                   border: OutlineInputBorder(),
//                 ),
//                 controller: TextEditingController(
//                     text: controller.amountValue.value.toStringAsFixed(2)),
//               )),
//         ),
//       ],
//     );
//   }

//   Widget _buildButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             backgroundColor: CustomColors.appGreenButtomColor,
//           ),
//           onPressed: () {
//             // controller.saveEntry();
//           },
//           child: Text('Save', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             backgroundColor: CustomColors.appRedButtomColor,
//           ),
//           onPressed: () {
//             // controller.clearCollections();
//           },
//           child: Text('Clear Data', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
//         ),
//       ],
//     );
//   }

//   Widget _buildSavedEntriesTable() {
//     return Obx(() => SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: DataTable(
//             columnSpacing: Get.width * 0.02,
//             columns: [
//               DataColumn(label: Text('Sample No')),
//               DataColumn(label: Text('Code')),
//               DataColumn(label: Text('QTY')),
//               DataColumn(label: Text('Fat')),
//               DataColumn(label: Text('SNF')),
//               DataColumn(label: Text('Rate')),
//               DataColumn(label: Text('Amount')),
//             ],
//             rows: controller.savedEntries.map(
//               (entry) {
//                 return DataRow(cells: [
//                   DataCell(Text(entry['sampleNo']!)),
//                   DataCell(Text(entry['code']!)),
//                   DataCell(Text(entry['qty']!)),
//                   DataCell(Text(entry['fat']!)),
//                   DataCell(Text(entry['snf']!)),
//                   DataCell(Text(entry['rate']!)),
//                   DataCell(Text(entry['amount']!)),
//                 ]);
//               },
//             ).toList(),
//           ),
//         ));
//   }
// }
