
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/common/custom_app_bar.dart';
import 'package:kanha_bmc/controller/procurement/truck_arrival_controller.dart';

class TruckArrivalFormScreen extends StatelessWidget {
  final TruckArrivalController controller = Get.put(TruckArrivalController());

  final _formKey = GlobalKey<FormState>(); // Global key for form validation
  TruckArrivalFormScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProcCustomAppBar(title: 'Truck Arrival'),
        body:
         Form(
           key: _formKey, // Associate the form key here
           child: OrientationBuilder(
            builder: (context, orientation) {
           
              final isPortrait = orientation == Orientation.portrait;
              final double padding = Get.width * 0.04;
           
              return Obx(() {
                 // controller.currentDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
                  // controller.currentTime.value=   DateFormat('HH:mm').format(DateTime.now());
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 14),
                  child: isPortrait
                      ? _buildPortraitLayout(padding)
                      : _buildLandscapeLayout(padding),
                );
              });
            },
                   ),
         ),
      ),
    );
  }
 // First Form Widget
  Widget buildFirstForm() {
    return Column(
      children: [
        
        DropdownButtonFormField<String>(
          value: controller.dockCollData.contains(controller.selectedDockNo.value)
        ? controller.selectedDockNo.value
        : null, // Ensure value is in the list
          decoration: const InputDecoration(labelText: 'Select Dock'),
          hint: const Text("Select Dock No"),
          onChanged: (newValue) {
            if (newValue != null) {
        controller.selectedDockNo.value = newValue;
            }
          },
          items: controller.dockCollData.map<DropdownMenuItem<String>>((dockNo) {
            return DropdownMenuItem<String>(
        value: dockNo.toString(),
        child: Text(dockNo.toString()),
            );
          }).toList(), 
          validator: (value) =>
                      value == null || value.isEmpty ? 'Please select Dock Type' : null,
        ),
        
        
        
        SizedBox(height: Get.height * 0.02),
         Obx(() => TextFormField(
                 readOnly: true,
                 decoration: InputDecoration(
                   labelText: 'Date',
                    border: OutlineInputBorder(),
                 //contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
                 ),
                 controller:
                     TextEditingController(text: controller.currentDate.value.toString()),
                        validator: (value) => value!.isEmpty ? 'Please enter Date' : null,
               )),
      
        SizedBox(height: Get.height * 0.02),
       
           Obx(() => TextFormField(
                 readOnly: true,
                 decoration: InputDecoration(
                   labelText: 'Shift',
                    border: OutlineInputBorder(),
                 //contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
                 ),
                       validator: (value) => value!.isEmpty ? 'Please enter Shift' : null,
                 controller:
                     TextEditingController(text: controller.timeShift.value.toString()),
               )),
        SizedBox(height: Get.height * 0.02),

 ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07, vertical: Get.height * 0.01),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: CustomColors.appGreenButtomColor,
          ),
         onPressed: () {
          
if (_formKey.currentState!.validate()) {
      controller.isForm1Visible.value = false;
            } else {
              Get.snackbar('Error', 'Please select all fields',
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
        
          child: Text('Go', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
        ),
 SizedBox(height: Get.height * 0.02),
      ],
    );
  }

  // Second Form Widget
  Widget buildSecondForm() {
    return Column(
      children: [
        
        
        DropdownButtonFormField<String>(
    value: controller.routeData.contains(controller.selectedRoute.value)
        ? controller.selectedRoute.value
        : null, // Set to null if not found in list
    decoration: const InputDecoration(labelText: 'Select Route'),
    hint: const Text("Select Route"),
    onChanged: (newValue) {
      if (newValue != null) {
       controller.selectedRoute.value = newValue;
       controller.fetchCompnyCodeByRuteCodeName(controller.selectedRoute.value);
      }
    },
    validator: (value) =>
                      value == null || value.isEmpty ? 'Please select Route Type' : null,
    items: controller.routeData.toSet().map<DropdownMenuItem<String>>((route) { 
      return DropdownMenuItem<String>(
        value: route,
        child: Text(route),
      );
    }).toList(),
        ),
        
         SizedBox(height: Get.height * 0.02),
      
         Obx(() => TextFormField(
                 readOnly: true,
                 decoration: InputDecoration(
                    labelText: 'Arrival Time',
                    border: OutlineInputBorder(),
                 //contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
                 ),
                    validator: (value) => value!.isEmpty ? 'Please enter Arrival Time' : null,
                 controller:
                     TextEditingController(text: controller.currentTime.value.toString()),
               )),
      
        SizedBox(height: Get.height * 0.02),
        TextField(
          decoration: const InputDecoration(labelText: 'Enter Truck No.'),
          onChanged: (value) {
            controller.truckNumber.value = value;
          },
        ),
        SizedBox(height: Get.height * 0.02),
        _buildButtons(),
        SizedBox(height: Get.height * 0.02),
       ],
    );
  }



  Widget _buildPortraitLayout(double padding) {
    return SingleChildScrollView(
      child: Column(
        children: [
      controller.isForm1Visible.value ? buildFirstForm() : buildSecondForm(), 
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: buildDataTable(),
          ),
        ),
        ],
      ),
    );
  
  }
    

Widget _buildLandscapeLayout(double padding) {
  return SingleChildScrollView(
    child: Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Obx(() => Text(
        //           controller.currentDate.value,
        //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        //         )),
        //     Obx(() => Text(
        //           controller.timeShift.value,
        //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        //         )),
        //   ],
        // ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                //color:Colors.red,
               width: Get.width*.4,
                child: Column(
                  children: [
                     controller.isForm1Visible.value ? buildFirstForm() : buildSecondForm(), 
                        // SizedBox(height: Get.width * 0.01),    
                       
                        // SizedBox(height: Get.width * 0.01),   
                    
                        SizedBox(height: Get.width * 0.01),
                       // _buildButtons(),
                        SizedBox(height: padding),
                  ],
                ),
              ),
            ),
              Expanded(
                child: Container(
              // color:Colors.green,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     children: [
                       SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: buildDataTable(),
                       ),
                     ],
                   ),
                 ),
                             ),
              ),
          ],
        ),
    
    
        // Making Data Table more adaptable in Landscape
       
      ],
    ),
  );
}


 Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07, vertical: Get.height * 0.01),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: CustomColors.appGreenButtomColor,
          ),
         onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Process data if form is valid
           
    Future.wait([
        controller.saveEntry()
    ]).then((_) {
           _formKey.currentState!.reset(); 
    });
            }

          },
          child: Text('Save', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
        ),
       
      ],
    );
  }
 
 
  Widget buildDataTable() {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:


 DataTable(
      headingRowColor:
          WidgetStateProperty.all(CustomColors.appColor),
      headingTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold),
      columnSpacing: 12,
      dataRowMinHeight: 20,
      dataRowMaxHeight: 40,
      headingRowHeight: 33,
      columns: const [

    DataColumn(label: Text('S. No.')),
    DataColumn(label: Text('Date')),
    DataColumn(label: Text('Shift')),
    DataColumn(label: Text('Truck No')),
    DataColumn(label: Text('Arrival Time')),


      ],
      rows: List.generate(controller.truckArrivalDBData.length, (index) {
        final data = controller.truckArrivalDBData[index];
        final isGrey = index % 2 == 0;
        return DataRow(
          color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[200]),
          cells: [


 DataCell(Center(child: Text("${data["sampleId"]}"))),
DataCell(Center(child: Text("${data['dumpDate']}"))),
DataCell(Center(child: Text("${data['shift']}"))),
DataCell(Center(child: Text("${data['truckNo']}"))),
DataCell(Center(child: Text((data['arrivalTime'].toString())))),

    
          ],
        );
      }),
    )));}
  }




 