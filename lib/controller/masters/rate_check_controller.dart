import 'package:get/get.dart';

// Controller for managing the state of the form
class RateCheckController extends GetxController {
  var fat = ''.obs; // To store the input for "Fat"
  var snf = ''.obs; // To store the input for "Snf"
   var rtpl = ''.obs; // To store the input for "Snf"
  var selectedMilkType = ''.obs; // To store the selected "Milk Type"

  List<String> milkTypes = ['Mix', 'Buffalo', 'Cow']; // Milk Type options
}
