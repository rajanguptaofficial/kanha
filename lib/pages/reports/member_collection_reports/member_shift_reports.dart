import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/reports/member_collection_controller/member_shift_report_controller.dart';

class MemberShiftReportScreen extends StatelessWidget {
  MemberShiftReportScreen({super.key});
  final MemberShiftReportController controller =
      Get.put(MemberShiftReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shift Report'),
        backgroundColor: Colors.blue,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          // Get the current width and height of the screen
          double width = Get.width;
          double height = Get.height;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Data Table
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(Colors.blue),
                      headingTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      columnSpacing: orientation == Orientation.portrait
                          ? 15
                          : 30, // Adjust spacing based on orientation
                      dataRowMinHeight: 40,
                      dataRowMaxHeight: 60,
                      columns: const [
                        DataColumn(label: Center(child: Text('Sr.\nNo.'))),
                        DataColumn(label: Center(child: Text('Member\nCode'))),
                        DataColumn(
                            label:
                                Center(child: Text('Collection\nDate/Shift'))),
                        DataColumn(label: Center(child: Text('Sample\nNo.'))),
                        DataColumn(label: Center(child: Text('Milk\nType'))),
                        DataColumn(label: Center(child: Text('QTY'))),
                        DataColumn(label: Center(child: Text('Fat'))),
                        DataColumn(label: Center(child: Text('Snf'))),
                        DataColumn(label: Center(child: Text('Amount'))),
                      ],
                      rows: List.generate(controller.currentPageData.length,
                          (index) {
                        final item = controller.currentPageData[index];
                        final isEven = index % 2 == 0;

                        return DataRow(
                          color: WidgetStateProperty.all(
                            isEven
                                ? Colors.grey.shade200
                                : Colors.white, // Alternate row colors
                          ),
                          cells: [
                            DataCell(Center(
                                child: Text(item['Sr. No.'] ?? '',
                                    textAlign: TextAlign.center))),
                            DataCell(Center(
                                child: Text(item['Member Code'] ?? '',
                                    textAlign: TextAlign.center))),
                            DataCell(Center(
                                child: Text(item['Collection Date/Shift'] ?? '',
                                    textAlign: TextAlign.center))),
                            DataCell(Center(
                                child: Text(item['Sample No.'] ?? '',
                                    textAlign: TextAlign.center))),
                            DataCell(Center(
                                child: Text(item['Milk Type'] ?? '',
                                    textAlign: TextAlign.center))),
                            DataCell(Center(
                                child: Text(item['QTY'] ?? '',
                                    textAlign: TextAlign.center))),
                            DataCell(Center(
                                child: Text(item['Fat'] ?? '',
                                    textAlign: TextAlign.center))),
                            DataCell(Center(
                                child: Text(item['Snf'] ?? '',
                                    textAlign: TextAlign.center))),
                            DataCell(Center(
                                child: Text(item['Amount'] ?? '',
                                    textAlign: TextAlign.center))),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back Button
                            TextButton(
                              onPressed: controller.previousPage,
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_back_ios),
                                  Text("Back"),
                                ],
                              ),
                            ),
                            // Page Numbers
                            Row(
                              children: List.generate(
                                controller.visiblePageNumbers.length,
                                (index) {
                                  int pageNumber =
                                      controller.visiblePageNumbers[index];
                                  return InkWell(
                                    onTap: () =>
                                        controller.jumpToPage(pageNumber),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color:
                                            controller.currentPage == pageNumber
                                                ? Colors.blue
                                                : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        '$pageNumber',
                                        style: TextStyle(
                                          color: controller.currentPage ==
                                                  pageNumber
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Next Button
                            TextButton(
                              onPressed: controller.nextPage,
                              child: Row(
                                children: [
                                  Text("Next"),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                'Page ${controller.currentPage} of ${controller.totalPages}'),
                            SizedBox(width: 40),
                            const Text('Go to:'),
                            SizedBox(width: 20),
                            SizedBox(
                              width: 50,
                              child: TextField(
                                controller: controller.pageController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  isDense: true,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                int? page = int.tryParse(
                                    controller.pageController.text);
                                if (page != null) {
                                  controller.jumpToPage(page);
                                }
                              },
                              child: const Text('Go'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
