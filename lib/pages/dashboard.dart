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
        appBar: CustomAppBar(
          title:"Dashboard"
        ),
         drawer:  CustomDrawer(),
        body: 
        OrientationBuilder(
            builder: (context, orientation) {
              return 
             SingleChildScrollView(
              padding: EdgeInsets.all(Get.width * 0.02),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(Get.width * 0.02),
                    child: const Text(
                      'BMA-0011 Pawan Dwivedi',
                      style: TextStyle(
                          color: CustomColors.appColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Date Picker
                        Expanded(
                          flex: 1,
                          child:
                          
                           Obx(
                            () => TextFormField(
                              readOnly: true,
                              controller: TextEditingController(
                                text:controller.selectedDate.value.isEmpty ? "Select Date" : controller.selectedDate.value
                                                      
                                
                                //  controller.selectedDate.value.isNotEmpty
                                //     ? controller.selectedDate.value
                                //     : "Select Date",
                              ),
                              decoration: const InputDecoration(
                                labelText: "Select Date",
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_month),
                              ),
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
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.04),
                        // Dropdown for Morning/Evening
                        Expanded(
                          flex: 1,
                          child: Obx(
                            () => DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: "Select Time",
                                border: OutlineInputBorder(),
                              ),
                              value: controller.selectedTime.value,
                              items: ["Morning", "Evening"]
                                  .map(
                                    (String time) => DropdownMenuItem<String>(
                                      value: time,
                                      child: Text(time),
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
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  // RMRD Collection Section
                  _buildSectionCard(
                    title: 'RMRD Collection',
                    data: [
                      _buildInfoCard('5', 'Total MPP'),
                      _buildInfoCard('5', 'Pouring MPP'),
                      _buildInfoCard('100/6.5/8.5', 'Total - Quantity/FAT/SNF'),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.02),
                  // Member Collection Section
                  _buildSectionCard(
                    title: 'Member Collection',
                    data: [
                      _buildInfoCard('200', 'Total Member'),
                      _buildInfoCard('5/5', 'Pouring Member/Sample'),
                      _buildInfoCard('100/6.5/8.5', 'Total - Quantity/FAT/SNF'),
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
              '© KMTEPL | App Version-1.0 | 17 Dec 2024',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          )));}}
        
      
  

  Widget _buildSectionCard(
      {required String title, required List<Widget> data}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: data,
          ),
          SizedBox(height: Get.height * 0.02),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String value, String label) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: CustomColors.appColor,
            ),
          ),
          SizedBox(height: Get.height * 0.01),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsRow() {
    return Card(
      child: Column(
        children: [
          const Text(
            "Transactions",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Navigate to Login Screen
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
          SizedBox(height: Get.height * 0.02),
        ],
      ),
    );
  }

  Widget _buildTransactionButton(
    String label,
    VoidCallback onTap,
  ) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.01,
          vertical: Get.height * 0.01,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: CustomColors.appColor,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

