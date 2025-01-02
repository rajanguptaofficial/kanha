import 'package:get/get.dart';

class MemberMasterController extends GetxController {
  var isLoading = true.obs;
  var memberData = [].obs;

  @override
  void onInit() {
    fetchMemberData();
    super.onInit();
  }

  void fetchMemberData() async {
    try {
      isLoading(true);
      // Replace with your API call logic
      var response = await fetchFromServer(); // Your API call here
      if (response != null) {
        memberData.value = response; // Assuming response is a list
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
        'societyCodeName': 'SuuC001',
        'memberCodeName': 'MCC001',
        'membShortCode': 'Plant001',
        'farmerName': 'Pawan',
        'mobNo': '9454826162',
        'Status': ' 1',
      },
      // Add more data as needed
    ];
  }
}
