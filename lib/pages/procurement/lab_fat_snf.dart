// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/common/colors.dart';

// import '../../common/custom_app_bar.dart';
// import '../../controller/procurement/lab_fat_snf_controller.dart';

// class LabFatSnfFormScreen extends StatefulWidget {
//   const LabFatSnfFormScreen({super.key});

//   @override
//   State<LabFatSnfFormScreen> createState() => _LabFatSnfFormScreenState();
// }

// class _LabFatSnfFormScreenState extends State<LabFatSnfFormScreen> {
//   final LabFatSnfController controller = Get.put(LabFatSnfController());

//   @override
//   Widget build(BuildContext context) {
//     return OrientationBuilder(
//       builder: (context, orientation) {
//         final isPortrait = orientation == Orientation.portrait;
//         final height = MediaQuery.of(context).size.height;
//         final width = MediaQuery.of(context).size.width;

//         return SafeArea(
//           child: Scaffold(
//                 appBar: ProcCustomAppBar(title: 'Lab (FAT/SNF) '),
//             body: Obx(
//               () => controller.isForm1Visible.value
//                   ? buildFirstForm(context, height, width, isPortrait)
//                   : buildSecondForm(context, height, width, isPortrait),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // First Form Widget
//   Widget buildFirstForm(BuildContext context, double height, double width, bool isPortrait) {
//     return Padding(
//       padding: EdgeInsets.all(isPortrait ? 16.0 : 32.0), // Adjust padding based on orientation
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             DropdownButtonFormField<String>(
//               value: controller.selectedDock.value.isEmpty ? null : controller.selectedDock.value,
//               items: ['Dock 1', 'Dock 2', 'Dock 3']
//                   .map((dock) => DropdownMenuItem(
//                         value: dock,
//                         child: Text(dock),
//                       ))
//                   .toList(),   
//                    decoration: const InputDecoration(
//                       labelText:'Select Dock Type',
//                       border: OutlineInputBorder(),
//     labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     )
//                     ),
//               onChanged: (value) {
//                 controller.selectedDock.value = value!;
//               },
//               //decoration: const InputDecoration(labelText: 'Select '),
//             ),
//             SizedBox(height: height * 0.02),
//             TextField(
//               controller: TextEditingController(
//                 text: controller.selectedDate.value,
//               ),
//               decoration: const InputDecoration(
//                 labelText: 'Enter Date',
//                 suffixIcon: Icon(Icons.calendar_today),
//               ),
//               readOnly: true,
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2100),
//                 );
//                 if (pickedDate != null) {
//                   controller.selectedDate.value = pickedDate.toIso8601String().split('T').first;
//                 }
//               },
//             ),
//             SizedBox(height: height * 0.02),
//             DropdownButtonFormField<String>(
//               value: controller.selectedShift.value.isEmpty ? null : controller.selectedShift.value,
//               items: ['Morning', 'Evening', 'Night']
//                   .map((shift) => DropdownMenuItem(
//                         value: shift,
//                         child: Text(shift),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 controller.selectedShift.value = value!;
//               },
//            decoration: const InputDecoration(
//                       labelText:'Select Dock Type',
//                       border: OutlineInputBorder(),
//     labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     )
//                     ),
//             ),
//             SizedBox(height: height * 0.04),
//             ElevatedButton(
//               onPressed: () {
//                 if (controller.selectedDock.value.isNotEmpty &&
//                     controller.selectedDate.value.isNotEmpty &&
//                     controller.selectedShift.value.isNotEmpty) {
//                    controller.isForm1Visible.value = false; // Switch to Form 2
//                 } else {
//                   Get.snackbar('Error', 'Please select all fields',
//                       snackPosition: SnackPosition.BOTTOM);
//                 }
//               },
//               child: const Text('Go'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Second Form Widget
//   Widget buildSecondForm(BuildContext context, double height, double width, bool isPortrait) {
//     return Padding(
//       padding: EdgeInsets.all(isPortrait ? 16.0 : 32.0), // Adjust padding based on orientation
//       child: SingleChildScrollView(
//         child: Column(
//           children: [

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
 
//   children: [ 
//     Padding(
//       padding: const EdgeInsets.only(top: 23.0),
//       child: Column(
//         spacing: 43,
//         children: [
//           Text('Fat%',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),),
//           Text('SNF%',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),), 
//           Text('CLR',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),), 
//         ],
//       ),
//     ), 
    
//     Column(spacing: 13,
//       children: [
//         Text('MA1',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),),  
//          Text('Sample1',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),),  
// SizedBox(
//   width: Get.width *.2,
//   child:      TextFormField(
//            //   controller: userNameController,
//               decoration: InputDecoration(
//                 labelText: "User",
//                 fillColor: Colors.white,
//                 filled: true, labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),
//                // prefixIcon: const Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
// ), 
// SizedBox(
//   width: Get.width *.2,
//   child:      TextFormField(
//            //controller: userNameController,
//               decoration: InputDecoration(
//                 labelText: "User",
//                 fillColor: Colors.white, labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),
//                 filled: true,
//                // prefixIcon: const Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
// ),   SizedBox( width: Get.width *.2,
//   child:      TextFormField(
//            //   controller: userNameController,
//               decoration: InputDecoration(
//                 labelText: "User",
//                 fillColor: Colors.white, labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),
//                 filled: true,
//                // prefixIcon: const Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
// ),
//      ElevatedButton(style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.symmetric(
//           horizontal: Get.width * 0.01,
//           vertical: Get.height * 0.01,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         backgroundColor: CustomColors.appGreenButtomColor,
//       ),
//                           onPressed: () {
//                           //  controller.saveEntry();
//                           },
//                           child: Text('Save (F2)', style: TextStyle(fontSize: 17,color: CustomColors.bgColor)),
//                         ),
    
//       ],
//     ),
//     Column(spacing: 13,
//       children: [
//         Text('MA2',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),), 
//          Text('Sample2',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),),   
// SizedBox(
//   width: Get.width *.2,
//   child:      TextFormField(
//            //   controller: userNameController,
//               decoration: InputDecoration(
//                 labelText: "User",
//                 fillColor: Colors.white, labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),
//                 filled: true,
//                // prefixIcon: const Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
// ), 
// SizedBox(
//   width: Get.width *.2,
//   child:      TextFormField(
//            //controller: userNameController,
//               decoration: InputDecoration(
//                 labelText: "User",
//                 fillColor: Colors.white, labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),
//                 filled: true,
//                // prefixIcon: const Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
// ),   SizedBox( width: Get.width *.2,
//   child:      TextFormField(
//            //   controller: userNameController,
//               decoration: InputDecoration(
//                 labelText: "User",
//                 fillColor: Colors.white, labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),
//                 filled: true,
//                // prefixIcon: const Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
// ),
//  ElevatedButton(style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.symmetric(
//           horizontal: Get.width * 0.01,
//           vertical: Get.height * 0.01,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         backgroundColor: CustomColors.appGreenButtomColor,
//       ),
//                           onPressed: () {
//                           //  controller.saveEntry();
//                           },
//                           child: Text('Save(F8)', style: TextStyle(fontSize: 17,color: CustomColors.bgColor)),
//                         ),
    
//       ],
//     ),],
// ),
//  SizedBox(height: height * 0.02),
// Text('Press F3,F4 for sample skip', style: TextStyle(fontSize: 17,)),
// Divider(),   Obx(() => SingleChildScrollView( 
//                       scrollDirection: Axis.horizontal,
//                       child: SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                         child: DataTable(
//                           columnSpacing: Get.width * 0.02, // Use Get.width for consistent spacing
//                           columns: [
//                             DataColumn(label: Text('Sample No')),
//                             DataColumn(label: Text('Code')),
//                             DataColumn(label: Text('QTY')),
//                             DataColumn(label: Text('Fat')),
//                             DataColumn(label: Text('SNF')),
//                             DataColumn(label: Text('Rate')),
//                             DataColumn(label: Text('Amount')),
//                           ],
//                           rows: controller.savedEntries
//                               .map(
//                                 (entry) => DataRow(cells: [
//                                   DataCell(Text(entry['sampleNo']!)),
//                                   DataCell(Text(entry['code']!)),
//                                   DataCell(Text(entry['qty']!)),
//                                   DataCell(Text(entry['fat']!)),
//                                   DataCell(Text(entry['snf']!)),
//                                   DataCell(Text(entry['rate']!)),
//                                   DataCell(Text(entry['amount']!)),
//                                 ]),
//                               )
//                               .toList(),
//                         ),
//                       ),
//                     )),
                  
// Divider(),
//             SizedBox(height: height * 0.02),
//           ],
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/common/custom_app_bar.dart';
import 'package:kanha_bmc/controller/procurement/truck_arrival_controller.dart';

class LabFatSnfFormScreen extends StatefulWidget {

  const LabFatSnfFormScreen({super.key});

  @override
  State<LabFatSnfFormScreen> createState() => _TruckArrivalFormScreenState();
}


class _TruckArrivalFormScreenState extends State<LabFatSnfFormScreen> {
  final TruckArrivalController controller = Get.put(TruckArrivalController());

  final _formKey = GlobalKey<FormState>(); 
 
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProcCustomAppBar(title: 'Lab (FAT/SNF)'),
        body:
         Form(
           key: _formKey, // Associate the form key here
           child: OrientationBuilder(
            builder: (context, orientation) {
           
              final isPortrait = orientation == Orientation.portrait;
              final double padding = Get.width * 0.04;
           
              return Obx(() {
                 // controller.currentDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                  // controller.currentTime.value=   DateFormat('HH:mm').format(DateTime.now());
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 14),
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

 // First Form Widget
  Widget buildFirstForm() {
    return Column(
      children: [
        
        DropdownButtonFormField<String>(
          value: controller.dockCollData.contains(controller.selectedDockNo.value)
        ? controller.selectedDockNo.value
        : null, // Ensure value is in the list
          // decoration: const InputDecoration(labelText: 'Select Dock'),
          // hint: const Text("Select Dock No"),
          decoration: const InputDecoration(
                      labelText:'Select Dock No',
                      border: OutlineInputBorder(),
    labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    )
                    ),
          onChanged: (newValue) {
            if (newValue != null) {
         controller.selectedDockNo.value = newValue;
            }
          },
          items: controller.dockCollData.map<DropdownMenuItem<String>>((dockNo) {
            return DropdownMenuItem<String>(
        value: dockNo.toString(),
        child: Text(dockNo.toString()),
            );
          }).toList(), 
          validator: (value) =>
                      value == null || value.isEmpty ? 'Please select Dock Type' : null,
        ),
        
        
       SizedBox(height: Get.height * 0.02),
Obx(() => TextFormField(
          readOnly: true,
          controller: TextEditingController(
            text: DateFormat('yyyy-MM-dd').format(controller.selectedDate.value),
          ),
          decoration: InputDecoration(
            labelText: 'Select Date',
            border: OutlineInputBorder(),
    labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), ),
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => controller.pickDate(context),
            ),
          ),
          validator: (value) => value!.isEmpty ? 'Please select a date' : null,
        )),


        SizedBox(height: Get.height * 0.02),
      
        Obx(
      () => TextFormField(
        readOnly: true,
        controller: TextEditingController(text: controller.timeShift.value),
        decoration: InputDecoration(
          labelText: 'Shift',
    border: OutlineInputBorder(),
    labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    )
                    ),
        onTap: () => controller.selectShift(context),
        validator: (value) => value!.isEmpty ? 'Please select a shift' : null,
      ),
    ),

 SizedBox(height: Get.height * 0.02),

 ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07, vertical: Get.height * 0.01),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: CustomColors.appGreenButtomColor,
          ),
         onPressed: () {
          
if (_formKey.currentState!.validate()) {
      controller.isForm1Visible.value = false;
            } else {
              Get.snackbar('Error', 'Please select all fields',
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
        
          child: Text('Go', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
        ),
 SizedBox(height: Get.height * 0.02),
      ],
    );
  }


  Widget buildSecondForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
    
    Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
                  controller.currentDate.value,
                  style: TextStyle(fontSize: 18, 
                  //fontWeight: FontWeight.w800
                  ),
                )),
            Obx(() => Text(
                  controller.timeShift.value,
                  style: TextStyle(fontSize: 18, 
                  //fontWeight: FontWeight.w800
                  ),
                )),
          ],
        ),

    Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           
            children: [ 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 33,
                  children: [
                    SizedBox(height: Get.height * 0.011),
                    Text('Fat%',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),),
                    Text('SNF%',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),), 
                    Text('CLR  ',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),), 
                  ],
                ),
              ), 
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(spacing: 5,
                          children: [
                            Text('MA1',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),),  
                            Container(
                color: Colors.grey.shade400,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Sample1',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),),
                )),   
                          SizedBox(
                            width: Get.width *.2,
                            child:      TextFormField(
                 //   controller: userNameController,
                    decoration: InputDecoration(
                      //labelText: "User",
                      fillColor: Colors.white,
                      filled: true, labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
                enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
                ),
                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
                ),
                     // prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                          ), 
                          SizedBox(
                            width: Get.width *.2,
                            child:      TextFormField(
                 //controller: userNameController,
                    decoration: InputDecoration(
                     // labelText: "User",
                      fillColor: Colors.white, labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
                enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
                ),
                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
                ),
                      filled: true,
                     // prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                          ),   SizedBox( width: Get.width *.2,
                            child:      TextFormField(
                 //   controller: userNameController,
                    decoration: InputDecoration(
                     // labelText: "User",
                      fillColor: Colors.white, labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
                enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
                ),
                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
                ),
                      filled: true,
                     // prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                          ),
                 ElevatedButton(style: ElevatedButton.styleFrom(
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
                                //  controller.saveEntry();
                                },
                                child: Text('Save (F2)', style: TextStyle(fontSize: 17,color: CustomColors.bgColor)),
                              ),
                
                          ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(spacing: 5,
                          children: [
                            Text('MA2',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),), 
                             Container(
                color: Colors.grey.shade400,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Sample2',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),),
                )),   
                          SizedBox(
                            width: Get.width *.2,
                            child:      TextFormField(
                 //   controller: userNameController,
                    decoration: InputDecoration(
                     // labelText: "User",
                      fillColor: Colors.white, labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
                enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
                ),
                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
                ),
                      filled: true,
                     // prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                          ), 
                          SizedBox(
                            width: Get.width *.2,
                            child:      TextFormField(
                 //controller: userNameController,
                    decoration: InputDecoration(
                     // labelText: "User",
                      fillColor: Colors.white, labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
                enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
                ),
                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
                ),
                      filled: true,
                     // prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                          ),   SizedBox( width: Get.width *.2,
                            child:      TextFormField(
                 //   controller: userNameController,
                    decoration: InputDecoration(
                      //labelText: "User",
                      fillColor: Colors.white, labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
                enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
                ),
                focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
                ),
                      filled: true,
                     // prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                          ),
                           ElevatedButton(style: ElevatedButton.styleFrom(
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
                                //  controller.saveEntry();
                                },
                                child: Text('Save(F8)', style: TextStyle(fontSize: 17,color: CustomColors.bgColor)),
                              ),
                
                          ],
                ),
              ),],
          ),
        SizedBox(height: Get.height * 0.01),
    Text('Press F3,F4 for sample skip', style: TextStyle(fontSize: 17,fontWeight: FontWeight.w800)),
       SizedBox(height: Get.height * 0.01),
        ],
      ),
    ),
    
    
    
              
                
    
          // SizedBox(height: height * 0.02),
        ],
      ),
    );
  }


//   // Second Form Widget
//   Widget buildSecondForm() {
//     return Column(
//       children: [
        
        
//         DropdownButtonFormField<String>(
//     value: controller.routeData.contains(controller.selectedRoute.value)
//         ? controller.selectedRoute.value
//         : null, // Set to null if not found in list
   
//     //hint: const Text("Select Route"),
//     onChanged: (newValue) {
//       if (newValue != null) {
//        controller.selectedRoute.value = newValue;
//        controller.fetchCompnyCodeByRuteCodeName(controller.selectedRoute.value);
//       }
//     },  decoration: const InputDecoration(
//                       labelText:'Select Route ',
//                       border: OutlineInputBorder(),
//     labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     )
//                     ),
//     validator: (value) =>
//                       value == null || value.isEmpty ? 'Please select Route Type' : null,
//     items: controller.routeData.toSet().map<DropdownMenuItem<String>>((route) { 
//       return DropdownMenuItem<String>(
//         value: route,
//         child: Text(route),
//       );
//     }).toList(),
//         ),
        
//          SizedBox(height: Get.height * 0.02),
      
  
//  Obx(() => TextFormField(
//           readOnly: true,
//           controller:   TextEditingController(text: controller.currentTime.value.toString()),
//           decoration: InputDecoration(
//             labelText: 'Time',
//             border: OutlineInputBorder(),
//             suffixIcon: IconButton(
//               icon: Icon(Icons.access_time),
//               onPressed: () => controller.selectTime(context),
//             ),
//           ),
//           validator: (value) => value!.isEmpty ? 'Please select a time' : null,
//         )),
  



//         SizedBox(height: Get.height * 0.02),
//         TextField(
//           decoration: const InputDecoration(labelText: 'Enter Truck No.'),
//           onChanged: (value) {
//             controller.truckNumber.value = value;
//           },
//         ),
//         SizedBox(height: Get.height * 0.02),
//         _buildButtons(),
//         SizedBox(height: Get.height * 0.02),
//        ],
//     );
//   }


  Widget _buildPortraitLayout(double padding) {
    return SingleChildScrollView(
      child: Column(
        children: [
      controller.isForm1Visible.value ? buildFirstForm() : buildSecondForm(), 
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: buildDataTable(),
          ),
        ),
        ],
      ),
    );
  
  }

Widget _buildLandscapeLayout(double padding) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                //color:Colors.red,
               width: Get.width*.4,
                child: Column(
                  children: [
                     controller.isForm1Visible.value ? buildFirstForm() : buildSecondForm(),
                        // SizedBox(height: Get.width * 0.01),    
                       
                        // SizedBox(height: Get.width * 0.01),   
                    
                        SizedBox(height: Get.width * 0.01),
                       // _buildButtons(),
                       SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: buildDataTable(),
                       ),
                  ],
                ),
              ),
            ),
         
          ],
        ),
    
    
        // Making Data Table more adaptable in Landscape
       
      ],
    ),
  );
}

 Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07, vertical: Get.height * 0.01),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: CustomColors.appGreenButtomColor,
          ),
         onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Process data if form is valid
           
    Future.wait([
        controller.saveEntry()
    ]).then((_) {
           _formKey.currentState!.reset(); 
    });
            }

          },
          child: Text('Save', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
        ),
       
      ],
    );
  }

  Widget buildDataTable() {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:


 SizedBox( width: Get.width,
   child: DataTable(
        headingRowColor:
            WidgetStateProperty.all(CustomColors.appColor),
        headingTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold),
        columnSpacing: 12,
        dataRowMinHeight: 20,
        dataRowMaxHeight: 40,
        headingRowHeight: 33,
        columns: const [
   
      DataColumn(label: Text('Sample No.')),
      DataColumn(label: Text('Fat %')),
      DataColumn(label: Text('Snf %')),
      DataColumn(label: Text('Clr %')),
      
   
   
        ],
        rows: List.generate(controller.truckArrivalDBData.length, (index) {
          final data = controller.truckArrivalDBData[index];
          final isGrey = index % 2 == 0;
          return DataRow(
            color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[200]),
            cells: [
   
   DataCell(Center(child: Text("${data["sampleId"]}"))),
   DataCell(Center(child: Text("${data['dumpDate']}"))),
   DataCell(Center(child: Text("${data['shift']}"))),
   DataCell(Center(child: Text("${data['truckNo']}"))),

   
      
            ],
          );
        }),
      ),
 )));}
}




 