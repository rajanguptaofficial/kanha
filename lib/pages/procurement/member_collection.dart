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
//                   controller.currentDate.value,
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
//         buildDataTable(),
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
//                    controller.currentDate.value,
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
//         buildDataTable(),
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
//            controller.saveEntry();
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

//   Widget buildDataTable() {
//     return Obx(() => SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child:


//  DataTable(
//       headingRowColor:
//           WidgetStateProperty.all(CustomColors.appColor),
//       headingTextStyle: const TextStyle(
//           color: Colors.white, fontWeight: FontWeight.bold),
//       columnSpacing: 12,
//       dataRowMinHeight: 20,
//       dataRowMaxHeight: 40,
//       headingRowHeight: 33,
//       columns: const [

//                      DataColumn(label: Text('S. No.')),
//     DataColumn(label: Text('Code')),
//     DataColumn(label: Text('Qty')),
//     DataColumn(label: Text('Fat')),
//     DataColumn(label: Text('SNF')),
//     DataColumn(label: Text('Rate')),
//     DataColumn(label: Text('Amount')),

//       ],
//       rows: List.generate(controller.memberCollData.length, (index) {
//         final data = controller.memberCollData[index];
//         final isGrey = index % 2 == 0;
//         return DataRow(
//           color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[200]),
//           cells: [


//    DataCell(Center(child: Text("${data["sample_no"]}"))),
//       DataCell(Center(child: Text("${data['member_code']}"))),
//          DataCell(Center(child: Text("${data['qty']}"))),
//             DataCell(Center(child: Text("${data['fat']}"))),
//               DataCell(Center(child: Text(data['snf'].toString()))), 
//                DataCell(Center(child: Text(data['rate'].toString()  ))), 
//                 DataCell(Center(child: Text(data["amount"].toString()  ))),            
//           ],
//         );
//       }),
//     )));}
//   }








import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/common/custom_app_bar.dart';
import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';
import '../../controller/procurement/member_collection.dart';

class MemberCollectionScreen extends StatelessWidget {
  final controller = Get.put(MemberCollectionController());
  final controller2 = Get.put(RateCheckMasterController());
  final _formKey = GlobalKey<FormState>(); // Global key for form validation

 final TextEditingController _codeController = TextEditingController();


  MemberCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProcCustomAppBar(title: 'Member Collection'),
        body:
         Form(
           key: _formKey, // Associate the form key here
           child: OrientationBuilder(
            builder: (context, orientation) {
              final isPortrait = orientation == Orientation.portrait;
              final double padding = Get.width * 0.04;
           
              return Obx(() {
                // Update calculated values based on inputs
                controller.rate.value = controller2.rtpl.value;
                double rateValue = double.tryParse(controller.rate.value) ?? 0.0;
                double qtyValue = double.tryParse(controller.qty.value) ?? 0.0;
                controller.amountValue.value = rateValue * qtyValue;
                controller.fat.value = controller2.fat.value;
                controller.snf.value = controller2.snf.value;
           
                return Padding(
                  padding: EdgeInsets.all(padding),
                  child: isPortrait
                      ? _buildPortraitLayout(padding)
                      : _buildLandscapeLayout(padding),
                );
              });
            },
                   ),
         ),
      ),
    );
  }

  Widget _buildPortraitLayout(double padding) {
    return Column(
      children: [
        // Static content
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
                  controller.currentDate.value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )),
                  Obx(() => Text(
              controller.timeShift.value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            )),
          ],
        ),
      
        SizedBox(height: padding),

        _buildMemberDetailsRow(padding),

        SizedBox(height: padding),

        _buildFatSnfRow(padding),

        SizedBox(height: padding),

        _buildQtyMilkTypeRow(padding),

        SizedBox(height: padding),

        _buildRateAmountRow(padding),

        SizedBox(height: padding),

        _buildButtons(),

        SizedBox(height: padding),

        // Scrollable Data Table
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: buildDataTable(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(double padding) {
    return Column(
      children: [
        // Static content
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
                  controller.currentDate.value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )),
            Obx(() => Text(
                  controller.timeShift.value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )),
          ],
        ),
        SizedBox(height: padding),

        Row(
          children: [
            Expanded(child: _buildMemberDetailsRow(padding)),
            SizedBox(width: padding),
            Expanded(child: _buildFatSnfRow(padding)),
          ],
        ),
        SizedBox(height: padding),

        Row(
          children: [
            Expanded(child: _buildQtyMilkTypeRow(padding)),
            SizedBox(width: padding),
            Expanded(child: _buildRateAmountRow(padding)),
          ],
        ),
        SizedBox(height: padding),

        _buildButtons(),

        SizedBox(height: padding),

        // Scrollable Data Table
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: buildDataTable(),
            ),
          ),
        ),
      ],
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
            
            //controller: TextEditingController(text: controller.code.value),
            validator: (value) =>
                value!.isEmpty ? 'Please enter Member Code' : null,
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
            controller:
                TextEditingController(text: controller.memberName.value),
            validator: (value) =>
                value!.isEmpty ? 'Please enter Member Name' : null,
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
            validator: (value) => value!.isEmpty ? 'Please enter Fat' : null,
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
            validator: (value) => value!.isEmpty ? 'Please enter SNF' : null,
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
            validator: (value) =>
                value!.isEmpty ? 'Please enter Quantity' : null,
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
                  controller2.selectedMilkType.value = value ?? '';
                  controller2.filterData();
                  controller.calculateAmountValue();
                  controller.milkType.value = controller2.selectedMilkType.value;
             
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please select Milk Type' : null,
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
                controller:
                    TextEditingController(text: controller.amountValue.value.toString()),
              )),
        ),
      ],
    );
  }
 
 Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: CustomColors.appGreenButtomColor,
          ),
         onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Process data if form is valid
           
    Future.wait([
        controller.saveEntry()
    ]).then((_) {
      // Call afterSyncing to handle post-sync actions after both fetches complete
            //  controller.rate.value = "";
            //     //  rateValue
            //     //  qtyValue
               controller.amountValue.value =  0.0;
            //     controller.fat.value = "";
            //     controller.snf.value = "";
              controller.milkType.value = ""; 
                controller.qty.value = "";
            //      controller.memberName.value = "";
            //       controller.code.value = "";
                 controller2.selectedMilkType.value= "";



          controller.clearCollections();
            _formKey.currentState!.reset(); // Reset form validation state
           controller.clearCollections();
           controller2.selectedMilkType.value = ""; // Clear all data
    });
            }

          },
          child: Text('Save', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: CustomColors.appRedButtomColor,
          ),
          onPressed: () {
            controller.clearCollections();
            _formKey.currentState!.reset(); // Reset form validation state
           controller.clearCollections();
           controller2.selectedMilkType.value = ""; // Clear all data
          },
          child: Text('Clear Data', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
        ),
      ],
    );
  }
 
 
  Widget buildDataTable() {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:


 DataTable(
      headingRowColor:
          WidgetStateProperty.all(CustomColors.appColor),
      headingTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold),
      columnSpacing: 12,
      dataRowMinHeight: 20,
      dataRowMaxHeight: 40,
      headingRowHeight: 33,
      columns: const [

                     DataColumn(label: Text('S. No.')),
    DataColumn(label: Text('Code')),
    DataColumn(label: Text('Qty')),
    DataColumn(label: Text('Fat')),
    DataColumn(label: Text('SNF')),
    DataColumn(label: Text('Rate')),
    DataColumn(label: Text('Amount')),

      ],
      rows: List.generate(controller.memberCollData.length, (index) {
        final data = controller.memberCollData[index];
        final isGrey = index % 2 == 0;
        return DataRow(
          color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[200]),
          cells: [


 DataCell(Center(child: Text("${data["sample_no"]}"))),
DataCell(Center(child: Text("${data['member_code']}"))),
DataCell(Center(child: Text("${data['qty']}"))),
DataCell(Center(child: Text("${data['fat']}"))),
DataCell(Center(child: Text((double.tryParse(data['snf'].toString())?.toStringAsFixed(2)) ?? "0.00"))),
DataCell(Center(child: Text((double.tryParse(data['rate'].toString())?.toStringAsFixed(2)) ?? "0.00"))),
DataCell(Center(child: Text((double.tryParse(data["amount"].toString())?.toStringAsFixed(2)) ?? "0.00"))),
    
          ],
        );
      }),
    )));}
  }


