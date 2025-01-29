
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kanha_bmc/database/kanha_db.dart';
import '../masters/rate_check_controller.dart';

class BMCCollectionController extends GetxController {
   final controller2 = Get.put(RateCheckMasterController());
 final KanhaDBHelper _kanhaDBHelper = KanhaDBHelper.instance;

  var isLoading = true.obs;
  var memberCollData = <Map<String, dynamic>>[].obs;
  
// Perform the multiplication
// Corrected and added an observable for the calculated amountValue
var currentDate =   DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
var currentTime =   DateFormat('HH:mm').format(DateTime.now()).obs;
var timeShift = ''.obs;
var membercode = ''.obs;
var memberName = ''.obs;

var memberSocCode = ''.obs;
var mppCode = ''.obs;

var milkType = ''.obs;
var qty = ''.obs;
var fat = ''.obs;
var snf = ''.obs;
var rate = ''.obs; // Keep rate as a string because it might be from user input
var amountValue = 0.0.obs; // Observable to hold the calculated amount value

  @override
  void onInit() {
    super.onInit();
 Future.wait([
        _initializeDateAndTimeShift()
    ]).then((_) {
      // Call afterSyncing to handle post-sync actions after both fetches complete
       initializeMemberCollData();
    });



  }

Future<void> initializeMemberCollData() async {
  //isLoading.value = true;
  try {
    // Ensure the timeShift condition is resolved
    final timeShiftFilter = timeShift.value == "Morning" ? "M" : "E";

    // Fetch data filtered by the current date and time shift
    final data = await fetchLocalData(
      date: currentDate.value.toString(),
      shift: timeShiftFilter,
    );

    // Update memberCollData with the filtered results
    memberCollData.assignAll(data);
  } catch (e) {
    print("Error while initializing member collection data: $e");
  } finally {
    //isLoading.value = false;
  }
}


Future<List<Map<String, dynamic>>> fetchLocalData({
  required String date,
  required String shift,
}) async {
  final db = await _kanhaDBHelper.database;

  // Fetch and filter data using `where` and `whereArgs`
  final filteredData = await db.query(
    'memberCollection', // Table name
    where: 'collection_date = ? AND shift_code = ?', // Filter condition
    whereArgs: [date, shift], // Filter values
  );
  qty.value="";
 // clearCollections();
print(filteredData);
  return filteredData;
 
}





// Function to calculate and update amountValue
void calculateAmountValue() {
  double rateValue = double.tryParse(rate.value) ?? 0.0;
  double qtyValue = double.tryParse(qty.value) ?? 0.0;

  amountValue.value = rateValue * qtyValue;
}


  // Initialize the date and time shift
  Future _initializeDateAndTimeShift()async {
    DateTime now = await DateTime.now();
    // Determine Morning or Evening based on time
    int currentHour = now.hour;
    timeShift.value = currentHour < 12 ? 'Morning' : 'Evening';
  }

  // Optional: Method to refresh the date and time shift (if needed)
  void refreshDateAndTimeShift() {
    _initializeDateAndTimeShift();
  }




void fetchMemberNameDetails(String otherCode) async {
  try {
    // Get the database instance
    final db = await KanhaDBHelper.instance.database;

    // Query the memberMaster table for the member name
    final result = await db.query(
      'memberMaster',
      //columns: ['firstName'], // Assuming 'mppName' is the member name column
      where: 'otherCode = ?',
      whereArgs: [otherCode],
    );

    if (result.isNotEmpty) {
      // Set the member name if a match is found
      memberName.value = result.first['firstName'] as String;
     memberSocCode.value =   result.first['socCode'].toString();

  final getMppCode = await db.query(
      'mppMaster',
     columns: ['code'], // Assuming 'code' is the mpp name column
      where: 'socCode = ?',
      whereArgs: [memberSocCode.value.toString()],
    );
  mppCode.value = getMppCode.first['code'] as String;


    } else {
      // Clear the member name if no match is found
    memberName.value = '';
    }
  } catch (e) {
    // Handle any database or query errors
    memberName.value = 'Error fetching member details';
    print('Error fetching member details: $e');
  }
}

 
Future<void> fetchOtherCodeByFirstName(String memberName) async {
  try {
    final db = await KanhaDBHelper.instance.database;

    final result = await db.query(
      'memberMaster',
     // columns: ['otherCode'], // Fetch the otherCode column
      where: 'firstName = ?',  // Match the firstName with the passed value
      whereArgs: [memberName], // Use the passed firstName (e.g., 'DEMO')
    );

    if (result.isNotEmpty) {
      // Fetch the otherCode value
      membercode.value = result.first['otherCode'] as String;

      print('Other Code: $membercode.value');

 memberSocCode.value =   result.first['socCode'].toString();

  final getMppCode = await db.query(
      'mppMaster',
     columns: ['code'], // Assuming 'code' is the mpp name column
      where: 'socCode = ?',
      whereArgs: [memberSocCode.value.toString()],
    );
  mppCode.value = getMppCode.first['code'] as String;

    } else {
      print('No record found for firstName: ${membercode.value}');
      membercode.value = '';
    }
  } catch (e) {
     // Handle any database or query errors
    membercode.value = 'Error fetching code details';
    print('Error fetching member details: $e');
}
}

void clearCollections() {
  membercode.value = '';
  memberName.value = '';
  qty.value = '';
  rate.value = '0.0';
  amountValue.value = 0.0;
    fat.value = '';
    snf.value = '';
    rate.value = '';
   // milkType.value = '';
  //initializeMemberCollData();
    // Get.to(MemberCollectionScreen());
    // Get.off(MemberCollectionScreen());
}


Future<void> saveEntry() async {
  milkType.value = await controller2.updateSelectedMilkType(milkType.value);

  final entry = {
    'farmer_collection_main_id' : "",   
    'collection_date': currentDate.value.toString(), /// current Date   
    'mpp_code':  mppCode.value.toString(), /// mpp table  "othercode"  
    'shift_code': timeShift.value == "Morning" ? "M" : "E", ///ask            
    'member_code': membercode.value.toString(),    
    'member_name': memberName.value.toString(),
    'milk_type_code': milkType.value.toString(), 
    'milk_quality_type_code': "", 
    'sample_no': "",   /// sift by incremental         
    'fat': fat.value.toString(),
    'snf': snf.value.toString(),
    'clr': "",                  
    'rate': rate.value.toString(),
    'amount': amountValue.value.toString(),
    'qty': qty.value.toString(),
    'is_qty_auto': "true",    ///  true     
    'is_quality_auto': "true",  /// true  
    'quality_sample_time': currentTime.value.toString(),   ///  /// current time  
    'is_sync': "false",             // false
    'CollectionType': "Farmer",  /// Farmer
    'can': ""       // 0            
  };

  // Insert the entry into the database
  await insertData([entry]);
}


Future<void> insertData(List<Map<String, dynamic>> entries) async {
  final db = await _kanhaDBHelper.database;

  try {
    int? sampleNo;
    final result = await db.rawQuery('''
      SELECT sample_no
      FROM memberCollection
      WHERE collection_date = ? AND shift_code = ?
      ORDER BY sample_no DESC
      LIMIT 1
    ''', [currentDate.value, timeShift.value == "Morning" ? "M" : "E"]);

    if (result.isNotEmpty) {
      sampleNo = (result.first['sample_no'] as int?) ?? 0;
      sampleNo++;
    } else {
      sampleNo = 1;
    }
  // Clear existing data before inserting new data
   // await db.delete('memberCollection');

    await db.transaction((txn) async {
      for (var entry in entries) {
        entry['sample_no'] = sampleNo.toString();
       await txn.insert('memberCollection', entry);
      }
    });
  // Show success message
    Get.snackbar(
      'Success',
      'Data saved successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    print("Data successfully inserted.");
  } catch (e) {
    print('Error inserting data: $e');
    rethrow;
  }

controller2.fat.value = "";
controller2.snf.value = "";
// controller2.selectedMilkType.value = "";
// controller2.milk.value = "";
// controller2.milkTypes.value = [];
controller2.rtpl.value = "";
clearCollections(); // Clear the form fields after saving

  // Refresh memberCollData after saving
  await initializeMemberCollData();
}




}