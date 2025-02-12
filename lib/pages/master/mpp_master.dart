import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/controller/masters/mpp_master_controller.dart';


class MppMasterScreen extends StatelessWidget {
  final MppMasterController controller = Get.put(MppMasterController());

  MppMasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = Get.width;

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
              if (controller.mppData.isEmpty) {
                return const Center(child: Text("No Data Found"));
              }

              return Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: buildDataTable()),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget buildDataTable() {
    return DataTable(
      headingRowColor:
          WidgetStateProperty.all(CustomColors.appColor),
      headingTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold),
      columnSpacing: 12,
      dataRowMinHeight: 20,
      dataRowMaxHeight: 40,
      headingRowHeight: 33,
      columns: const [
                              DataColumn(label: Text('Name-Code')),
                              DataColumn(label: Text('MCC Name-Code')),
                              DataColumn(label: Text('Plant Name-Code')),
                              DataColumn(label: Text('Company Name-Code')),
                              DataColumn(label: Text('Route Name-Code')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Effective Date')),
                              DataColumn(label: Text('Address')),

      ],
      rows: List.generate(controller.mppData.length, (index) {
        final data = controller.mppData[index];
        final isGrey = index % 2 == 0;
        return DataRow(
          color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[200]),
          cells: [


      

   DataCell(Center(child: Text("${data['mppName']} - ${data['code']}"))),
      DataCell(Center(child: Text("${data['mccName']} - ${data['mccCode']}"))),
         DataCell(Center(child: Text("${data['plantName']} - ${data['plantCode']}"))),
            DataCell(Center(child: Text("${data['companyName']} - ${data['companyCode']}"))),
              DataCell(Center(child: Text("${data['rtName']} - ${data['routecode']}"))),
              DataCell(Center(child: Text(data['effectivedate'].toString()))), 
               DataCell(Center(child: Text(data['add1'].toString()  ))), 
                DataCell(Center(child: Text(data['status'].toString()  ))),

                          
          ],
        );
      }),
    );
  }
}

