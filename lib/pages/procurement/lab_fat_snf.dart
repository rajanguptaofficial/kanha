import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';

import '../../common/custom_app_bar.dart';
import '../../controller/procurement/lab_fat_snf_controller.dart';

class LabFatSnfFormScreen extends StatefulWidget {
  const LabFatSnfFormScreen({super.key});

  @override
  State<LabFatSnfFormScreen> createState() => _LabFatSnfFormScreenState();
}

class _LabFatSnfFormScreenState extends State<LabFatSnfFormScreen> {
  final LabFatSnfController controller = Get.put(LabFatSnfController());

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;

        return SafeArea(
          child: Scaffold(
                appBar: ProcCustomAppBar(title: 'Lab (FAT/SNF) '),
            body: Obx(
              () => controller.isForm1Visible.value
                  ? buildFirstForm(context, height, width, isPortrait)
                  : buildSecondForm(context, height, width, isPortrait),
            ),
          ),
        );
      },
    );
  }

  // First Form Widget
  Widget buildFirstForm(BuildContext context, double height, double width, bool isPortrait) {
    return Padding(
      padding: EdgeInsets.all(isPortrait ? 16.0 : 32.0), // Adjust padding based on orientation
      child: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: controller.selectedDock.value.isEmpty ? null : controller.selectedDock.value,
              items: ['Dock 1', 'Dock 2', 'Dock 3']
                  .map((dock) => DropdownMenuItem(
                        value: dock,
                        child: Text(dock),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.selectedDock.value = value!;
              },
              decoration: const InputDecoration(labelText: 'Select Dock'),
            ),
            SizedBox(height: height * 0.02),
            TextField(
              controller: TextEditingController(
                text: controller.selectedDate.value,
              ),
              decoration: const InputDecoration(
                labelText: 'Enter Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  controller.selectedDate.value = pickedDate.toIso8601String().split('T').first;
                }
              },
            ),
            SizedBox(height: height * 0.02),
            DropdownButtonFormField<String>(
              value: controller.selectedShift.value.isEmpty ? null : controller.selectedShift.value,
              items: ['Morning', 'Evening', 'Night']
                  .map((shift) => DropdownMenuItem(
                        value: shift,
                        child: Text(shift),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.selectedShift.value = value!;
              },
              decoration: const InputDecoration(labelText: 'Select Shift'),
            ),
            SizedBox(height: height * 0.04),
            ElevatedButton(
              onPressed: () {
                if (controller.selectedDock.value.isNotEmpty &&
                    controller.selectedDate.value.isNotEmpty &&
                    controller.selectedShift.value.isNotEmpty) {
                   controller.isForm1Visible.value = false; // Switch to Form 2
                } else {
                  Get.snackbar('Error', 'Please select all fields',
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: const Text('Go'),
            ),
          ],
        ),
      ),
    );
  }

  // Second Form Widget
  Widget buildSecondForm(BuildContext context, double height, double width, bool isPortrait) {
    return Padding(
      padding: EdgeInsets.all(isPortrait ? 16.0 : 32.0), // Adjust padding based on orientation
      child: SingleChildScrollView(
        child: Column(
          children: [

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
 
  children: [ 
    Padding(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        spacing: 43,
        children: [
          Text('Fat%',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),),
          Text('SNF%',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),), 
          Text('CLR',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),), 
        ],
      ),
    ), 
    
    Column(spacing: 13,
      children: [
        Text('MA1',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),),  
         Text('Sample1',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),),  
SizedBox(
  width: Get.width *.2,
  child:      TextFormField(
           //   controller: userNameController,
              decoration: InputDecoration(
                labelText: "User",
                fillColor: Colors.white,
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
                labelText: "User",
                fillColor: Colors.white,
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
                labelText: "User",
                fillColor: Colors.white,
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
    Column(spacing: 13,
      children: [
        Text('MA2',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),), 
         Text('Sample2',style: TextStyle(fontWeight:  FontWeight.w600,fontSize: 20),),   
SizedBox(
  width: Get.width *.2,
  child:      TextFormField(
           //   controller: userNameController,
              decoration: InputDecoration(
                labelText: "User",
                fillColor: Colors.white,
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
                labelText: "User",
                fillColor: Colors.white,
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
                labelText: "User",
                fillColor: Colors.white,
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
    ),],
),
 SizedBox(height: height * 0.02),
Text('Press F3,F4 for sample skip', style: TextStyle(fontSize: 17,)),
Divider(),   Obx(() => SingleChildScrollView( 
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                        child: DataTable(
                          columnSpacing: Get.width * 0.02, // Use Get.width for consistent spacing
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
                  
Divider(),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
