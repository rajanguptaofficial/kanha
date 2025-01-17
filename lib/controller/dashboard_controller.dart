 import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedTime = "Morning".obs;
  var selectedDate = "".obs;



  @override
  void onInit() {
    super.onInit();
    // Set the current date by default
    selectedDate.value = "${DateTime.now().toLocal()}".split(' ')[0];
  
  }

  void updateTime(String newTime) {
    selectedTime.value = newTime;
  }

  void updateDate(String newDate) {
    selectedDate.value = newDate;
  }
}