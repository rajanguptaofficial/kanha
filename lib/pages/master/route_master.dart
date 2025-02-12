import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import '../../controller/masters/route_master_controller.dart';

class RouteMasterScreen extends StatelessWidget {
    final RuteMasterController controller = Get.put(RuteMasterController());
  RouteMasterScreen({super.key});


  @override
  Widget build(BuildContext context) {
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
              if (controller.ruteData.isEmpty) {
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
                               DataColumn(label: Text('Route Name-Code')),
                              DataColumn(label: Text('MCC Name-Code')),
                              DataColumn(label: Text('Plant Name-Code')),
                              DataColumn(label: Text('Company Name-Code')),     




      ],
      rows: List.generate(controller.ruteData.length, (index) {
        final data = controller.ruteData[index];
        final isGrey = index % 2 == 0;
        return DataRow(
          color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[200]),
          cells: [

   DataCell(Center(child: Text("${data["rtName"]} - ${data["routecode"]}"))),
        DataCell(Center(child: Text("${data["mccName"]} - ${data["mccCode"]}"))),
        DataCell(Center(child: Text("${data["plantName"]} - ${data["plantCode"]}"))),
        DataCell(Center(child: Text("${data["companyName"]} - ${data["companyCode"]}"))),

                          
          ],
        );
      }),
    );
  }
}

