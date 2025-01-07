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
                  padding:
                      EdgeInsets.all(width * 0.04), // Padding based on width
                  children: [
                    SizedBox(
                      height: height * 0.8, // 80% of screen height
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(headingRowColor: WidgetStateProperty.all(CustomColors.appColor,),
                          headingTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          columnSpacing:12,
                           //orientation == Orientation.portrait
                             // ? 15
                            //  : 30, 
                           // Adjust spacing based on orientation
                          dataRowMinHeight: 20,
                          dataRowMaxHeight: 40,headingRowHeight: 33,
                        
                          columns: const [
                            DataColumn(label: Text('BMC Name/Code')),
                            DataColumn(label: Text('MCC Name/Code')),
                            DataColumn(label: Text('Plant Name/Code')),
                            DataColumn(label: Text('Company Name/Code')),
                            DataColumn(label: Text('Effective Date')),
                            DataColumn(label: Text('Address')),
                            DataColumn(label: Text('DOCK')),
                          ],
                          rows: controller.bmcData!.map((data) {
                                 data.effectivedate = controller.formatDate(data.effectivedate);
                            return DataRow(cells: [
                                DataCell(Text("${data.bmcname.toString()}/${data.bmccode.toString()}")),
                              DataCell(Text("${data.mccName.toString()}/${data.mccCode.toString() }")),
                              DataCell(Text("${data.plantName.toString()}/${data.plantCode.toString() }")),
                               DataCell(Text("${data.companyName.toString()}/${data.companyCode.toString()}")),
                             DataCell(Text(data.effectivedate.toString())),
                             DataCell(Text(data.add1.toString())),
                             DataCell(Text(data.cntDocks.toString())),


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
                  padding:
                      EdgeInsets.all(width * 0.03), // Padding for landscape
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(headingRowColor: WidgetStateProperty.all(CustomColors.appColor,),
                          headingTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          columnSpacing:12,
                           //orientation == Orientation.portrait
                             // ? 15
                            //  : 30, 
                           // Adjust spacing based on orientation
                          dataRowMinHeight: 20,
                          dataRowMaxHeight: 40,headingRowHeight: 33,
                          // Adjust spacing for landscape
                            columns: const [
                              DataColumn(label: Text('BMC Name/Code')),
                              DataColumn(label: Text('MCC Name/Code')),
                              DataColumn(label: Text('Plant Name/Code')),
                              DataColumn(label: Text('Company Name/Code')),
                              DataColumn(label: Text('Effective Date')),
                              DataColumn(label: Text('Address')),
                              DataColumn(label: Text('DOCK')),
                            ],
                            rows:  controller.bmcData!.map((data) {
                                data.effectivedate = controller.formatDate(data.effectivedate);
                              return DataRow(cells: [
                                 DataCell(Text("${data.bmcname}/${data.bmccode.toString()}")),
                              DataCell(Text("${data.mccName.toString()}/${data.mccCode.toString() }")),
                              DataCell(Text("${data.plantName.toString()}/${data.plantCode.toString() }")),
                               DataCell(Text("${data.companyName.toString()}/${data.companyCode.toString()}")),
                             DataCell(Text(data.effectivedate.toString())),
                            DataCell(Text(data.add1.toString())),
                             DataCell(Text(data.cntDocks.toString())),

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


