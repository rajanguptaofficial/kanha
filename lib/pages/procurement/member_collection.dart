// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/common/colors.dart';
// import 'package:kanha_bmc/common/custom_app_bar.dart';
// import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';
// import '../../controller/procurement/member_collection.dart';
//
// class MemberCollectionScreen extends StatelessWidget {
//
//   MemberCollectionScreen({super.key});
//
//   final controller = Get.put(MemberCollectionController());
//
//   final controller2 = Get.put(RateCheckMasterController());
//
//   final _formKey = GlobalKey<FormState>();
//
// final TextEditingController qtyController = TextEditingController();
//  final TextEditingController memberController = TextEditingController();
//
//  // Persistent controller
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: ProcCustomAppBar(title: 'Member Collection'),
//         body:
//          Form(
//            key: _formKey, // Associate the form key here
//            child: OrientationBuilder(
//             builder: (context, orientation) {
//               final isPortrait = orientation == Orientation.portrait;
//               final double padding = Get.width * 0.04;
//
//               return Obx(() {
//
//
//
//     // Listen for changes in qty.value and update the text field
//     ever(controller.qty, (value) {
//       qtyController.text = value;
//       qtyController.selection = TextSelection.fromPosition(
//         TextPosition(offset: qtyController.text.length),
//       );
//     });
//
//
//   ever(controller.memberName, (value) {
//       memberController.text = value;
//       memberController.selection = TextSelection.fromPosition(
//         TextPosition(offset: memberController.text.length),
//       );
//     });
//
//
//           // qtyController.text = controller.qty.value; // Update the text field
//           // qtyController.selection = TextSelection.fromPosition(
//           //   TextPosition(offset: qtyController.text.length), // Keep cursor at the end
//           // );
//
//
//
//                 // Update calculated values based on inputs
//                 controller.rate.value = controller2.rtpl.value;
//                 double rateValue = double.tryParse(controller.rate.value) ?? 0.0;
//                 double qtyValue = double.tryParse(controller.qty.value) ?? 0.0;
//                 controller.amountValue.value = rateValue * qtyValue;
//                 controller.fat.value = controller2.fat.value;
//                 controller.snf.value = controller2.snf.value;
//
//                 return Padding(
//                   padding: EdgeInsets.symmetric(vertical: 5,horizontal: 14),
//                   child: isPortrait
//                       ? _buildPortraitLayout(padding)
//                       : _buildLandscapeLayout(padding),
//                 );
//               });
//             },
//                    ),
//          ),
//       ),
//     );
//   }
//
//   Widget _buildPortraitLayout(double padding) {
//     return Column(
//       children: [
//         // Static content
//         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Obx(() => Text(
//                   controller.currentDate.value,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//                 )),
//                   Obx(() => Text(
//               controller.timeShift.value,
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//             )),
//           ],
//         ),
//
//         SizedBox(height: padding),
//
//         _buildMemberDetailsRow(padding),
//
//         SizedBox(height: padding),
//         _buildQtyMilkTypeRow(padding),
//
//         SizedBox(height: padding),
//         _buildFatSnfRow(padding),
//
//         SizedBox(height: padding),
//
//
//
//         _buildRateAmountRow(padding),
//
//         SizedBox(height: padding),
//
//         _buildButtons(),
//
//         SizedBox(height: padding),
//
//         // Scrollable Data Table
//         Expanded(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: buildDataTable(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
// Widget _buildLandscapeLayout(double padding) {
//   return SingleChildScrollView(
//     child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Obx(() => Text(
//                   controller.currentDate.value,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//                 )),
//             Obx(() => Text(
//                   controller.timeShift.value,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//                 )),
//           ],
//         ),
//
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Container(
//                 //color:Colors.red,
//                width: Get.width*.4,
//                 child: Column(
//                   children: [
//                     Row(
//            children: [
//              Expanded(
//           child:
//
//  // Adjust height as needed
// TextFormField(
//     keyboardType: TextInputType.number,
//     decoration: InputDecoration(
//       labelText: 'Member Code',
//       border: OutlineInputBorder(),
//       labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),// Default border
//     ),
//
//
//
//     style: TextStyle(fontSize: 14),
//     onChanged: (value) {
//       controller.membercode.value = value;
//       controller.fetchMemberNameDetails(value);
//     },
//     validator: (value) => value!.isEmpty ? 'Please enter Member Code' : null,
//   ),
//
//         ),
//         SizedBox(width: padding),
//         Expanded(
//           child: TextFormField(
//              keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//               labelText: 'Member Name',
//               border: OutlineInputBorder(),
//                 labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),// Default border
//
//             ),
//             onChanged: (value) {
//               controller.memberName.value = value;
//               controller.fetchOtherCodeByFirstName(value);
//             },
//             controller: memberController,
//             validator: (value) =>
//                 value!.isEmpty ? 'Please enter Member Name' : null,
//           ),
//         ),
//
//        SizedBox(width: padding),
//     ],
//          ),
//
//                        SizedBox(height: Get.width * 0.01),
//                         Row(
//         children: [
//            Padding(
//                  padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.061),
//              child: Text("Milk Type :", style: TextStyle(fontWeight: FontWeight.bold),         ),
//            ),
//           SizedBox(width: padding),
//        Expanded(
//             child: Obx(() => DropdownButtonFormField<String>(
//                   value: controller2.selectedMilkType.value.isEmpty
//                       ? null
//                       : controller2.selectedMilkType.value,
//                      decoration: const InputDecoration(
//                       labelText:'Milk Type',
//                       border: OutlineInputBorder(),
//     labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     )
//                     ),
//                   isExpanded: true,
//                   items: [
//                     DropdownMenuItem(
//                       value: 'Cow',
//                       child: Row(
//                         children: [
//                           Image.asset("assets/icons/cow.png", width: 24, height: 24),
//                           SizedBox(width: 8),
//                           Text('Cow'),
//                         ],
//                       ),
//                     ),
//
//                     DropdownMenuItem(
//                       value: 'Buff',
//                       child: Row(
//                         children: [
//                           Image.asset("assets/icons/buff.png", width: 24, height: 24),
//                           SizedBox(width: 8),
//                           Text('Buff'),
//                         ],
//                       ),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Mixed',
//                       child: Row(
//                         children: [
//                           Image.asset("assets/icons/mix.png", width: 24, height: 24),
//                           SizedBox(width: 8),
//                           Text('Mixed'),
//                         ],
//                       ),
//                     ),
//                   ],
//                   onChanged: (value) {
//                     controller2.selectedMilkType.value = value ?? '';
//                     controller2.filterData();
//                     controller.calculateAmountValue();
//                     controller.milkType.value = controller2.selectedMilkType.value;
//
//                   },
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Please select Milk Type' : null,
//                 )),
//           ),
//
//
//
//
//    ],
//       ),
//                        SizedBox(height: Get.width * 0.01),
//                        Row(
//                          children: [
//                            SizedBox(height: Get.width * 0.01),
//
//          Expanded(
//           child: TextFormField(
//             decoration: InputDecoration(
//               labelText: 'QTY (L)',
//                border: OutlineInputBorder(),
//               labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),// Default border
//             ),
//             keyboardType: TextInputType.number,
//
//             onChanged: (value) {
//               controller.qty.value = value;
//               controller.calculateAmountValue();
//             },
//             controller: qtyController,
//             validator: (value) =>
//                 value!.isEmpty ? 'Please enter Quantity' : null,
//           ),
//         ),
//           SizedBox(width: padding),
//         Expanded(
//           child: TextFormField(
//             decoration: InputDecoration(
//               labelText: 'Fat',
//                border: OutlineInputBorder(),
//                 labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),// Default border
//             ),
//             keyboardType: TextInputType.number,
//             onChanged: (value) {
//               controller2.fat.value = value;
//               controller2.filterData();
//               controller.calculateAmountValue();
//               controller.fat.value = controller2.fat.value;
//             },
//             validator: (value) => value!.isEmpty ? 'Please enter Fat' : null,
//           ),
//         ),
//         SizedBox(width: padding),
//         Expanded(
//           child: TextFormField(
//             decoration: InputDecoration(
//               labelText: 'SNF',
//                border: OutlineInputBorder(),
//                 labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),// Default border
//             ),
//             keyboardType: TextInputType.number,
//             onChanged: (value) {
//               controller2.snf.value = value;
//               controller2.filterData();
//               controller.calculateAmountValue();
//               controller.snf.value = controller2.snf.value;
//             },
//             validator: (value) => value!.isEmpty ? 'Please enter SNF' : null,
//           ),
//         ),
//
//                          ],
//                        ),
//                         SizedBox(height: Get.width * 0.01),
//                         _buildRateAmountRow(padding),
//                         SizedBox(height: Get.width * 0.01),
//                         _buildButtons(),
//                         SizedBox(height: Get.width * 0.01),
//                          SingleChildScrollView(
//                          scrollDirection: Axis.horizontal,
//                          child: buildDataTable(),
//                        ),
//               //            Expanded(
//               //   child: Container(
//               // // color:Colors.green,
//               //    child: Padding(
//               //      padding: const EdgeInsets.all(8.0),
//               //      child: Column(
//               //        children: [
//               //          SingleChildScrollView(
//               //            scrollDirection: Axis.horizontal,
//               //            child: buildDataTable(),
//               //          ),
//               //        ],
//               //      ),
//               //    ),
//               //                ),
//               // ),
//
//                   ],
//                 ),
//               ),
//             ),
//              ],
//         ),
//
//
//         // Making Data Table more adaptable in Landscape
//
//       ],
//     ),
//   );
// }
//
//   Widget _buildMemberDetailsRow(double padding) {
//     return Row(
//       children: [
//         Expanded(
//
//             child: TextFormField( keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Member Code',
//                  border: OutlineInputBorder(),
//                   labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),// Default border
//               ),
//               onChanged: (value) {
//                 controller.membercode.value = value;
//                 controller.fetchMemberNameDetails(value);
//               },
//
//               //controller: TextEditingController(text: controller.code.value),
//               validator: (value) =>
//                   value!.isEmpty ? 'Please enter Member Code' : null,
//             ),
//
//         ),
//         SizedBox(width: padding),
//         Expanded(
//           child: TextFormField( keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//               labelText: 'Member Name',
//                border: OutlineInputBorder(),
//                 labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),// Default border
//             ),
//             onChanged: (value) {
//               controller.memberName.value = value;
//               controller.fetchOtherCodeByFirstName(value);
//             },
//             controller:memberController,
//             validator: (value) =>
//                 value!.isEmpty ? 'Please enter Member Name' : null,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildFatSnfRow(double padding) {
//     return Row(
//       children: [
//
// Expanded(
//   child: TextFormField(
//               controller: qtyController,
//               decoration: InputDecoration(
//                 labelText: 'QTY (L)',
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
//                  labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),// Default border
//               ),
//               keyboardType: TextInputType.number,
//               onChanged: (value) {
//                 controller.qty.value = value;
//                 controller.calculateAmountValue();
//               },
//               validator: (value) => value!.isEmpty ? 'Please enter Quantity' : null,
//             ),
// ),
//
//
//
//         // Expanded(
//         //   child: SizedBox( height: 50,
//         //     child: TextFormField(
//         //       decoration: InputDecoration(
//         //         labelText: 'QTY (L)',
//         //          border: OutlineInputBorder(),
//         //
//         //       ),
//         //       keyboardType: TextInputType.number,
//         //       onChanged: (value) {
//         //         controller.qty.value = value;
//         //         controller.calculateAmountValue();
//         //       },
//         //       controller: qtyController,
//         //       validator: (value) =>
//         //           value!.isEmpty ? 'Please enter Quantity' : null,
//         //     ),
//         //   ),
//         // ),
//
//
//
//           SizedBox(width: padding),
//         Expanded(
//           child: TextFormField(
//             decoration: InputDecoration(
//               labelText: 'Fat',
//                border: OutlineInputBorder(),
//                 labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),// Default border
//             ),
//             keyboardType: TextInputType.number,
//             onChanged: (value) {
//               controller2.fat.value = value;
//               controller2.filterData();
//               controller.calculateAmountValue();
//               controller.fat.value = controller2.fat.value;
//             },
//             validator: (value) => value!.isEmpty ? 'Please enter Fat' : null,
//           ),
//         ),
//         SizedBox(width: padding),
//         Expanded(
//           child: TextFormField(
//             decoration: InputDecoration(
//               labelText: 'SNF',
//                border: OutlineInputBorder(),
//                 labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),// Default border
//             ),
//             keyboardType: TextInputType.number,
//             onChanged: (value) {
//               controller2.snf.value = value;
//               controller2.filterData();
//               controller.calculateAmountValue();
//               controller.snf.value = controller2.snf.value;
//             },
//             validator: (value) => value!.isEmpty ? 'Please enter SNF' : null,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildQtyMilkTypeRow(double padding) {
//     return Padding(
//       padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.11),
//       child:
//       Row(
//         children: [
//            Padding(
//                  padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.061),
//              child: Text("Milk Type", style: TextStyle(fontWeight: FontWeight.bold),         ),
//            ),
//           SizedBox(width: padding),
//         Expanded(
//             child: Obx(() => DropdownButtonFormField<String>(
//                   value: controller2.selectedMilkType.value.isEmpty
//                       ? null
//                       : controller2.selectedMilkType.value,
//                      decoration: const InputDecoration(
//                       labelText:'Milk Type',
//                       border: OutlineInputBorder(),
//     labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     )
//                     ),
//                   isExpanded: true,
//                   items: [
//                     DropdownMenuItem(
//                       value: 'Cow',
//                       child: Row(
//                         children: [
//                           Image.asset("assets/icons/cow.png", width: 24, height: 24),
//                           SizedBox(width: 8),
//                           Text('Cow'),
//                         ],
//                       ),
//                     ),
//
//                     DropdownMenuItem(
//                       value: 'Buff',
//                       child: Row(
//                         children: [
//                           Image.asset("assets/icons/buff.png", width: 24, height: 24),
//                           SizedBox(width: 8),
//                           Text('Buff'),
//                         ],
//                       ),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Mixed',
//                       child: Row(
//                         children: [
//                           Image.asset("assets/icons/mix.png", width: 24, height: 24),
//                           SizedBox(width: 8),
//                           Text('Mixed'),
//                         ],
//                       ),
//                     ),
//                   ],
//                   onChanged: (value) {
//                     controller2.selectedMilkType.value = value ?? '';
//                     controller2.filterData();
//                     controller.calculateAmountValue();
//                     controller.milkType.value = controller2.selectedMilkType.value;
//
//                   },
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Please select Milk Type' : null,
//                 )),
//           ),
//
//
//
//    ],
//       ),
//     );
//   }
//
//   Widget _buildRateAmountRow(double padding) {
//     return Row(
//       children: [
//         Expanded(
//           child: Obx(() => TextFormField(
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   labelText: 'Rate',
//                    border: OutlineInputBorder(),
//              labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),// Default border
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
//                    border: OutlineInputBorder(),
//               labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),// Default border
//                 ),
//                 controller:
//                     TextEditingController(text: controller.amountValue.value.toString()),
//               )),
//         ),
//       ],
//     );
//   }
//
//  Widget _buildButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07, vertical: Get.height * 0.01),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             backgroundColor: CustomColors.appGreenButtomColor,
//           ),
//          onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               // Process data if form is valid
//
//     Future.wait([
//         controller.saveEntry()
//     ]).then((_) {
//           controller.amountValue.value =  0.0;
//           controller.qty.value = "";
//           controller.clearCollections();
//             _formKey.currentState!.reset(); // Reset form validation state
//            controller.clearCollections();
//            //controller2.selectedMilkType.value = ""; // Clear all data
//     });
//             }
//
//           },
//           child: Text('Save', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
//         ),
//         // ElevatedButton(
//         //   style: ElevatedButton.styleFrom(
//         //     padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
//         //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         //     backgroundColor: CustomColors.appRedButtomColor,
//         //   ),
//         //   onPressed: () {
//         //     controller.clearCollections();
//         //     _formKey.currentState!.reset(); // Reset form validation state
//         //    controller.clearCollections();
//         //    controller2.selectedMilkType.value = ""; // Clear all data
//         //   },
//         //   child: Text('Clear Data', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
//         // ),
//       ],
//     );
//   }
//
//   Widget buildDataTable() {
//     return Obx(() => SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child:
//
//
//  SizedBox(
//   width: Get.width,
//    child: DataTable(
//         headingRowColor:
//             WidgetStateProperty.all(CustomColors.appColor),
//         headingTextStyle: const TextStyle(
//             color: Colors.white, fontWeight: FontWeight.bold),
//         columnSpacing: 12,
//         dataRowMinHeight: 20,
//         dataRowMaxHeight: 40,
//         headingRowHeight: 33,
//         columns: const [
//
//      DataColumn(label: Text('S. No.')),
//       DataColumn(label: Text('Code')),
//       DataColumn(label: Text('Qty')),
//       DataColumn(label: Text('Fat')),
//       DataColumn(label: Text('SNF')),
//       DataColumn(label: Text('Rate')),
//       DataColumn(label: Text('Amount')),
//
//         ],
//         rows: List.generate(controller.memberCollData.length, (index) {
//           final data = controller.memberCollData[index];
//           final isGrey = index % 2 == 0;
//           return DataRow(
//             color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[200]),
//             cells: [
//
//
//    DataCell(Center(child: Text("${data["sample_no"]}"))),
//    DataCell(Center(child: Text("${data['member_code']}"))),
//    DataCell(Center(child: Text("${data['qty']}"))),
//    DataCell(Center(child: Text("${data['fat']}"))),
//    DataCell(Center(child: Text((double.tryParse(data['snf'].toString())?.toStringAsFixed(2)) ?? "0.00"))),
//    DataCell(Center(child: Text((double.tryParse(data['rate'].toString())?.toStringAsFixed(2)) ?? "0.00"))),
//    DataCell(Center(child: Text((double.tryParse(data["amount"].toString())?.toStringAsFixed(2)) ?? "0.00"))),
//
//             ],
//           );
//         }),
//       ),
//  )));}
// }
//
//
//
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/common/custom_app_bar.dart';
import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';
import '../../controller/procurement/member_collection.dart';

class MemberCollectionScreen extends StatelessWidget {
  MemberCollectionScreen({super.key});

  final controller = Get.put(MemberCollectionController());
  final controller2 = Get.put(RateCheckMasterController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController memberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProcCustomAppBar(title: 'Member Collection'),
        body: Form(
          key: _formKey,
          child: Obx(() {
            // Listen for changes in qty.value and update the text field
            ever(controller.qty, (value) {
              qtyController.text = value;
              qtyController.selection = TextSelection.fromPosition(
                TextPosition(offset: qtyController.text.length),
              );
            });

            ever(controller.memberName, (value) {
              memberController.text = value;
              memberController.selection = TextSelection.fromPosition(
                TextPosition(offset: memberController.text.length),
              );
            });

            // Update calculated values based on inputs
            controller.rate.value = controller2.rtpl.value;
            double rateValue = double.tryParse(controller.rate.value) ?? 0.0;
            double qtyValue = double.tryParse(controller.qty.value) ?? 0.0;
            controller.amountValue.value = rateValue * qtyValue;
            controller.fat.value = controller2.fat.value;
            controller.snf.value = controller2.snf.value;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Date and Time Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF00BFFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today, color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Obx(() => Text(
                              controller.currentDate.value,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF00BFFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.access_time, color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Obx(() => Text(
                              controller.timeShift.value,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Main Form Card
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Code and Member Name Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Code',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Member Code',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Color(0xFF00BFFF)),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    ),
                                    onChanged: (value) {
                                      controller.membercode.value = value;
                                      controller.fetchMemberNameDetails(value);
                                    },
                                    validator: (value) => value!.isEmpty ? 'Please enter Member Code' : null,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Member Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Obx(() => Text(
                                            controller.memberName.value.isEmpty
                                                ? 'Yaksh Verma'
                                                : controller.memberName.value,
                                            style: TextStyle(fontSize: 14),
                                          )),
                                        ),
                                        Icon(Icons.arrow_drop_down, color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Milk Type Selection
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildMilkTypeOption('Cow', 'assets/icons/cow.png'),
                            _buildMilkTypeOption('Buff', 'assets/icons/buff.png'),
                            _buildMilkTypeOption('Mix', 'assets/icons/mix.png'),
                          ],
                        ),

                        SizedBox(height: 20),

                        // Qty, Fat, SNF Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Qty (L)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    controller: qtyController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Qty',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Color(0xFF00BFFF)),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    ),
                                    onChanged: (value) {
                                      controller.qty.value = value;
                                      controller.calculateAmountValue();
                                    },
                                    validator: (value) => value!.isEmpty ? 'Please enter Quantity' : null,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fat%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Fat',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Color(0xFF00BFFF)),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    ),
                                    onChanged: (value) {
                                      controller2.fat.value = value;
                                      controller2.filterData();
                                      controller.calculateAmountValue();
                                      controller.fat.value = controller2.fat.value;
                                    },
                                    validator: (value) => value!.isEmpty ? 'Please enter Fat' : null,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Snf%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Snf',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(color: Color(0xFF00BFFF)),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    ),
                                    onChanged: (value) {
                                      controller2.snf.value = value;
                                      controller2.filterData();
                                      controller.calculateAmountValue();
                                      controller.snf.value = controller2.snf.value;
                                    },
                                    validator: (value) => value!.isEmpty ? 'Please enter SNF' : null,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        // RTPL and Amount Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'RTPL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      border: Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Obx(() => Text(
                                      controller.rate.value.isEmpty ? '00' : controller.rate.value,
                                      style: TextStyle(fontSize: 14),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Amount',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      border: Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Obx(() => Text(
                                      controller.amountValue.value == 0.0 ? '00' : controller.amountValue.value.toString(),
                                      style: TextStyle(fontSize: 14),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24),

                        // Save Button
                        Center(
                          child: SizedBox(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Color(0xFF4CAF50),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Future.wait([
                                    controller.saveEntry()
                                  ]).then((_) {
                                    controller.amountValue.value = 0.0;
                                    controller.qty.value = "";
                                    controller.clearCollections();
                                    _formKey.currentState!.reset();
                                    controller.clearCollections();
                                  });
                                }
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Data Table
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: buildDataTable(),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildMilkTypeOption(String type, String iconPath) {
    return Obx(() => GestureDetector(
      onTap: () {
        controller2.selectedMilkType.value = type;
        controller2.filterData();
        controller.calculateAmountValue();
        controller.milkType.value = controller2.selectedMilkType.value;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: controller2.selectedMilkType.value == type
              ? Color(0xFF4CAF50)
              : Colors.transparent,
          border: Border.all(
            color: controller2.selectedMilkType.value == type
                ? Color(0xFF4CAF50)
                : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(iconPath, width: 20, height: 20),
            SizedBox(width: 6),
            Text(
              type,
              style: TextStyle(
                color: controller2.selectedMilkType.value == type
                    ? Colors.white
                    : Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            if (controller2.selectedMilkType.value == type)
              Container(
                margin: EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    ));
  }

  Widget buildDataTable() {
    return Obx(() => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(Color(0xFF00BFFF)),
          headingTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          columnSpacing: 16,
          dataRowMinHeight: 40,
          dataRowMaxHeight: 45,
          headingRowHeight: 40,
          columns: const [
            DataColumn(label: Text('Sample no.')),
            DataColumn(label: Text('Code')),
            DataColumn(label: Text('Qty')),
            DataColumn(label: Text('Fat')),
            DataColumn(label: Text('Snf')),
            DataColumn(label: Text('Rate')),
            DataColumn(label: Text('Amount')),
          ],
          rows: List.generate(controller.memberCollData.length, (index) {
            final data = controller.memberCollData[index];
            final isGrey = index % 2 == 0;
            return DataRow(
              color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[100]),
              cells: [
                DataCell(Center(child: Text("${data["sample_no"]}", style: TextStyle(fontSize: 12)))),
                DataCell(Center(child: Text("${data['member_code']}", style: TextStyle(fontSize: 12)))),
                DataCell(Center(child: Text("${data['qty']}", style: TextStyle(fontSize: 12)))),
                DataCell(Center(child: Text("${data['fat']}", style: TextStyle(fontSize: 12)))),
                DataCell(Center(child: Text((double.tryParse(data['snf'].toString())?.toStringAsFixed(2)) ?? "0.00", style: TextStyle(fontSize: 12)))),
                DataCell(Center(child: Text((double.tryParse(data['rate'].toString())?.toStringAsFixed(2)) ?? "0.00", style: TextStyle(fontSize: 12)))),
                DataCell(Center(child: Text((double.tryParse(data["amount"].toString())?.toStringAsFixed(2)) ?? "0.00", style: TextStyle(fontSize: 12)))),
              ],
            );
          }),
        ),
      ),
    ));
  }
}
