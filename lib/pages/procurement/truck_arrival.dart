import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/custom_app_bar.dart';
import '../../controller/procurement/truck_arrival_controller.dart';

// Combined Form Widget
class TruckArrivalFormScreen extends StatelessWidget {
  final TruckArrivalController controller = Get.put(TruckArrivalController());

  TruckArrivalFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;

        return SafeArea(
          child: Scaffold(
                appBar: ProcCustomAppBar(title: 'Truck Arrival'),
            body: Obx(
              () => controller.isForm1Visible.value
                  ? buildFirstForm(context, height, width, isPortrait)
                  : buildSecondForm(context, height, width, isPortrait),
            ),
          ),
        );
      },
    );
  }

  // First Form Widget
  Widget buildFirstForm(BuildContext context, double height, double width, bool isPortrait) {
    return Padding(
      padding: EdgeInsets.all(isPortrait ? 16.0 : 32.0), // Adjust padding based on orientation
      child: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: controller.selectedDock.value.isEmpty ? null : controller.selectedDock.value,
              items: ['Dock 1', 'Dock 2', 'Dock 3']
                  .map((dock) => DropdownMenuItem(
                        value: dock,
                        child: Text(dock),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.selectedDock.value = value!;
              },
              decoration: const InputDecoration(labelText: 'Select Dock'),
            ),
            SizedBox(height: height * 0.02),
            TextField(
              controller: TextEditingController(
                text: controller.selectedDate.value,
              ),
              decoration: const InputDecoration(
                labelText: 'Enter Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  controller.selectedDate.value = pickedDate.toIso8601String().split('T').first;
                }
              },
            ),
            SizedBox(height: height * 0.02),
            DropdownButtonFormField<String>(
              value: controller.selectedShift.value.isEmpty ? null : controller.selectedShift.value,
              items: ['Morning', 'Evening', 'Night']
                  .map((shift) => DropdownMenuItem(
                        value: shift,
                        child: Text(shift),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.selectedShift.value = value!;
              },
              decoration: const InputDecoration(labelText: 'Select Shift'),
            ),
            SizedBox(height: height * 0.04),
            ElevatedButton(
              onPressed: () {
                if (controller.selectedDock.value.isNotEmpty &&
                    controller.selectedDate.value.isNotEmpty &&
                    controller.selectedShift.value.isNotEmpty) {
                  controller.isForm1Visible.value = false; // Switch to Form 2
                } else {
                  Get.snackbar('Error', 'Please select all fields',
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: const Text('Go'),
            ),
          ],
        ),
      ),
    );
  }

  // Second Form Widget
  Widget buildSecondForm(BuildContext context, double height, double width, bool isPortrait) {
    return Padding(
      padding: EdgeInsets.all(isPortrait ? 16.0 : 32.0), // Adjust padding based on orientation
      child: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: controller.selectedRoute.value.isEmpty ? null : controller.selectedRoute.value,
              items: ['Route A', 'Route B', 'Route C']
                  .map((route) => DropdownMenuItem(
                        value: route,
                        child: Text(route),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.selectedRoute.value = value!;
              },
              decoration: const InputDecoration(labelText: 'Select Route'),
            ),
            SizedBox(height: height * 0.02),
            TextField(
              controller: TextEditingController(
                text: controller.arrival.value,
              ),
              decoration: const InputDecoration(
                labelText: 'Arrival Time',
                suffixIcon: Icon(Icons.access_time),
              ),
              readOnly: true,
              onTap: () {
                controller.arrival.value = TimeOfDay.now().format(context);
              },
            ),
            SizedBox(height: height * 0.02),
            TextField(
              decoration: const InputDecoration(labelText: 'Enter Truck No.'),
              onChanged: (value) {
                controller.truckNumber.value = value;
              },
            ),
            SizedBox(height: height * 0.04),
            ElevatedButton(
              onPressed: () {
                if (controller.selectedRoute.value.isNotEmpty &&
                    controller.truckNumber.value.isNotEmpty &&
                    controller.arrival.value.isNotEmpty) {
                  controller.saveData();
                  Get.snackbar('Success', 'Data saved successfully',
                      snackPosition: SnackPosition.BOTTOM);
                } else {
                  Get.snackbar('Error', 'Please fill all fields',
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: const Text('Add'),
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
