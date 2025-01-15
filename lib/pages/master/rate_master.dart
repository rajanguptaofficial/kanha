import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/colors.dart';
import '../../controller/masters/rate_master_controller.dart';

class RateMasterScreen extends StatelessWidget {
  final RateMasterController controller = Get.put(RateMasterController());

  RateMasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.appColor,
          title: const Text(
            "Rate Master",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              // Dynamic height and width using GetX
              double screenHeight = Get.height;
              double screenWidth = Get.width;

              // Adjust the layout based on the orientation
              if (orientation == Orientation.portrait) {
                return ListView(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.8, // 80% of screen height
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:  SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                          child: DataTable(
                            columnSpacing: screenWidth * 0.05, // 5% of screen width
                            columns: const [
                              DataColumn(label: Text('Rate Code')),
                              DataColumn(label: Text('Rate Desc')),                          
                              DataColumn(label: Text('Effective Date')),
                              DataColumn(label: Text('Effective Shift')),                          
                            ],
                            rows: controller.rateData.map((data) {
                              return DataRow(cells: [
                                DataCell(Text(data['bmcCode'] ?? '')),
                                DataCell(Text(data['mppCode'] ?? '')),
                                DataCell(Text(data['rateCode'] ?? '')),
                                DataCell(Text(data['rateDesc'] ?? '')),
                              
                              ]);
                            }).toList(),
                          ),
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
                        child: SizedBox(
                          height: screenHeight * 0.9, // 90% of screen height
                          child: DataTable(
                            columnSpacing: screenWidth * 0.04, // 4% of screen width
                            columns: const [
                               DataColumn(label: Text('Rate Code')),
                            DataColumn(label: Text('Rate Desc')),                          
                            DataColumn(label: Text('Effective Date')),
                            DataColumn(label: Text('Effective Shift')),            
                            ],
                            rows: controller.rateData.map((data) {
                              return DataRow(cells: [
                                DataCell(Text(data['bmcCode'] ?? '')),
                                DataCell(Text(data['mppCode'] ?? '')),
                                DataCell(Text(data['rateCode'] ?? '')),
                                DataCell(Text(data['rateDesc'] ?? '')),
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
