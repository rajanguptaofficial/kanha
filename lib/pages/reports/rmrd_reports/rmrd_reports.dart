import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/controller/reports/reports_homepage_controller.dart';

class RMRDReportsHomepage extends StatefulWidget {
  const RMRDReportsHomepage({super.key});

  @override
  State<RMRDReportsHomepage> createState() => _RMRDReportsHomepageState();
}

class _RMRDReportsHomepageState extends State<RMRDReportsHomepage> {
  final ReportsHomepageController controller =
      Get.put(ReportsHomepageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.appColor,
          title: const Text(
            "RMRD",
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
                      title: 'DOCK Checklist',
                      imagePath: "assets/icons/weight.png",
                      onTap: () {
                        // Get.to(() => MemberCollectionScreen());
                      },
                    ),
                    _buildCard(
                      title: 'Lab Checklist',
                      imagePath: "assets/icons/lab.png",
                      onTap: () {
                        // Get.to(() => BMCCollectionScreen());
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
