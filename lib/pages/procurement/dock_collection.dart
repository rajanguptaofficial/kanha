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
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Column(
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
      ),
    );
  }
 
  // Second Form Widget
  Widget buildSecondForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF00BFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Obx(() => Text(
                      controller.currentDate.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF00BFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_time, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Obx(() => Text(
                      controller.timeShift.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
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
      ),
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


// Widget _buildMemberDetailsRow() {
//   return Row(
//     children: [
//       Expanded(
//         child: TextFormField(
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//             labelText: 'Society Code',
//             border: OutlineInputBorder(),
//             labelStyle: TextStyle(color: CustomColors.appColor),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: CustomColors.appColor),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: CustomColors.appColor, width: 1),
//             ),
//           ),
//           onChanged: (value) {
//             controller.mppCode.value = value;
//             controller.getMppMasterDetails(value);
//           },
//           controller: mppCodeController,
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter Society Code' : null,
//         ),
//       ),
//       SizedBox(width: Get.width * 0.04),
//       Expanded(
//         child: TextFormField(
//           keyboardType: TextInputType.text,
//           decoration: InputDecoration(
//             labelText: 'Society Name',
//             border: OutlineInputBorder(),
//             labelStyle: TextStyle(color: CustomColors.appColor),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: CustomColors.appColor),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: CustomColors.appColor, width: 1),
//             ),
//           ),
//           onChanged: (value) {
//             controller.mppName.value = value;
//             controller.fetchOtherCodeByFirstName(value);
//           },
//           controller: mppNameController,
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter Society Name' : null,
//         ),
//       ),
//     ],
//   );
// }
//
//
//
//
//   Widget _buildFatSnfRow() {
//     return Row(
//       children: [
//         Expanded(
//
//             child: TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Can',
//                  border: OutlineInputBorder(), labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),
//
//               ),
//               keyboardType: TextInputType.number,
//               onChanged: (value) {
//                 controller.can.value = value;
//               },
//               controller: canController,
//               validator: (value) =>
//                   value!.isEmpty ? 'Please enter Can' : null,
//             ),
//           ),
//
//          SizedBox(width: Get.width * 0.04),
//         Expanded(
//
//             child: TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Weight',
//                  border: OutlineInputBorder(), labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     ),
//
//               ),
//                controller: wiightController,
//               keyboardType: TextInputType.number,
//               onChanged: (value) {
//                 controller.weight.value = value;
//               },
//               validator: (value) => value!.isEmpty ? 'Please enter Weight' : null,
//             ),
//
//         ),
//         // SizedBox(width),
//
//
//       ],
//     );
//   }
//
//   Widget _buildQtyMilkTypeRow() {
//     return Padding(
//       padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.11),
//       child:
//       Row(
//         children: [
//            Padding(
//                  padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.061),
//              child: Text("Milk Type", style: TextStyle(fontWeight: FontWeight.bold),         ),
//            ),
//           // SizedBox(width: ),
//           Expanded(
//             child: Obx(() => DropdownButtonFormField<String>(
//                   value: controller2.selectedMilkType.value.isEmpty
//                       ? null
//                       : controller2.selectedMilkType.value,
//                      decoration: const InputDecoration(
//                       labelText:'Milk Type',
//                       border: OutlineInputBorder(),
//     labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
//     )
//                     ),
//                   isExpanded: true,
//                   items: [
//                     DropdownMenuItem(
//                       value: 'Cow',
//                       child: Row(
//                         children: [
//                           Image.asset("assets/icons/cow.png", width: 24, height: 24),
//                           SizedBox(width: 8),
//                           Text('Cow'),
//                         ],
//                       ),
//                     ),
//
//                     DropdownMenuItem(
//                       value: 'Buff',
//                       child: Row(
//                         children: [
//                           Image.asset("assets/icons/buff.png", width: 24, height: 24),
//                           SizedBox(width: 8),
//                           Text('Buff'),
//                         ],
//                       ),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Mixed',
//                       child: Row(
//                         children: [
//                           Image.asset("assets/icons/mix.png", width: 24, height: 24),
//                           SizedBox(width: 8),
//                           Text('Mixed'),
//                         ],
//                       ),
//                     ),
//                   ],
//                   onChanged: (value) {
//                     controller2.selectedMilkType.value = value ?? '';
//                     controller2.filterData();
//                    // controller.calculateAmountValue();
//                     controller.milkType.value = controller2.selectedMilkType.value;
//
//                   },
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Please select Milk Type' : null,
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//  Widget _buildButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07, vertical: Get.height * 0.01),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             backgroundColor: CustomColors.appGreenButtomColor,
//           ),
//          onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               // Process data if form is valid
//
//     Future.wait([
//         controller.saveEntry(),
//
//
//     ]).then((_) {
//            _formKey.currentState!.reset();
//             controller.mppCode.value= "";
//             controller.mppName.value= "";
//             mppCodeController.clear();
//   mppNameController.clear();
//     });
//             }
//
//           },
//           child: Text('Save', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
//         ),
//
//       ],
//     );
//   }

  Widget _buildMemberDetailsRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Code',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: mppCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Society Code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF00BFFF)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                onChanged: (value) {
                  controller.mppCode.value = value;
                  controller.getMppMasterDetails(value);
                },
                validator: (value) => value!.isEmpty ? 'Please enter Society Code' : null,
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Society Name',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() => Text(
                        controller.mppName.value.isEmpty
                            ? 'Society name'
                            : controller.mppName.value,
                        style: TextStyle(fontSize: 14),
                      )),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQtyMilkTypeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMilkTypeOption('Cow', 'assets/icons/cow.png'),
        _buildMilkTypeOption('Buff', 'assets/icons/buff.png'),
        _buildMilkTypeOption('Mix', 'assets/icons/mix.png'),
      ],
    );
  }

  Widget _buildMilkTypeOption(String type, String iconPath) {
    return Obx(() => GestureDetector(
      onTap: () {
        controller2.selectedMilkType.value = type;
        controller2.filterData();
        controller.milkType.value = controller2.selectedMilkType.value;
      },
      child: Container(
        width: Get.width * 0.28,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        decoration: BoxDecoration(
          color: controller2.selectedMilkType.value == type
              ? Color(0xFF4CAF50)
              : Colors.transparent,
          border: Border.all(
            color: controller2.selectedMilkType.value == type
                ? Color(0xFF4CAF50)
                : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(iconPath, width: 20, height: 20),
            SizedBox(width: 6),
            Text(
              type,
              style: TextStyle(
                color: controller2.selectedMilkType.value == type
                    ? Colors.white
                    : Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            if (controller2.selectedMilkType.value == type)
              Container(
                margin: EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    ));
  }

  Widget _buildFatSnfRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Can',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: canController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Qty',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF00BFFF)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                onChanged: (value) {
                  controller.can.value = value;
                },
                validator: (value) => value!.isEmpty ? 'Please enter Can' : null,
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weight',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: wiightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Fat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF00BFFF)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                onChanged: (value) {
                  controller.weight.value = value;
                },
                validator: (value) => value!.isEmpty ? 'Please enter Weight' : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: Color(0xFF4CAF50),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Future.wait([
              controller.saveEntry(),
            ]).then((_) {
              _formKey.currentState!.reset();
              controller.mppCode.value = "";
              controller.mppName.value = "";
              mppCodeController.clear();
              mppNameController.clear();
            });
          }
        },
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildDataTable() {
    return Obx(() => DataTable(

         headingRowColor:
             WidgetStateProperty.all(CustomColors.appColor),
         headingTextStyle: const TextStyle(
             color: Colors.white, fontWeight: FontWeight.bold),
         // columnSpacing: 12,
         // dataRowMinHeight: 20,
         // dataRowMaxHeight: 40,
         // headingRowHeight: 33,
         columns: const [

       DataColumn(label: Center(child: Text('S.No.')), headingRowAlignment: MainAxisAlignment.center),
       DataColumn(label: Center(child: Text('Code')), headingRowAlignment: MainAxisAlignment.center),
       DataColumn(label: Center(child: Text('Name')), headingRowAlignment: MainAxisAlignment.center),
       DataColumn(label: Center(child: Text('Type')), headingRowAlignment: MainAxisAlignment.center),
       DataColumn(label: Center(child: Text('Qty.')), headingRowAlignment: MainAxisAlignment.center),
       DataColumn(label: Center(child: Text('Can')), headingRowAlignment: MainAxisAlignment.center),


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
       ));}
}




 