

// Controller for managing form states
import 'package:get/get.dart';

class TruckArrivalController extends GetxController {
  var isForm1Visible = true.obs;

  // Form 1 fields
  var selectedDock = ''.obs;
  var selectedDate = ''.obs;
  var selectedShift = ''.obs;

  // Form 2 fields
  var selectedRoute = ''.obs;
  var arrival = ''.obs;
  var truckNumber = ''.obs;

  // Saved data for Form 2
  var savedData = <Map<String, dynamic>>[].obs;

   saveData() {
    int sequenceNo = savedData.length + 1;
    savedData.add({
      'sequenceNo': sequenceNo,
      'date': selectedDate.value,
      'shift': selectedShift.value,
      'truckNumber': truckNumber.value,
      'arrival': arrival.value,
      'time': arrival.value,
    });
  }
}
