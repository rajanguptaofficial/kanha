import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/colors.dart';
import '../../controller/masters/member_master_controller.dart';

class MemberMasterScreen extends StatelessWidget {
  final MemberMasterController controller = Get.put(MemberMasterController());

  MemberMasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.appColor,
          title: const Text(
            "Member Master",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              // Responsive dimensions
              double screenHeight = Get.height;
              double screenWidth = Get.width;

              // Adjust the layout based on the orientation
              if (orientation == Orientation.portrait) {
                return ListView(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.8,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: screenWidth * 0.05,
                          columns: const [
                            DataColumn(label: Text('Society Code/Name')),
                            DataColumn(label: Text('Member Code/Name')),
                            DataColumn(label: Text('Member Short Code')),
                            DataColumn(label: Text('Farmer Name')),
                            DataColumn(label: Text('Mobile No.')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: controller.memberData.map((data) {
                            return DataRow(cells: [
                              DataCell(Text(data['societyCodeName'] ?? '')),
                              DataCell(Text(data['memberCodeName'] ?? '')),
                              DataCell(Text(data['membShortCode'] ?? '')),
                              DataCell(Text(data['farmerName'] ?? '')),
                              DataCell(Text(data['mobNo'] ?? '')),
                              DataCell(Text(data['Status'] ?? '')),
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: screenWidth * 0.03,
                          columns: const [
                            DataColumn(label: Text('Society Code/Name')),
                            DataColumn(label: Text('Member Code/Name')),
                            DataColumn(label: Text('Member Short Code')),
                            DataColumn(label: Text('Farmer Name')),
                            DataColumn(label: Text('Mobile No.')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: controller.memberData.map((data) {
                            return DataRow(cells: [
                              DataCell(Text(data['societyCodeName'] ?? '')),
                              DataCell(Text(data['memberCodeName'] ?? '')),
                              DataCell(Text(data['membShortCode'] ?? '')),
                              DataCell(Text(data['farmerName'] ?? '')),
                              DataCell(Text(data['mobNo'] ?? '')),
                              DataCell(Text(data['Status'] ?? '')),
                            ]);
                          }).toList(),
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
