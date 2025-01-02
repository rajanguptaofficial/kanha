import 'package:get/get.dart';

class BmcMasterController extends GetxController {
  var isLoading = true.obs;
  var bmcData = [].obs;

  @override
  void onInit() {
    fetchBmcData();
    super.onInit();
  }

  void fetchBmcData() async {
    try {
      isLoading(true);
      // Replace with your API call logic
      var response = await fetchFromServer(); // Your API call here
      if (response != null) {
        bmcData.value = response; // Assuming response is a list
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<List<Map<String, dynamic>>> fetchFromServer() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    return [
      {
        'bmcNameCode': 'BMC-001',
        'mccNameCode': 'MCC001',
        'plantNameCode': 'Plant001',
        'companyNameCode': 'Company001',
        'effectiveDate': '2024-01-01',
        'address': 'Address 1',
        'dock': 'Dock 1',
      },
      // Add more data as needed
    ];
  }
}
