import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedTime = "Morning".obs; // Observable for dropdown
  var selectedDate = "".obs;        // Observable for selected date

  void updateTime(String newTime) {
    selectedTime.value = newTime;
  }

  void updateDate(String newDate) {
    selectedDate.value = newDate;
  }
}