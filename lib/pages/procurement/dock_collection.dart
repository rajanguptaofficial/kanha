import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import '../../common/custom_app_bar.dart';
import '../../controller/procurement/dock_collection_controller.dart';

class DockCollectionScreen extends StatelessWidget {
  final controller = Get.put(DockCollectionController());

  DockCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;
            double padding = Get.width * 0.04; // Use Get.width for consistent padding
            double fontSize = Get.width * 0.04; // Font size based on screen width

        return Scaffold(
          appBar: ProcCustomAppBar(title:('Dock/Weight Collection'),
          ),
          body: Obx(
            () => controller.isForm1Visible.value
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
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

                         DropdownButtonFormField<String>(
                            value: controller.selectedGrade.value.isEmpty ? null : controller.selectedGrade.value,
                            items: ['Grade 1', 'Grade 2', 'Grade 3']
                                .map((dock) => DropdownMenuItem(
                                      value: dock,
                                      child: Text(dock),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              controller.selectedGrade.value = value!;
                            },
                            decoration: const InputDecoration(labelText: 'Select Grade'),
                          ),
                          SizedBox(height: height * 0.02),
                          DropdownButtonFormField<String>(
                            value: controller.selectedShift.value.isEmpty ? null : controller.selectedShift.value,
                           items: ['Sample 1', 'Sample 2', 'Sample 3']
                                .map((shift) => DropdownMenuItem(
                                      value: shift,
                                      child: Text(shift),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              controller.selectedShift.value = value!;
                            },
                            decoration: const InputDecoration(labelText: 'Select Sample'),
                          ),
                          SizedBox(height: height * 0.04),
                          ElevatedButton(
                            onPressed: () {
                              if (controller.selectedDock.value.isNotEmpty &&
                                  controller.selectedGrade.value.isNotEmpty &&
                                  controller.selectedShift.value.isNotEmpty) {
                                controller.isForm1Visible.value = false;
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
                  )
                :    Padding(
              padding: EdgeInsets.all(8),
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
                  '${controller.currentDate.value.toLocal()}'.split(' ')[0],
                  style: TextStyle(fontSize: 16),
                ),
              )),
          Obx(() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.timeShift.value,
                  style: TextStyle(fontSize: 16),
                ),
              )),
                      ],
                    ),

                    SizedBox(height: 4),

                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Text("Total Qty/Can : " , style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              Text("1000/250", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),                                         
                            ],
                    ),
                   SizedBox(height: 4),
                  
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Code',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              controller.code.value = value;
                              controller.fetchMemberDetails(value);
                            },
                          ),
                        ),
                        SizedBox(width: padding),
                        Expanded(
                          child: Obx(() => TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Society Name',
                                  border: OutlineInputBorder(),
                                ),
                                controller: TextEditingController(
                                    text: controller.memberName.value),
                              )),
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
                            style: TextStyle(fontSize: fontSize),
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

                  
                  
                    if (isPortrait)
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Can',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                controller.qty.value = value;
                                controller.calculateRateAndAmount();
                              },
                            ),
                          ),
                          SizedBox(width: padding),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Weight',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                controller.fat.value = value;
                                controller.calculateRateAndAmount();
                              },
                            ),
                          ),
                          SizedBox(width: padding),
                        
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
                                    labelText: 'Can',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    controller.qty.value = value;
                                    controller.calculateRateAndAmount();
                                  },
                                ),
                              ),
                              SizedBox(width: padding),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Weight',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    controller.fat.value = value;
                                    controller.calculateRateAndAmount();
                                  },
                                ),
                              ),
                            ],
                          ),
                       
                        ]
                      ),

                    SizedBox(height: padding),

                    // Save Button
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                            controller.saveEntry();
                          },
                          child: Text('Save', style: TextStyle(fontSize: fontSize,color: CustomColors.bgColor)),
                        ),
                          ElevatedButton(style: ElevatedButton.styleFrom(
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
                        controller.clearCollections();
                      },
                      child: Text('Clear Data', style: TextStyle(fontSize: fontSize,color: CustomColors.bgColor)),
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
                  ],
                ),
              ),
            )
          
          ),
        );
      },
    );
  }
}

