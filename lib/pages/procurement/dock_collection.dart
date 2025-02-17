import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/common/custom_app_bar.dart';
import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';
import 'package:kanha_bmc/controller/procurement/bmc_controller.dart';
import 'package:kanha_bmc/controller/procurement/dock_collection_controller.dart';


class DockCollectionScreen extends StatefulWidget {
  const DockCollectionScreen({super.key});

  @override
  State<DockCollectionScreen> createState() => _DockCollectionScreenState();
}

class _DockCollectionScreenState extends State<DockCollectionScreen> {

  // final TruckArrivalController controller = Get.put(TruckArrivalController());
final controller = Get.put(DockCollectionController());
final controller3 = Get.put(BMCCollectionController());
  final controller2 = Get.put(RateCheckMasterController());
  final _formKey = GlobalKey<FormState>(); 

 final TextEditingController canController = TextEditingController(); 
  final TextEditingController wiightController = TextEditingController(); 
  final TextEditingController mppCodeController = TextEditingController();
 final TextEditingController mppNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProcCustomAppBar(title: 'Dock/Weight Collection'),
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


 // Listen for changes in qty.value and update the text field
   


                ever(controller.mppCode, (value) {
      mppCodeController.text = value;
      mppCodeController.selection = TextSelection.fromPosition(
        TextPosition(offset: mppCodeController.text.length),
      );
    });
    
  ever(controller.mppName, (value) {
      mppNameController.text = value;
      mppNameController.selection = TextSelection.fromPosition(
        TextPosition(offset: mppNameController.text.length),
      );
    });


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
          SizedBox(height: Get.height * 0.01),        
         
        
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
 Obx(() => TextFormField(
          readOnly: true,
          controller:   TextEditingController(text: controller.currentTime.value.toString()),
          decoration: InputDecoration(
            labelText: 'Time',
             border: OutlineInputBorder(),
    labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    ),
            suffixIcon: IconButton(
              icon: Icon(Icons.access_time),
              onPressed: () => controller.selectTime(context),
            ),
          ),
          validator: (value) => value!.isEmpty ? 'Please select a time' : null,
        )),

  SizedBox(height: Get.height * 0.02),

        DropdownButtonFormField<String>(
    value: controller.routeData.contains(controller.selectedRoute.value)
        ? controller.selectedRoute.value
        : null, // Set to null if not found in list
    decoration: const InputDecoration(labelText: 'Select Route',
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
       controller.selectedRoute.value = newValue;
      // controller.fetchCompnyCodeByRuteCodeName(controller.selectedRoute.value);
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
        
        DropdownButtonFormField<String>(
    value: controller.routeData.contains(controller.selectedGrade.value)
        ? controller.selectedGrade.value
        : null, // Set to null if not found in list
    decoration: const InputDecoration(labelText: 'Select Grade',
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
       controller.selectedGrade.value = newValue;
     //  controller.fetchCompnyCodeByRuteCodeName(controller.selectedRoute.value);
      }
    },
    validator: (value) =>
                      value == null || value.isEmpty ? 'Please select Grade Type' : null,
    items: controller.gradeData.toSet().map<DropdownMenuItem<String>>((grade) { 
      return DropdownMenuItem<String>(
        value: grade,
        child: Text(grade),
      );
    }).toList(),
        ),
       
        SizedBox(height: Get.height * 0.02),
        
      Obx(() =>   TextFormField(
               readOnly: true,
               decoration: InputDecoration(
                 labelText: 'Sample No.', labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    ),
                  border: OutlineInputBorder(),
              //
               ),
               controller:
                  TextEditingController(text: controller.sampleIdNo.value.toString()),
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

        SizedBox(height: Get.height * 0.02),
        _buildMemberDetailsRow(),
        SizedBox(height: Get.height * 0.02),
        _buildQtyMilkTypeRow(),
         SizedBox(height: Get.height * 0.02),
        _buildFatSnfRow(),
        SizedBox(height: Get.height * 0.02),
        //SizedBox(height: Get.height * 0.02),
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


Widget _buildMemberDetailsRow() {
  return Row(
    children: [
      Expanded(
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Society Code',
            border: OutlineInputBorder(),
            labelStyle: TextStyle(color: CustomColors.appColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.appColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.appColor, width: 1),
            ),
          ),
          onChanged: (value) {
            controller.mppCode.value = value;
            controller.getMppMasterDetails(value);
          },
          controller: mppCodeController,
          validator: (value) =>
              value!.isEmpty ? 'Please enter Society Code' : null,
        ),
      ),
      SizedBox(width: Get.width * 0.04),
      Expanded(
        child: TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Society Name',
            border: OutlineInputBorder(),
            labelStyle: TextStyle(color: CustomColors.appColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.appColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.appColor, width: 1),
            ),
          ),
          onChanged: (value) {
            controller.mppName.value = value;
            controller.fetchOtherCodeByFirstName(value);
          },
          controller: mppNameController,
          validator: (value) =>
              value!.isEmpty ? 'Please enter Society Name' : null,
        ),
      ),
    ],
  );
}




  Widget _buildFatSnfRow() {
    return Row(
      children: [
        Expanded(
       
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Can',
                 border: OutlineInputBorder(), labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    ),
                  
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller.can.value = value;
              },
              controller: canController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter Can' : null,
            ),
          ),
      
         SizedBox(width: Get.width * 0.04),
        Expanded(
        
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Weight',
                 border: OutlineInputBorder(), labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    ),
                  
              ),
               controller: wiightController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller.weight.value = value;           
              },
              validator: (value) => value!.isEmpty ? 'Please enter Weight' : null,
            ),
     
        ),
        // SizedBox(width),
        
      
      ],
    );
  }

  Widget _buildQtyMilkTypeRow() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.11),
      child: 
      Row(
        children: [
           Padding(
                 padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.061),
             child: Text("Milk Type", style: TextStyle(fontWeight: FontWeight.bold),         ),
           ),
          // SizedBox(width: ),
          Expanded(
            child: Obx(() => DropdownButtonFormField<String>(
                  value: controller2.selectedMilkType.value.isEmpty
                      ? null
                      : controller2.selectedMilkType.value,
                     decoration: const InputDecoration(
                      labelText:'Milk Type',
                      border: OutlineInputBorder(),
    labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    )
                    ),
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      value: 'Cow',
                      child: Row(
                        children: [
                          Image.asset("assets/icons/cow.png", width: 24, height: 24),
                          SizedBox(width: 8),
                          Text('Cow'),
                        ],
                      ),
                    ),
                    
                    DropdownMenuItem(
                      value: 'Buff',
                      child: Row(
                        children: [
                          Image.asset("assets/icons/buff.png", width: 24, height: 24),
                          SizedBox(width: 8),
                          Text('Buff'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Mixed',
                      child: Row(
                        children: [
                          Image.asset("assets/icons/mix.png", width: 24, height: 24),
                          SizedBox(width: 8),
                          Text('Mixed'),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    controller2.selectedMilkType.value = value ?? '';
                    controller2.filterData();
                   // controller.calculateAmountValue();
                    controller.milkType.value = controller2.selectedMilkType.value;
               
                  },
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please select Milk Type' : null,
                )),
          ),
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
        controller.saveEntry(),
      
        
    ]).then((_) {
           _formKey.currentState!.reset(); 
            controller.mppCode.value= "";
            controller.mppName.value= "";
            mppCodeController.clear();
  mppNameController.clear();
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
   
      DataColumn(label: Center(child: Text('S. No.'))),
      DataColumn(label: Center(child: Text('Code'))),
      DataColumn(label: Center(child: Text('Name'))),
      DataColumn(label: Center(child: Text('Type'))),
      DataColumn(label: Center(child: Text('Qty.'))),
      DataColumn(label: Center(child: Text('Can'))),
   
   
        ],
        rows: List.generate(controller.docDBCollData.length, (index) {
          final data = controller.docDBCollData[index];
          final isGrey = index % 2 == 0;
          return DataRow(
            color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[200]),
            cells: [
   
   
   DataCell(Center(child: Text("${data["sampleId"]}"))),
   DataCell(Center(child: Text("${data['mppOtherCode']}"))),
   DataCell(Center(child: Text("${data['socname']}"))),
   DataCell(Center(child: Text("${data['type']}"))),
   DataCell(Center(child: Text("${data['weight']}"))),
   DataCell(Center(child: Text((data['rCans'].toString())))),
   
      
            ],
          );
        }),
      ),
 )));}
}




 