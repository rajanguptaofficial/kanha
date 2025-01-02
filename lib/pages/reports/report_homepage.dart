import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/custom_app_bar.dart';
import '../../controller/reports/reports_homepage_controller.dart';

class ReportsHomepageScreen extends StatefulWidget {
  const ReportsHomepageScreen({super.key});

  @override
  State<ReportsHomepageScreen> createState() => _ReportsHomepageScreenState();
}

class _ReportsHomepageScreenState extends State<ReportsHomepageScreen> {
  final ReportsHomepageController controller =
      Get.put(ReportsHomepageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProcCustomAppBar(title: 'Reports'),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return SizedBox(
              height: Get.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCard(
                      title: 'Member Collection',
                      imagePath: "assets/icons/tank.png",
                      onTap: () {
                        // Get.to(() => MemberCollectionScreen());
                      },
                    ),
                    _buildCard(
                      title: 'RMRD',
                      imagePath: "assets/icons/truck.png",
                      onTap: () {
                        //Get.to(() => RMRD());
                        // Navigate to the relevant page
                      },
                    ),
                    _buildCard(
                      title: 'BMC Collection',
                      imagePath: "assets/icons/bmc_collection.png",
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
