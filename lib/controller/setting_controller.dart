import 'package:get/get.dart';

class SettingsController extends GetxController {
  var devices = List.generate(5, (index) => true.obs).obs;
   var printdevices = List.generate(5, (index) => true.obs).obs;
  var selectedDeviceMake = List.generate(5, (index) => 'KM002'.obs).obs;
  var selectedBaudRate = List.generate(5, (index) => 'KM002'.obs).obs;
  var delayEnabled = true.obs;
  var inputSpeed = ''.obs;

}