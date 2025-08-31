


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/controller/masters/bmc_master_controller.dart';


class BmcMasterScreen extends StatelessWidget {
  final BmcMasterController controller = Get.put(BmcMasterController());

  BmcMasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = Get.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
              if (controller.bmcData.isEmpty) {
                return const Center(child: Text("No Data Found"));
              }

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 1),
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
      // columnSpacing: 12,
      // dataRowMinHeight: 20,
      // dataRowMaxHeight: 40,
      // headingRowHeight: 33,
      columns: const [

    DataColumn(label: Text('S. No')),
    DataColumn(label: Text('BMC Name')),
    DataColumn(label: Text('BMC Code')),
    DataColumn(label: Text('Is Active')),
    // DataColumn(label: Text('Company Name-Code')),
    // DataColumn(label: Text('Effective Date')),
    // DataColumn(label: Text('Address')),
    // DataColumn(label: Text('DOCK')),

      ],
      rows: List.generate(controller.bmcData.length, (index) {
        final data = controller.bmcData[index];
        final isGrey = index % 2 == 0;
        return DataRow(
          color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[200]),
          cells: [

  
      

   DataCell(Center(child: Text("${index +1}."))),
      DataCell(Center(child: Text("${data['cntName']}"))),
         DataCell(Center(child: Text("${data['cntCode']}"))),
            DataCell(Center(child: Text( ("${data['is_Active']}" == "0")?"No":"Yes"))),
              // DataCell(Center(child: Text(data['effectivedate'].toString()))),
              //  DataCell(Center(child: Text(data['add1'].toString()  ))),
              //   DataCell(Center(child: Text(data['cntDocks'].toString()  ))),

                          
          ],
        );
      }),
    );
  }
}

