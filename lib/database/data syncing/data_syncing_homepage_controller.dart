 import 'package:get/get.dart';
import 'package:kanha_bmc/controller/dashboard_controller.dart';
import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';

class DataSyncingHomepageScreenController extends GetxController {

  RxBool isLoading = true.obs;


  //Instance of RateCheckController
 final RateCheckController rateCheckController = Get.put(RateCheckController());


  Future<void> afterSyncing() async {
    Future.delayed(const Duration(seconds: 5), () {
    
     Get.off(() =>  DashboardController());// Navigate to Dashboard
     
    });
  }

  @override
  void onInit() {
    super.onInit();
    // Call fetchData() from RateCheckController
    rateCheckController.fetchData(isLoading);
  }

}