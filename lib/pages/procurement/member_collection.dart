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
//               controller.fat.value = controller2.fat.value;
//                controller.snf.value = controller2.snf.value;
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

//     // // Milk Type Dropdown
//     //     Obx(() => DropdownButtonFormField<String>(
//     //           value: controller2.selectedMilkType.value.isEmpty
//     //               ? null
//     //               : controller2.selectedMilkType.value,
//     //           items: controller2.milkTypes
//     //               .map((type) => DropdownMenuItem(
//     //                     value: type,
//     //                     child: Text(type),
//     //                   ))
//     //               .toList(),
//     //           onChanged: (value) {
//     //             controller2.selectedMilkType.value = value!;
//     //             controller2.filterData(); // Trigger filter on change
//     //           },
//     //           decoration: const InputDecoration(
//     //             labelText: "Milk Type",
//     //             border: OutlineInputBorder(),
//     //           ),
//     //         )),


//     //     const SizedBox(height: 16),


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
//               controller.fat.value = controller2.fat.value;      
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
//               controller.snf.value = controller2.snf.value;
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
//                   onChanged: (value) {
//                   controller2.selectedMilkType.value = value!;
//                   controller2.filterData();
//                   controller.calculateAmountValue();
//                   controller.milkType.value = controller2.selectedMilkType.value;
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
//            //controller.saveEntry();
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



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/custom_app_bar.dart';
import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';
import '../../controller/procurement/member_collection.dart';

class MemberCollectionScreen extends StatelessWidget {
  final controller = Get.put(MemberCollectionController());
  final controller2 = Get.put(RateCheckMasterController());
  final _formKey = GlobalKey<FormState>(); // Global key for form validation

  MemberCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProcCustomAppBar(title: 'Member Collection'),
        body: OrientationBuilder(
          builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;
            final double padding = Get.width * 0.04;

            return Obx(() {
              controller.rate.value = controller2.rtpl.value;
              double rateValue = double.tryParse(controller.rate.value) ?? 0.0;
              double qtyValue = double.tryParse(controller.qty.value) ?? 0.0;
              controller.amountValue.value = rateValue * qtyValue;
              controller.fat.value = controller2.fat.value;
              controller.snf.value = controller2.snf.value;
              return Padding(
                padding: EdgeInsets.all(padding),
                child: SingleChildScrollView(
                  child: isPortrait
                      ? _buildPortraitLayout(padding)
                      : _buildLandscapeLayout(padding),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(double padding) {
    return Form(
      key: _formKey, // Form widget to validate fields
      child: Column(
        children: [
          // Date and Time Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                    '${controller.currentDate.value.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  )),
              Obx(() => Text(
                    controller.timeShift.value,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  )),
            ],
          ),
          SizedBox(height: padding),

          // Member Details
          _buildMemberDetailsRow(padding),

          SizedBox(height: padding),

          // Fat and SNF Fields
          _buildFatSnfRow(padding),

          SizedBox(height: padding),

          // Quantity and Milk Type Fields
          _buildQtyMilkTypeRow(padding),

          SizedBox(height: padding),

          // Rate and Amount Fields
          _buildRateAmountRow(padding),

          SizedBox(height: padding),

          // Buttons
          _buildButtons(),

          SizedBox(height: padding),

          // Saved Entries Table
          _buildSavedEntriesTable(),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout(double padding) {
    return Form(
      key: _formKey, // Form widget to validate fields
      child: Column(
        children: [
          // Date and Time Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                    '${controller.currentDate.value.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  )),
              Obx(() => Text(
                    controller.timeShift.value,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  )),
            ],
          ),
          SizedBox(height: padding),

          // Member, Fat, and SNF Fields in a Single Row
          Row(
            children: [
              Expanded(child: _buildMemberDetailsRow(padding)),
              SizedBox(width: padding),
              Expanded(child: _buildFatSnfRow(padding)),
            ],
          ),

          SizedBox(height: padding),

          // Quantity, Milk Type, Rate, and Amount in a Single Row
          Row(
            children: [
              Expanded(child: _buildQtyMilkTypeRow(padding)),
              SizedBox(width: padding),
              Expanded(child: _buildRateAmountRow(padding)),
            ],
          ),

          SizedBox(height: padding),

          // Buttons and Table
          _buildButtons(),
          SizedBox(height: padding),
          _buildSavedEntriesTable(),
        ],
      ),
    );
  }

  Widget _buildMemberDetailsRow(double padding) {
    return Row(
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
            controller: TextEditingController(text: controller.code.value),
            validator: (value) => value!.isEmpty ? 'Please enter Member Code' : null, // Field validation
          ),
        ),
        SizedBox(width: padding),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Member Name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              controller.memberName.value = value;
              controller.fetchOtherCodeByFirstName(value);
            },
            controller: TextEditingController(text: controller.memberName.value),
            validator: (value) => value!.isEmpty ? 'Please enter Member Name' : null, // Field validation
          ),
        ),
      ],
    );
  }

  Widget _buildFatSnfRow(double padding) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Fat',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              controller2.fat.value = value;
              controller2.filterData();
              controller.calculateAmountValue();
              controller.fat.value = controller2.fat.value;      
            },
            validator: (value) => value!.isEmpty ? 'Please enter Fat' : null, // Field validation
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
            onChanged: (value) {
              controller2.snf.value = value;
              controller2.filterData();
              controller.calculateAmountValue();
              controller.snf.value = controller2.snf.value;
            },
            validator: (value) => value!.isEmpty ? 'Please enter SNF' : null, // Field validation
          ),
        ),
      ],
    );
  }

  Widget _buildQtyMilkTypeRow(double padding) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'QTY (L)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              controller.qty.value = value;
              controller.calculateAmountValue();
            },
            controller: TextEditingController(text: controller.qty.value),
            validator: (value) => value!.isEmpty ? 'Please enter Quantity' : null, // Field validation
          ),
        ),
        SizedBox(width: padding),
        Expanded(
          child: Obx(() => DropdownButtonFormField<String>(
                value: controller2.selectedMilkType.value.isEmpty
                    ? null
                    : controller2.selectedMilkType.value,
                hint: Text('Select Milk Type'),
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: 'Cow',
                    child: Row(
                      children: [
                        Image.asset("assets/icons/cow.png", width: 24, height: 24),
                        SizedBox(width: 8),
                        Text('Cow'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Buff',
                    child: Row(
                      children: [
                        Image.asset("assets/icons/buff.png", width: 24, height: 24),
                        SizedBox(width: 8),
                        Text('Buff'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Mixed',
                    child: Row(
                      children: [
                        Image.asset("assets/icons/mix.png", width: 24, height: 24),
                        SizedBox(width: 8),
                        Text('Mixed'),
                      ],
                    ),
                  ),
                ],

   onChanged: (value) {
          if (value != null) { // Check to ensure value is not null
            controller2.selectedMilkType.value = value;
            controller2.filterData();
            controller.calculateAmountValue();
            controller.milkType.value = controller2.selectedMilkType.value;
          }
        },
        validator: (value) => value == null || value.isEmpty
            ? 'Please select Milk Type'
            : null, // Field validation
    
                // onChanged: (value) {
                //   controller2.selectedMilkType.value = value!;
                //   controller2.filterData();
                //   controller.calculateAmountValue();
                //   controller.milkType.value = controller2.selectedMilkType.value;
                // },
                // validator: (value) => value == null ? 'Please select Milk Type' : null, // Field validation
              )),
        ),
      ],
    );
  }

  Widget _buildRateAmountRow(double padding) {
    return Row(
      children: [
        Expanded(
          child: Obx(() => TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Rate',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: controller.rate.value),
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
                controller: TextEditingController(text: controller.amountValue.value.toString()),
              )),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Process data if form is valid
              controller.saveEntry();
              //controller.getSampleNo();
            }
          },
          child: Text('Submit'),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            _formKey.currentState!.reset(); // Reset form validation state
           controller.clearCollections();
           controller2.selectedMilkType.value = ""; // Clear all data
          },
          child: Text('Clear Data'),
        ),
      ],
    );
  }

  Widget _buildSavedEntriesTable() {
    return Container(
      // Add your saved entries table here
    );
  }
}
