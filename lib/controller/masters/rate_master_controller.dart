import 'package:get/get.dart';

class RateMasterController extends GetxController {
  var isLoading = true.obs;
  var rateData = [].obs;

  @override
  void onInit() {
    fetchRateData();
    super.onInit();
  }

  void fetchRateData() async {
    try {
      isLoading(true);
      // Replace with your API call logic
      var response = await fetchFromServer(); // Your API call here
      if (response != null) {
        rateData.value = response; // Assuming response is a list
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
        'bmcCode': 'BMC-001',
        'mppCode': 'MCC001',
        'rateCode': 'Plant001',
        'rateDesc': 'Company001',
        'rateLocation': '2024-01-01',
        'effectiveDate': 'Address 1',
        'effectiveShift': 'Dock 1',
        'uploadDate': 'December ',
        'downloadDate': 'December',
      },
      // Add more data as needed
    ];
  }
}
