import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/pages/procurement/bmc_collection.dart';
import 'package:kanha_bmc/pages/procurement/member_collection.dart';
import 'package:kanha_bmc/pages/procurement/truck_arrival.dart';
import '../../common/custom_app_bar.dart';
import '../../controller/procurement/procurement_homepage_controller.dart';
import 'dock_collection.dart';
import 'lab_fat_snf.dart';

class ProcurementHomepageScreen extends StatelessWidget {
  ProcurementHomepageScreen({super.key});

  // Instance of GetX controller
  final ProcurementHomepageController controller =
      Get.put(ProcurementHomepageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProcCustomAppBar(title: 'Procurement'),
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
                        Get.to(() => MemberCollectionScreen());
                      },
                    ),
                    _buildCard(
                      title: 'Truck Arrival',
                      imagePath: "assets/icons/truck.png",
                      onTap: () {
                        Get.to(() => TruckArrivalFormScreen());
                        // Navigate to the relevant page
                      },
                    ),
                    _buildCard(
                      title: 'Doc/Weight Collection',
                      imagePath: "assets/icons/weight.png",
                      onTap: () {
                        Get.to(() => DockCollectionScreen());
                      },
                    ),
                    _buildCard(
                      title: 'Lab (FAT/SNF)',
                      imagePath: "assets/icons/lab.png",
                      onTap: () {
                        Get.to(() => LabFatSnfFormScreen());
                      },
                    ),
                    _buildCard(
                      title: 'BMC Collection',
                      imagePath: "assets/icons/bmc_collection.png",
                      onTap: () {
                        Get.to(() => BMCCollectionScreen());
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
