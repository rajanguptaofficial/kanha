import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/common/custom_app_bar.dart';
import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';
import 'package:kanha_bmc/controller/procurement/bmc_controller.dart';

class BMCCollectionScreen extends StatelessWidget {
final controller = Get.put(BMCCollectionController());
  final controller2 = Get.put(RateCheckMasterController());
  final _formKey = GlobalKey<FormState>(); // Global key for form validation
  BMCCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ProcCustomAppBar(title: 'Society Collection'),
        body:
         Form(
           key: _formKey, // Associate the form key here
           child: OrientationBuilder(
            builder: (context, orientation) {
              final isPortrait = orientation == Orientation.portrait;
              final double padding = Get.width * 0.04;
           
              return Obx(() {
                // Update calculated values based on inputs
                controller.rate.value = controller2.rtpl.value;
                double rateValue = double.tryParse(controller.rate.value) ?? 0.0;
                double qtyValue = double.tryParse(controller.qty.value) ?? 0.0;
                controller.amountValue.value = rateValue * qtyValue;
                controller.fat.value = controller2.fat.value;
                controller.snf.value = controller2.snf.value;
           
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


  Widget _buildPortraitLayout(double padding) {
    return Column(
      children: [
        // Static content
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
                  controller.currentDate.value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )),
                  Obx(() => Text(
              controller.timeShift.value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            )),
          ],
        ),
      
        SizedBox(height: padding),

        _buildMemberDetailsRow(padding),

        SizedBox(height: padding),
        _buildQtyMilkTypeRow(padding),

        SizedBox(height: padding),
        _buildFatSnfRow(padding),

        SizedBox(height: padding),

       

        _buildRateAmountRow(padding),

        SizedBox(height: padding),

        _buildButtons(),

        SizedBox(height: padding),

        // Scrollable Data Table
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: buildDataTable(),
            ),
          ),
        ),
      ],
    );
  }

Widget _buildLandscapeLayout(double padding) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Text(
                  controller.currentDate.value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )),
            Obx(() => Text(
                  controller.timeShift.value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )),
          ],
        ),

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
                    Row(
           children: [
             Expanded(
          child:

SizedBox(
 height: 50, // Adjust height as needed
  child: TextFormField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: 'Society Code',
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
    ),
    style: TextStyle(fontSize: 14),
    onChanged: (value) {
      controller.mppCode.value = value;
      controller.fetchMemberNameDetails(value);
    },
    validator: (value) => value!.isEmpty ? 'Please enter Society Code' : null,
  ),
), ),
        
        SizedBox(width: padding),
        Expanded(
          child: SizedBox( height: 50,
            child: TextFormField(
               keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Society Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                controller.mppName.value = value;
                controller.fetchOtherCodeByFirstName(value);
              },
              controller:
                  TextEditingController(text: controller.mppName.value),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter Society Name' : null,
            ),
          ),
        ),
    
       SizedBox(width: padding),
    ],
         ),
         
                                
                        Row(
        children: [
           Padding(
                 padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.061),
             child: Text("Milk Type :", style: TextStyle(fontWeight: FontWeight.bold),         ),
           ),
          SizedBox(width: padding),
          Expanded(
            child: Obx(() => DropdownButtonFormField<String>(
                  value: controller2.selectedMilkType.value.isEmpty
                      ? null
                      : controller2.selectedMilkType.value,
                  hint: Text('Select Milk Type'),
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
                    controller.calculateAmountValue();
                    controller.milkType.value = controller2.selectedMilkType.value;
               
                  },
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please select Milk Type' : null,
                )),
          ),
        ],
      ),
                       SizedBox(height: Get.width * 0.01),    
                       Row(
                         children: [
                           SizedBox(height: Get.width * 0.01),
                           
         Expanded(
          child: SizedBox( height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'QTY (L)',
                 border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
              ),
              keyboardType: TextInputType.number,
              
              onChanged: (value) {
                controller.qty.value = value;
                controller.calculateAmountValue();
              },
              controller: TextEditingController(text: controller.qty.value),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter Quantity' : null,
            ),
          ),
        ),
          SizedBox(width: padding),
        Expanded(
          child: SizedBox( height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Fat',
                 border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller2.fat.value = value;
                controller2.filterData();
                controller.calculateAmountValue();
                controller.fat.value = controller2.fat.value;
              },
              validator: (value) => value!.isEmpty ? 'Please enter Fat' : null,
            ),
          ),
        ),
        SizedBox(width: padding),
        Expanded(
          child: SizedBox( height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'SNF',
                 border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller2.snf.value = value;
                controller2.filterData();
                controller.calculateAmountValue();
                controller.snf.value = controller2.snf.value;
              },
              validator: (value) => value!.isEmpty ? 'Please enter SNF' : null,
            ),
          ),
        ),
           
                         ],
                       ),
                        SizedBox(height: Get.width * 0.01),   
                        _buildRateAmountRow(padding),
                        SizedBox(height: Get.width * 0.01),
                        _buildButtons(),
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



  Widget _buildMemberDetailsRow(double padding) {
    return Row(
      children: [
        Expanded(
          child: SizedBox( height: 50,
            child: TextFormField( keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Society Code',
                 border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
              ),
              onChanged: (value) {
                controller.mppCode.value = value;
                controller.fetchMemberNameDetails(value);
              },
              
              controller: TextEditingController(text: controller.mppCode.value),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter Society Code' : null,
            ),
          ),
        ),
        SizedBox(width: padding),
        Expanded(
          child: SizedBox( height: 50,
            child: TextFormField( keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Society Name',
                 border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
              ),
              onChanged: (value) {
                controller.mppName.value = value;
                controller.fetchOtherCodeByFirstName(value);
              },
              controller:
                  TextEditingController(text: controller.mppName.value),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter Society Name' : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFatSnfRow(double padding) {
    return Row(
      children: [
        Expanded(
          child: SizedBox( height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'QTY (L)',
                 border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller.qty.value = value;
                controller.calculateAmountValue();
              },
              controller: TextEditingController(text: controller.qty.value),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter Quantity' : null,
            ),
          ),
        ),
          SizedBox(width: padding),
        Expanded(
          child: SizedBox( height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Fat',
                 border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller2.fat.value = value;
                controller2.filterData();
                controller.calculateAmountValue();
                controller.fat.value = controller2.fat.value;
              },
              validator: (value) => value!.isEmpty ? 'Please enter Fat' : null,
            ),
          ),
        ),
        SizedBox(width: padding),
        Expanded(
          child: SizedBox( height: 50,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'SNF',
                 border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller2.snf.value = value;
                controller2.filterData();
                controller.calculateAmountValue();
                controller.snf.value = controller2.snf.value;
              },
              validator: (value) => value!.isEmpty ? 'Please enter SNF' : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQtyMilkTypeRow(double padding) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.11),
      child: 
      Row(
        children: [
           Padding(
                 padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.061),
             child: Text("Milk Type", style: TextStyle(fontWeight: FontWeight.bold),         ),
           ),
          SizedBox(width: padding),
          Expanded(
            child: Obx(() => DropdownButtonFormField<String>(
                  value: controller2.selectedMilkType.value.isEmpty
                      ? null
                      : controller2.selectedMilkType.value,
                  hint: Text('Select Milk Type'),
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
                    controller.calculateAmountValue();
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

  Widget _buildRateAmountRow(double padding) {
    return Row(
      children: [
        Expanded(
          child: Obx(() => SizedBox( height: 30,
            child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Rate',
                     border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
                  ),
                  controller: TextEditingController(text: controller.rate.value),
                ),
          )),
        ),
        SizedBox(width: padding),
        Expanded(
          child: Obx(() => SizedBox(
           height: 30,
            child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                     border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Reduce padding
                  ),
                  controller:
                      TextEditingController(text: controller.amountValue.value.toString()),
                ),
          )),
        ),
      ],
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
          controller.amountValue.value =  0.0;
          controller.qty.value = "";
          controller.clearCollections();
            _formKey.currentState!.reset(); // Reset form validation state
           controller.clearCollections();
           //controller2.selectedMilkType.value = ""; // Clear all data
    });
            }

          },
          child: Text('Save', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
        ),
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.01),
        //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //     backgroundColor: CustomColors.appRedButtomColor,
        //   ),
        //   onPressed: () {
        //     controller.clearCollections();
        //     _formKey.currentState!.reset(); // Reset form validation state
        //    controller.clearCollections();
        //    controller2.selectedMilkType.value = ""; // Clear all data
        //   },
        //   child: Text('Clear Data', style: TextStyle(fontSize: 20, color: CustomColors.bgColor)),
        // ),
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
    DataColumn(label: Text('Code')),
    DataColumn(label: Text('Qty')),
    DataColumn(label: Text('Fat')),
    DataColumn(label: Text('SNF')),
    DataColumn(label: Text('Rate')),
    DataColumn(label: Text('Amount')),

      ],
      rows: List.generate(controller.mppCollData.length, (index) {
        final data = controller.mppCollData[index];
        final isGrey = index % 2 == 0;
        return DataRow(
          color: WidgetStateProperty.all(isGrey ? Colors.white : Colors.grey[200]),
          cells: [


 DataCell(Center(child: Text("${data["sampleId"]}"))),
DataCell(Center(child: Text("${data['mppOtherCode']}"))),
DataCell(Center(child: Text("${data['weight']}"))),
DataCell(Center(child: Text("${data['fat']}"))),
DataCell(Center(child: Text((double.tryParse(data['snf'].toString())?.toStringAsFixed(2)) ?? "0.00"))),
DataCell(Center(child: Text((double.tryParse(data['rate'].toString())?.toStringAsFixed(2)) ?? "0.00"))),
DataCell(Center(child: Text((double.tryParse(data["amount"].toString())?.toStringAsFixed(2)) ?? "0.00"))),
    
          ],
        );
      }),
    )));}
  }




