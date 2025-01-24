import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kanha_bmc/database/kanha_db.dart';

import '../masters/rate_check_controller.dart';

class MemberCollectionController extends GetxController {
 
 final KanhaDBHelper _kanhaDBHelper = KanhaDBHelper.instance;

// Perform the multiplication
// Corrected and added an observable for the calculated amountValue
var currentDate = DateTime.now().obs;
var timeShift = ''.obs;
var code = ''.obs;
var memberName = ''.obs;
var milkType = ''.obs;
var qty = ''.obs;
var fat = ''.obs;
var snf = ''.obs;
var rate = ''.obs; // Keep rate as a string because it might be from user input
var amountValue = 0.0.obs; // Observable to hold the calculated amount value


// Function to calculate and update amountValue
void calculateAmountValue() {
  double rateValue = double.tryParse(rate.value) ?? 0.0;
  double qtyValue = double.tryParse(qty.value) ?? 0.0;

  amountValue.value = rateValue * qtyValue;
}

  var savedEntries = <Map<String, String>>[].obs;

  final KanhaDBHelper _dbHelper = KanhaDBHelper.instance;

  late final controller2 = Get.put(RateCheckMasterController());



  @override
  void onInit() {
    super.onInit();
   // fetchSavedEntries();
    _initializeDateAndTimeShift();

  }

  // Initialize the date and time shift
  void _initializeDateAndTimeShift() {
    DateTime now = DateTime.now();

    // Set the current date in 'yyyy-MM-dd' format
   // currentDate.value = DateFormat('yyyy-MM-dd').format(now) as DateTime;

    // Determine Morning or Evening based on time
    int currentHour = now.hour;
    timeShift.value = currentHour < 12 ? 'Morning' : 'Evening';
  }

  // Optional: Method to refresh the date and time shift (if needed)
  void refreshDateAndTimeShift() {
    _initializeDateAndTimeShift();
  }

  // // Fetch member details
  // void fetchMemberDetails(String code) {
  //   // Simulate fetching member details
  //   memberName.value = 'Member $code';
  // }

  // Calculate rate and amount based on qty, fat, and snf
  // void calculateRateAndAmount() {
  //   double qtyValue = double.tryParse(qty.value) ?? 0;
  //   double fatValue = double.tryParse(fat.value) ?? 0;
  //   double snfValue = double.tryParse(snf.value) ?? 0;

  //   rate.value = (fatValue + snfValue).toStringAsFixed(2);
  //   amount.value = (qtyValue * (fatValue + snfValue)).toStringAsFixed(2);
  // }

  // Clear all input fields
  void clearFields() {
    
    code.value = 'sampleNo';
    memberName.value = '';
    milkType.value = '';
    qty.value = '';
    fat.value = '';
    snf.value = '';
    rate.value = '';
    //amountV.value = '';
  }




void fetchMemberNameDetails(String otherCode) async {
  try {
    // Get the database instance
    final db = await KanhaDBHelper.instance.database;

    // Query the memberMaster table for the member name
    final result = await db.query(
      'memberMaster',
      columns: ['firstName'], // Assuming 'mppName' is the member name column
      where: 'otherCode = ?',
      whereArgs: [otherCode],
    );

    if (result.isNotEmpty) {
      // Set the member name if a match is found
      memberName.value = result.first['firstName'] as String;
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

 


// "DEMO  "
Future<void> fetchOtherCodeByFirstName(String memberName) async {
  try {
    final db = await KanhaDBHelper.instance.database;

    final result = await db.query(
      'memberMaster',
      columns: ['otherCode'], // Fetch the otherCode column
      where: 'firstName = ?',  // Match the firstName with the passed value
      whereArgs: [memberName], // Use the passed firstName (e.g., 'DEMO')
    );

    if (result.isNotEmpty) {
      // Fetch the otherCode value
      code.value = result.first['otherCode'] as String;
      print('Other Code: $code.value');
    } else {
      print('No record found for firstName: ${code.value}');
      code.value = '';
    }
  } catch (e) {
     // Handle any database or query errors
    code.value = 'Error fetching code details';
    print('Error fetching member details: $e');
}
}



// // Save entry to the database
// Future<void> saveEntry() async {
//   // Get the current date and time
//   final now = DateTime.now();

//   // Format the date (e.g., "YYYY-MM-DD")
//   final formattedDate = DateFormat('yyyy-MM-dd').format(now);

//   // Format the time (e.g., "HH:mm:ss")
//   final formattedTime = DateFormat('HH:mm:ss').format(now);
//   milkType.value = await controller2.updateSelectedMilkType(milkType.value);
//   // Create an entry map with the current data
//   final entry = {
//     'date': formattedDate,
//     'time': formattedTime,
//     'memberCode': code.value,
//     'memberName': memberName.value,
//     'fat': fat.value,
//     'snf': snf.value,
//     'qty': qty.value,
//     'milkType': milkType.value,
//     'rate': rate.value,
//     'amount': amountValue.value,
//   };

//   // Insert the entry into the database
//   await insertData([entry]);
// }

// // Insert data into the database
// Future<void> insertData(List<Map<String, dynamic>> entries) async {
//   final db = await _kanhaDBHelper.database;

//   // Clear existing data before inserting new data
//   await db.transaction((txn) async {
//    //await txn.delete('memberCollection');
//     for (var entry in entries) {
//    // await txn.insert('memberCollection', entry);
//     }
//   });
// }




Future<void> saveEntry() async {
  // Get the current date and time
  final now = DateTime.now();

  // Format the date (e.g., "YYYY-MM-DD")
  final formattedDate = DateFormat('yyyy-MM-dd').format(now);

  // Format the time (e.g., "HH:mm:ss")
  final formattedTime = DateFormat('HH:mm:ss').format(now);

  // Ensure milkType value is updated
  milkType.value = await controller2.updateSelectedMilkType(milkType.value);

  // Create an entry map with the current data
  final entry = {
    'farmer_collection_main_id' : null,   
    'collection_date': formattedDate, /// current Date   
    'mpp_code': null, /// mpp table  "othercode"              
    'member_code': code.value,    
    'member_name': memberName.value,
    'milk_type_code': milkType.value, 
    'milk_quality_type_code': null, 
    'sample_no': null,    /// sift by incremental         
    'fat': fat.value,
    'snf': snf.value,
    'clr': null,                  
    'rate': rate.value,
    'amount': amountValue.value,
    'qty': qty.value,
    'is_qty_auto': false,    ///  true     
    'is_quality_auto': false,  /// true  
    'quality_sample_time': null,   ///  /// current time  
    'is_sync': false,             // false
    'CollectionType': null,  /// Farmer
    'can': null       // 0            
  };

  // Insert the entry into the database
  await insertData([entry]);
}


Future<void> insertData(List<Map<String, dynamic>> entries) async {
  final db = await _kanhaDBHelper.database;
  // Insert entries into the memberCollection table
  await db.transaction((txn) async {
    for (var entry in entries) {
      await txn.insert('memberCollection', entry);
    }
  });
}



  // // Fetch saved entries from the database
  // Future<void> fetchSavedEntries() async {
  //   final entries = await _dbHelper.getCollections();
  //   savedEntries.value = entries.map((e) => e.cast<String, String>()).toList();
  // }

  //   Future<void> clearCollections() async {
  //  // final entries = await 
  //   _dbHelper.clearCollections();
  //   //savedEntries.value = entries.map((e) => e.cast<String, String>()).toList();
  // }

  // // Check for network connectivity
  // Future<bool> isConnected() async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   return connectivityResult != ConnectivityResult.none;
  // }

  // // Sync local database to the server
  // Future<void> syncLocalToServer() async {
  //   final db = await DatabaseHelper().database;

  //   // Get unsynced records
  //   List<Map<String, dynamic>> unsyncedRecords = await db.query(
  //     'collections',
  //     where: 'isSynced = ?',
  //     whereArgs: [0],
  //   );

  //   if (unsyncedRecords.isNotEmpty) {
  //     // Send data to the server
  //     final response = await http.post(
  //       Uri.parse('https://yourserver.com/sync'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'data': unsyncedRecords}),
  //     );

  //     if (response.statusCode == 200) {
  //       // Mark records as synced
  //       for (var record in unsyncedRecords) {
  //         await db.update(
  //           'collections',
  //           {'isSynced': 1},
  //           where: 'id = ?',
  //           whereArgs: [record['id']],
  //         );
  //       }
  //     }
  //   }
  // }

  // // Sync server data to the local database
  // Future<void> syncServerToLocal() async {
  //   final db = await DatabaseHelper().database;

  //   // Get data from server
  //   final response = await http.get(
  //     Uri.parse('https://yourserver.com/sync'),
  //   );

  //   if (response.statusCode == 200) {
  //     List<dynamic> serverData = jsonDecode(response.body)['data'];

  //     for (var record in serverData) {
  //       // Check if record already exists
  //       List<Map<String, dynamic>> existingRecord = await db.query(
  //         'collections',
  //         where: 'sampleNo = ?',
  //         whereArgs: [record['sampleNo']],
  //       );

  //       if (existingRecord.isEmpty) {
  //         // Insert new record
  //         await db.insert('collections', {
  //           'sampleNo': record['sampleNo'],
  //           'code': record['code'],
  //           'qty': record['qty'],
  //           'fat': record['fat'],
  //           'snf': record['snf'],
  //           'rate': record['rate'],
  //           'amount': record['amount'],
  //           'isSynced': 1,
  //           'lastUpdated': record['lastUpdated'],
  //         });
  //       } else {
  //         // Update existing record if server data is newer
  //         if (record['lastUpdated'].compareTo(existingRecord[0]['lastUpdated']) > 0) {
  //           await db.update(
  //             'collections',
  //             {
  //               'code': record['code'],
  //               'qty': record['qty'],
  //               'fat': record['fat'],
  //               'snf': record['snf'],
  //               'rate': record['rate'],
  //               'amount': record['amount'],
  //               'isSynced': 1,
  //               'lastUpdated': record['lastUpdated'],
  //             },
  //             where: 'sampleNo = ?',
  //             whereArgs: [record['sampleNo']],
  //           );
  //         }
  //       }
  //     }
  //   }
  // }

  // // Sync data between local database and server
  // void syncData() async {
  //   if (await isConnected()) {
  //     await syncLocalToServer();
  //     await syncServerToLocal();
  //   }
 // }
}
