import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import '../../controller/masters/mpp_master_controller.dart';

class MppMasterScreen extends StatelessWidget {
  final MppMasterController controller = Get.put(MppMasterController());

  MppMasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.appColor,
          title: const Text(
            "MPP Master",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              // Adjust layout based on orientation
              if (orientation == Orientation.portrait) {
                return ListView(
                  children: [
                    SizedBox(
                      height: Get.height * 0.8, // Dynamic height
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: Get.width * 0.05, // Dynamic column spacing
                          columns: const [
                            DataColumn(label: Text('Name Code')),
                            DataColumn(label: Text('MCC Name/Code')),
                            DataColumn(label: Text('Plant Name/Code')),
                            DataColumn(label: Text('Company Name/Code')),
                            DataColumn(label: Text('Route Name/Code')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Effective Date')),
                            DataColumn(label: Text('Address')),
                          ],
                          rows: controller.mppData.map((data) {
                            return DataRow(cells: [
                              DataCell(Text(data['nameCode'] ?? '')),
                              DataCell(Text(data['mccNameCode'] ?? '')),
                              DataCell(Text(data['plantNameCode'] ?? '')),
                              DataCell(Text(data['companyNameCode'] ?? '')),
                              DataCell(Text(data['routeNameCode'] ?? '')),
                              DataCell(Text(data['status'] ?? '')),
                              DataCell(Text(data['effectiveDate'] ?? '')),
                              DataCell(Text(data['address'] ?? '')),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // Landscape view
                return Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: Get.height * 0.9, // Dynamic height for landscape
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: Get.width * 0.05, // Dynamic column spacing
                            columns: const [
                              DataColumn(label: Text('Name Code')),
                              DataColumn(label: Text('MCC Name/Code')),
                              DataColumn(label: Text('Plant Name/Code')),
                              DataColumn(label: Text('Company Name/Code')),
                              DataColumn(label: Text('Route Name/Code')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Effective Date')),
                              DataColumn(label: Text('Address')),
                            ],
                            rows: controller.mppData.map((data) {
                              return DataRow(cells: [
                                DataCell(Text(data['nameCode'] ?? '')),
                                DataCell(Text(data['mccNameCode'] ?? '')),
                                DataCell(Text(data['plantNameCode'] ?? '')),
                                DataCell(Text(data['companyNameCode'] ?? '')),
                                DataCell(Text(data['routeNameCode'] ?? '')),
                                DataCell(Text(data['status'] ?? '')),
                                DataCell(Text(data['effectiveDate'] ?? '')),
                                DataCell(Text(data['address'] ?? '')),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            });
          },
        ),
      ),
    );
  }
}
