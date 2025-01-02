import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import '../../controller/masters/bmc_master_controller.dart';

class BmcMasterScreen extends StatelessWidget {
  final BmcMasterController controller = Get.put(BmcMasterController());

  BmcMasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get dynamic height and width using GetX MediaQuery
    final double height = Get.height;
    final double width = Get.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.appColor,
          title: const Text(
            "BMC Master",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              // Responsive Layout
              if (orientation == Orientation.portrait) {
                return ListView(
                  padding: EdgeInsets.all(width * 0.04), // Padding based on width
                  children: [
                    SizedBox(
                      height: height * 0.8, // 80% of screen height
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: width * 0.05, // Adjust column spacing
                          columns: const [
                            DataColumn(label: Text('BMC Name/Code')),
                            DataColumn(label: Text('MCC Name/Code')),
                            DataColumn(label: Text('Plant Name/Code')),
                            DataColumn(label: Text('Company Name/Code')),
                            DataColumn(label: Text('Effective Date')),
                            DataColumn(label: Text('Address')),
                            DataColumn(label: Text('DOCK')),
                          ],
                          rows: controller.bmcData.map((data) {
                            return DataRow(cells: [
                              DataCell(Text(data['bmcNameCode'] ?? '')),
                              DataCell(Text(data['mccNameCode'] ?? '')),
                              DataCell(Text(data['plantNameCode'] ?? '')),
                              DataCell(Text(data['companyNameCode'] ?? '')),
                              DataCell(Text(data['effectiveDate'] ?? '')),
                              DataCell(Text(data['address'] ?? '')),
                              DataCell(Text(data['dock'] ?? '')),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // Landscape view
                return Padding(
                  padding: EdgeInsets.all(width * 0.03), // Padding for landscape
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: width * 0.04, // Adjust spacing for landscape
                            columns: const [
                              DataColumn(label: Text('BMC Name/Code')),
                              DataColumn(label: Text('MCC Name/Code')),
                              DataColumn(label: Text('Plant Name/Code')),
                              DataColumn(label: Text('Company Name/Code')),
                              DataColumn(label: Text('Effective Date')),
                              DataColumn(label: Text('Address')),
                              DataColumn(label: Text('DOCK')),
                            ],
                            rows: controller.bmcData.map((data) {
                              return DataRow(cells: [
                                DataCell(Text(data['bmcNameCode'] ?? '')),
                                DataCell(Text(data['mccNameCode'] ?? '')),
                                DataCell(Text(data['plantNameCode'] ?? '')),
                                DataCell(Text(data['companyNameCode'] ?? '')),
                                DataCell(Text(data['effectiveDate'] ?? '')),
                                DataCell(Text(data['address'] ?? '')),
                                DataCell(Text(data['dock'] ?? '')),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            });
          },
        ),
      ),
    );
  }
}
