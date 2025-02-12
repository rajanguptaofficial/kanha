import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/controller/masters/rate_master_controller.dart';

class RateMasterScreen extends StatelessWidget {
  final RateMasterController controller = Get.put(RateMasterController());

  RateMasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = Get.width;

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
              if (controller.rateData.isEmpty) {
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
                               DataColumn(label: Text('Rate Code')),
                            DataColumn(label: Text('Rate Desc')),                          
                            DataColumn(label: Text('Effective Date')),
                            DataColumn(label: Text('Effective Shift')),     




      ],
      rows: List.generate(controller.rateData.length, (index) {
        final data = controller.rateData[index];
        final isGrey = index % 2 == 0;
        return DataRow(
          color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[200]),
          cells: [

  DataCell(Center(child: Text(data["rateCode"].toString() ?? ""))),
                               DataCell(Center(child: Text(data["description"].toString() ??""))),
                                DataCell(Center(child: Text(data["effectiveDate"].toString() ??""))),
                                 DataCell(Center(child: Text(data["effectiveShift"].toString() ??""))),

                          
          ],
        );
      }),
    );
  }
}

