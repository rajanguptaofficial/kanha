import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import '../../controller/masters/route_master_controller.dart';

class RouteMasterScreen extends StatelessWidget {
    final RouteMasterController controller = Get.put(RouteMasterController());
  RouteMasterScreen({super.key});

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
                        child:DataTable(
  headingRowColor: WidgetStateProperty.all(CustomColors.appColor),
  headingTextStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  columnSpacing: 12,
  dataRowMinHeight: 20,
  dataRowMaxHeight: 40,
  headingRowHeight: 33,
  columns: const [
    DataColumn(label: Text('Route Name/Code')),
    DataColumn(label: Text('MCC Name/Code')),
    DataColumn(label: Text('Plant Name/Code')),
    DataColumn(label: Text('Company Name/Code')),
  ],
  rows: List.generate(controller.routeData.length, (index) {
    final data = controller.routeData[index];
    final isGrey = index % 2 == 0; // Alternate rows

    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return isGrey ? Colors.white  : Colors.grey[200];
        },
      ),
      cells: [
        DataCell(Center(child: Text("${data.rtName}/${data.routecode}"))),
        DataCell(Center(child: Text("${data.mccName}/${data.mccCode}"))),
        DataCell(Center(child: Text("${data.plantName}/${data.plantCode}"))),
        DataCell(Center(child: Text("${data.companyName}/${data.companyCode}"))),
      ],
    );
  }),
)


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
                          child: 
                        DataTable(
  headingRowColor: WidgetStateProperty.all(CustomColors.appColor),
  headingTextStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  columnSpacing: 12,
  dataRowMinHeight: 20,
  dataRowMaxHeight: 40,
  headingRowHeight: 33,
  columns: const [
    DataColumn(label: Text('Route Name/Code')),
    DataColumn(label: Text('MCC Name/Code')),
    DataColumn(label: Text('Plant Name/Code')),
    DataColumn(label: Text('Company Name/Code')),
  ],
  rows: List.generate(controller.routeData.length, (index) {
    final data = controller.routeData[index];
    final isGrey = index % 2 == 0; // Alternate rows

    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return isGrey ? Colors.white  : Colors.grey[200];
        },
      ),
      cells: [
        DataCell(Center(child: Text("${data.rtName}/${data.routecode}"))),
        DataCell(Center(child: Text("${data.mccName}/${data.mccCode}"))),
        DataCell(Center(child: Text("${data.plantName}/${data.plantCode}"))),
        DataCell(Center(child: Text("${data.companyName}/${data.companyCode}"))),
      ],
    );
  }),
)


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


