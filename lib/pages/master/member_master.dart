// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/common/colors.dart';
// import 'package:kanha_bmc/controller/masters/member_master_controller.dart';

// class MemberMasterScreen extends StatelessWidget {
//   final MemberMasterController controller = Get.put(MemberMasterController());

//   MemberMasterScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     // Get dynamic height and width using GetX MediaQuery
//     final double height = Get.height;
//     final double width = Get.width;

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: CustomColors.appColor,
//           title: const Text(
//             "Member Master",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//           ),
//         ),
//         body: OrientationBuilder(
//           builder: (context, orientation) {
//             return Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//                 if (controller.memberData.isEmpty) {
//                 return const Center(child: Text("No Data Found"));
//               }

//               // Responsive Layout
//               if (orientation == Orientation.portrait) {
//                 return ListView(
//                   padding:
//                       EdgeInsets.all(width * 0.04), // Padding based on width
//                   children: [
//                     SizedBox(
//                       height: height * 0.8, // 80% of screen height
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: 
                        
//                         DataTable(
//   headingRowColor: WidgetStateProperty.all(CustomColors.appColor),
//   headingTextStyle: const TextStyle(
//     color: Colors.white,
//     fontWeight: FontWeight.bold,
//   ),
//   columnSpacing: 12,
//   dataRowMinHeight: 20,
//   dataRowMaxHeight: 40,
//   headingRowHeight: 33,
//   columns: const [
//                             DataColumn(label: Text('Society Code-Name')),
//                             DataColumn(label: Text('Member Code-Name')),
//                             DataColumn(label: Text('Status')),
//   ],
//   rows: List.generate(controller.memberData.length, (index) {
//     final data = controller.memberData[index];
//     final isGrey = index % 2 == 0; // Alternate rows

//     return DataRow(
//       color: WidgetStateProperty.resolveWith<Color?>(
//         (Set<WidgetState> states) {
//           return isGrey ? Colors.white  : Colors.grey[200];
//         },
//       ),
//       cells: [
//      DataCell(Center(child: Text("${data.code} - ${data.mppName}"))),
//       DataCell(Center(child: Text("${data.otherCode} - ${data.firstName}"))),
//       DataCell(Center(child: Text(data.status == "true" ? "Active" : "Inactive"))),
//       ],
//     );
//   }),
// )                 


//                       ),
//                     ),
//                   ],
//                 );
//               } else {
//                 // Landscape view
//                 return Padding(
//                   padding:
//                       EdgeInsets.all(width * 0.03), // Padding for landscape
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: 
//                        SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                          child: DataTable(
//                            headingRowColor: WidgetStateProperty.all(CustomColors.appColor),
//                            headingTextStyle: const TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold,
//                            ),
//                            columnSpacing: 12,
//                            dataRowMinHeight: 20,
//                            dataRowMaxHeight: 40,
//                            headingRowHeight: 33,
//                            columns: const [
//                             DataColumn(label: Text('Society Code-Name')),
//                               DataColumn(label: Text('Member Code-Name')),
//                               DataColumn(label: Text('Status')),
//                            ],
//                            rows: List.generate(controller.memberData.length, (index) {
//                              final data = controller.memberData[index];
//                              final isGrey = index % 2 == 0; // Alternate rows
                         
//                              return DataRow(
//                                color: WidgetStateProperty.resolveWith<Color?>(
//                                  (Set<WidgetState> states) {
//                                    return isGrey ? Colors.white  : Colors.grey[200];
//                                  },
//                                ),
//                                cells: [
//                               DataCell(Center(child: Text("${data.code} - ${data.mppName}"))),
//                                DataCell(Center(child: Text("${data.otherCode} - ${data.firstName}"))),
//                             DataCell(Center(child: Text(data.status == true ? "Active" : "Inactive"))),
//                                ],
//                              );
//                            }),
//                          ),
//                        )      ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             });
//           },
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/controller/masters/member_master_controller.dart';

class MemberMasterScreen extends StatelessWidget {
  final MemberMasterController controller = Get.put(MemberMasterController());

  MemberMasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = Get.width;

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
              if (controller.memberData.isEmpty) {
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
                            DataColumn(label: Text('Society Code-Name')),
                            DataColumn(label: Text('Member Code-Name')),
                            DataColumn(label: Text('Status')),

      ],
      rows: List.generate(controller.memberData.length, (index) {
        final data = controller.memberData[index];
        final isGrey = index % 2 == 0;
        return DataRow(
          color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[200]),
          cells: [
                                          DataCell(Center(child: Text("${data['code']} - ${data['mppName']}"))),
                                          DataCell(Center(child: Text("${data['otherCode']} - ${data['firstName']}"))),
                                          DataCell(Center(child: Text(data['status'] == true ? "Active" : "Inactive"  ))),
                          
          ],
        );
      }),
    );
  }
}
