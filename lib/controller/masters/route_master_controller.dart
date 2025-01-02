import 'package:get/get.dart';

class RouteMasterController extends GetxController {
  var isLoading = true.obs;
  var routeData = [].obs;

  @override
  void onInit() {
    fetchRouteData();
    super.onInit();
  }

  void fetchRouteData() async {
    try {
      isLoading(true);
      // Replace with your API call logic
      var response = await fetchFromServer(); // Your API call here
      if (response != null) {
        routeData.value = response; // Assuming response is a list
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
        'routeNameCode': 'BMC-001',
        'mccNameCode': 'MCC001',
        'plantNameCode': 'Plant001',
        'companyNameCode': 'Company001',
      },
      // Add more data as needed
    ];
  }
}
