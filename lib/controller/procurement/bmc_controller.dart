import 'package:get/get.dart';
import 'package:kanha_bmc/common/database_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

class BMCCollectionController extends GetxController {
  var currentDate = DateTime.now().obs;
  var timeShift = ''.obs;
  var code = ''.obs;
  var memberName = ''.obs;
  var milkType = ''.obs;
  var qty = ''.obs;
  var fat = ''.obs;
  var snf = ''.obs;
  var rate = ''.obs;
  var amount = ''.obs;
  var savedEntries = <Map<String, String>>[].obs;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    fetchSavedEntries();
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

  // Fetch member details
  void fetchMemberDetails(String code) {
    // Simulate fetching member details
    memberName.value = '$code';
  }

  // Calculate rate and amount based on qty, fat, and snf
  void calculateRateAndAmount() {
    double qtyValue = double.tryParse(qty.value) ?? 0;
    double fatValue = double.tryParse(fat.value) ?? 0;
    double snfValue = double.tryParse(snf.value) ?? 0;

    rate.value = (fatValue + snfValue).toStringAsFixed(2);
    amount.value = (qtyValue * (fatValue + snfValue)).toStringAsFixed(2);
  }

  // Clear all input fields
  void clearFields() {
    ;
    code.value = 'sampleNo';
    memberName.value = '';
    milkType.value = '';
    qty.value = '';
    fat.value = '';
    snf.value = '';
    rate.value = '';
    amount.value = '';
  }

  // Save entry to the database
  Future<void> saveEntry() async {
    final entry = {
      'sampleNo': DateTime.now().millisecondsSinceEpoch.toString(),
      'code': code.value,
      'qty': qty.value,
      'fat': fat.value,
      'snf': snf.value,
      'rate': rate.value,
      'amount': amount.value,
    };

    await _dbHelper.insertCollection(entry);
    fetchSavedEntries();
    clearCollections();
    clearFields();
  }

  // Fetch saved entries from the database
  Future<void> fetchSavedEntries() async {
    final entries = await _dbHelper.getCollections();
    savedEntries.value = entries.map((e) => e.cast<String, String>()).toList();
  }

  Future<void> clearCollections() async {
    // final entries = await
    _dbHelper.clearCollections();
    //savedEntries.value = entries.map((e) => e.cast<String, String>()).toList();
  }

  // Check for network connectivity
  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Sync local database to the server
  Future<void> syncLocalToServer() async {
    final db = await DatabaseHelper().database;

    // Get unsynced records
    List<Map<String, dynamic>> unsyncedRecords = await db.query(
      'collections',
      where: 'isSynced = ?',
      whereArgs: [0],
    );

    if (unsyncedRecords.isNotEmpty) {
      // Send data to the server
      final response = await http.post(
        Uri.parse('https://yourserver.com/sync'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'data': unsyncedRecords}),
      );

      if (response.statusCode == 200) {
        // Mark records as synced
        for (var record in unsyncedRecords) {
          await db.update(
            'collections',
            {'isSynced': 1},
            where: 'id = ?',
            whereArgs: [record['id']],
          );
        }
      }
    }
  }

  // Sync server data to the local database
  Future<void> syncServerToLocal() async {
    final db = await DatabaseHelper().database;

    // Get data from server
    final response = await http.get(
      Uri.parse('https://yourserver.com/sync'),
    );

    if (response.statusCode == 200) {
      List<dynamic> serverData = jsonDecode(response.body)['data'];

      for (var record in serverData) {
        // Check if record already exists
        List<Map<String, dynamic>> existingRecord = await db.query(
          'collections',
          where: 'sampleNo = ?',
          whereArgs: [record['sampleNo']],
        );

        if (existingRecord.isEmpty) {
          // Insert new record
          await db.insert('collections', {
            'sampleNo': record['sampleNo'],
            'code': record['code'],
            'qty': record['qty'],
            'fat': record['fat'],
            'snf': record['snf'],
            'rate': record['rate'],
            'amount': record['amount'],
            'isSynced': 1,
            'lastUpdated': record['lastUpdated'],
          });
        } else {
          // Update existing record if server data is newer
          if (record['lastUpdated']
                  .compareTo(existingRecord[0]['lastUpdated']) >
              0) {
            await db.update(
              'collections',
              {
                'code': record['code'],
                'qty': record['qty'],
                'fat': record['fat'],
                'snf': record['snf'],
                'rate': record['rate'],
                'amount': record['amount'],
                'isSynced': 1,
                'lastUpdated': record['lastUpdated'],
              },
              where: 'sampleNo = ?',
              whereArgs: [record['sampleNo']],
            );
          }
        }
      }
    }
  }

  // Sync data between local database and server
  void syncData() async {
    if (await isConnected()) {
      await syncLocalToServer();
      await syncServerToLocal();
    }
  }
}
