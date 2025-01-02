import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';
import '../../common/colors.dart';

class RateCheckScreen extends StatefulWidget {
  const RateCheckScreen({super.key});

  @override
  State<RateCheckScreen> createState() => _RateCheckScreenState();
}

class _RateCheckScreenState extends State<RateCheckScreen> {
  final RateCheckController controller = Get.put(RateCheckController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.appColor,
          title: const Text(
            "Rate Check",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            // Get screen width and height using GetX
            double screenWidth = Get.width;
            double screenHeight = Get.height;

            // Check if the orientation is portrait
            bool isPortrait = orientation == Orientation.portrait;

            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.04,
              ),
              child: isPortrait
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildFormWidgets(screenWidth, screenHeight),
                    )
                  : SingleChildScrollView(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _buildFormWidgets(screenWidth, screenHeight),
                            ),
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

  // Helper method to generate form widgets with GetX responsive width/height
  List<Widget> _buildFormWidgets(double screenWidth, double screenHeight) {
    return [
      // Fat Input Field
      SizedBox(
        width: screenWidth * 0.9, // Responsive width
        child: TextField(
          decoration: const InputDecoration(
            labelText: "Fat",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => controller.fat.value = value,
          keyboardType: TextInputType.number,
        ),
      ),
      SizedBox(height: screenHeight * 0.02), // Responsive vertical spacing

      // Snf Input Field
      SizedBox(
        width: screenWidth * 0.9, // Responsive width
        child: TextField(
          decoration: const InputDecoration(
            labelText: "Snf",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => controller.snf.value = value,
          keyboardType: TextInputType.number,
        ),
      ),
      SizedBox(height: screenHeight * 0.02), // Responsive vertical spacing

      // Milk Type Dropdown
      Obx(() => SizedBox(
            width: screenWidth * 0.9, // Responsive width
            child: DropdownButtonFormField<String>(
              value: controller.selectedMilkType.value.isEmpty
                  ? null
                  : controller.selectedMilkType.value,
              items: controller.milkTypes
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) => controller.selectedMilkType.value = value!,
              decoration: const InputDecoration(
                labelText: "Milk Type",
                border: OutlineInputBorder(),
              ),
            ),
          )),
      SizedBox(height: screenHeight * 0.02), // Responsive vertical spacing

      // RTPL Input Field
      SizedBox(
        width: screenWidth * 0.9, // Responsive width
        child: TextField(
          decoration: const InputDecoration(
            labelText: "RTPL",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => controller.snf.value = value,
          keyboardType: TextInputType.number,
        ),
      ),
      SizedBox(height: screenHeight * 0.02), // Responsive vertical spacing

      // Submit Button
      Center(
        child: ElevatedButton(
          onPressed: () {
            Get.snackbar(
              "Form Values",
              "Fat: ${controller.fat.value}, Snf: ${controller.snf.value}, Milk Type: ${controller.selectedMilkType.value}",
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          child: const Text("Submit"),
        ),
      ),
    ];
  }
}
