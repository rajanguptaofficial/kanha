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
  final RateCheckMasterController controller = Get.put(RateCheckMasterController());

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
        body: 

          // Show the form once data has been loaded
           OrientationBuilder(
            builder: (context, orientation) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (orientation == Orientation.portrait)
                        _buildPortraitLayout()
                      else
                        _buildLandscapeLayout(),
                    ],
                  ),
                ),
              );
            },
          )
       )); }
  
    
  

  // Build UI for portrait mode
  Widget _buildPortraitLayout() {
    return Column(
      children: [
        // Fat Input
        TextField(
          decoration: const InputDecoration(
            labelText: "Fat",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            controller.fat.value = value;
            controller.filterData(); // Trigger filter on change
          },
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),

        // Snf Input
        TextField(
          decoration: const InputDecoration(
            labelText: "Snf",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            controller.snf.value = value;
            controller.filterData(); // Trigger filter on change
          },
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),

        // Milk Type Dropdown
        Obx(() => DropdownButtonFormField<String>(
              value: controller.selectedMilkType.value.isEmpty
                  ? null
                  : controller.selectedMilkType.value,
              items: controller.milkTypes
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.selectedMilkType.value = value!;
                controller.filterData(); // Trigger filter on change
              },
              decoration: const InputDecoration(
                labelText: "Milk Type",
                border: OutlineInputBorder(),
    labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    )
              ),
            )),
        const SizedBox(height: 16),

        // Display RTPL
        Obx(() => Center(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  "RTPL: ${controller.rtpl.value}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )),
      ],
    );
  }

  // Build UI for landscape mode
  Widget _buildLandscapeLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              // Fat Input
              TextField(
                decoration: const InputDecoration(
                  labelText: "Fat",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.fat.value = value;
                  controller.filterData(); // Trigger filter on change
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Snf Input
              TextField(
                decoration: const InputDecoration(
                  labelText: "Snf",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.snf.value = value;
                  controller.filterData(); // Trigger filter on change
                },
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              // Milk Type Dropdown
              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedMilkType.value.isEmpty
                        ? null
                        : controller.selectedMilkType.value,
                    items: controller.milkTypes
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      controller.selectedMilkType.value = value!;
                      controller.filterData(); // Trigger filter on change
                    },
                    decoration: const InputDecoration(
                      labelText: "Milk Type",
                      border: OutlineInputBorder(),
    labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    )
                    ),
                  )),
              const SizedBox(height: 16),

              // Display RTPL
              Obx(() => Center(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        "RTPL: ${controller.rtpl.value}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
