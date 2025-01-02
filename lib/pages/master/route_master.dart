import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import '../../controller/masters/route_master_controller.dart';

class RouteMasterScreen extends StatelessWidget {
  final RouteMasterController controller = Get.put(RouteMasterController());

  RouteMasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX height and width
    //final double height = Get.height;
    final double width = Get.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.appColor,
          title: const Text(
            "Route Master",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              // Adjust the layout based on the orientation
              if (orientation == Orientation.portrait) {
                // Portrait view
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: width * 0.1,
                        columns: const [
                          DataColumn(label: Text('Route Name/Code')),
                          DataColumn(label: Text('MCC Name/Code')),
                          DataColumn(label: Text('Plant Name/Code')),
                          DataColumn(label: Text('Company Name/Code')),
                        ],
                        rows: controller.routeData.map((data) {
                          return DataRow(cells: [
                            DataCell(Text(data['routeNameCode'] ?? '')),
                            DataCell(Text(data['mccNameCode'] ?? '')),
                            DataCell(Text(data['plantNameCode'] ?? '')),
                            DataCell(Text(data['companyNameCode'] ?? '')),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ],
                );
              } else {
                // Landscape view
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: width * 0.1,
                            columns: const [
                              DataColumn(label: Text('Route Name/Code')),
                              DataColumn(label: Text('MCC Name/Code')),
                              DataColumn(label: Text('Plant Name/Code')),
                              DataColumn(label: Text('Company Name/Code')),
                            ],
                            rows: controller.routeData.map((data) {
                              return DataRow(cells: [
                                DataCell(Text(data['routeNameCode'] ?? '')),
                                DataCell(Text(data['mccNameCode'] ?? '')),
                                DataCell(Text(data['plantNameCode'] ?? '')),
                                DataCell(Text(data['companyNameCode'] ?? '')),
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
