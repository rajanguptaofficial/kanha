
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/common/custom_app_bar.dart';
import 'package:kanha_bmc/controller/procurement/truck_arrival_controller.dart';

class TruckArrivalFormScreen extends StatefulWidget {

  const TruckArrivalFormScreen({super.key});

  @override
  State<TruckArrivalFormScreen> createState() => _TruckArrivalFormScreenState();
}


class _TruckArrivalFormScreenState extends State<TruckArrivalFormScreen> {
  final TruckArrivalController controller = Get.put(TruckArrivalController());

  final _formKey = GlobalKey<FormState>(); 
 
 
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
          // decoration: const InputDecoration(labelText: 'Select Dock'),
          // hint: const Text("Select Dock No"),
          decoration: const InputDecoration(
                      labelText:'Select Dock No',
                      border: OutlineInputBorder(),
    labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    )
                    ),
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
          controller: TextEditingController(
            text: DateFormat('yyyy-MM-dd').format(controller.selectedDate.value),
          ),
          decoration: InputDecoration(
            labelText: 'Select Date',
            border: OutlineInputBorder(),
    labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), ),
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => controller.pickDate(context),
            ),
          ),
          validator: (value) => value!.isEmpty ? 'Please select a date' : null,
        )),


        SizedBox(height: Get.height * 0.02),
      
        Obx(
      () => TextFormField(
        readOnly: true,
        controller: TextEditingController(text: controller.timeShift.value),
        decoration: InputDecoration(
          labelText: 'Shift',
    border: OutlineInputBorder(),
    labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    )
                    ),
        onTap: () => controller.selectShift(context),
        validator: (value) => value!.isEmpty ? 'Please select a shift' : null,
      ),
    ),

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
   
    //hint: const Text("Select Route"),
    onChanged: (newValue) {
      if (newValue != null) {
       controller.selectedRoute.value = newValue;
       controller.fetchCompnyCodeByRuteCodeName(controller.selectedRoute.value);
      }
    },  decoration: const InputDecoration(
                      labelText:'Select Route ',
                      border: OutlineInputBorder(),
    labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    )
                    ),
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
          controller:   TextEditingController(text: controller.currentTime.value.toString()),
          decoration: InputDecoration(
            labelText: 'Time',
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () => controller.selectTime(context),
            ),
          ),
          validator: (value) => value!.isEmpty ? 'Please select a time' : null,
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
                       SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: buildDataTable(),
                       ),
                  ],
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


 SizedBox( width: Get.width,
   child: DataTable(
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
      ),
 )));}
}




 