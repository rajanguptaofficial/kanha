import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/controller/reports/reports_homepage_controller.dart';
import 'package:kanha_bmc/pages/reports/bmc_collection_reports/bmc_shift_reports.dart';

class BMCCollReportsHomepage extends StatefulWidget {
  const BMCCollReportsHomepage({super.key});

  @override
  State<BMCCollReportsHomepage> createState() => _BMCCollReportsHomepageState();
}

class _BMCCollReportsHomepageState extends State<BMCCollReportsHomepage> {
  final ReportsHomepageController controller =
      Get.put(ReportsHomepageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.appColor,
          title: const Text(
            "BMC Collection",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return SizedBox(
              height: Get.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCard(
                      title: 'Shift Report',
                      imagePath: "assets/icons/shift.png",
                      onTap: () {
                         Get.to(() => BMCShiftReportScreen());
                      },
                    ),
                    _buildCard(
                      title: 'CDA',
                      imagePath: "assets/icons/bmc_collection.png",
                      onTap: () {
                        //Get.to(() => BMCCollectionScreen());
                      },
                    ),
                    _buildCard(
                      title: 'Daily Milk Summary',
                      imagePath: "assets/icons/tank.png",
                      onTap: () {
                        //Get.to(() => RMRD());
                        // Navigate to the relevant page
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: Get.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    imagePath,
                    height: Get.height * 0.08,
                    width: Get.width * 0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
