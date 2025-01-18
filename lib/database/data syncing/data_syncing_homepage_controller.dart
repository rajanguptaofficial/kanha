import 'package:get/get.dart';
import 'package:kanha_bmc/controller/masters/member_master_controller.dart';
import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';
import 'package:kanha_bmc/pages/dashboard.dart';

class DataSyncingHomepageScreenController extends GetxController {
  RxBool isLoading = true.obs;

  final RateCheckController rateCheckController = Get.put(RateCheckController());
  final MemberMasterController memberMasterController = Get.put(MemberMasterController());

  Future<void> afterSyncing() async {
    await Future.delayed(const Duration(seconds: 20));
    isLoading.value = false; // Stop loading after delay
    Get.off(DashboardScreen());
  }

  @override
  void onInit() {
    super.onInit();

    // Perform data fetch for both controllers
    Future.wait([
      rateCheckController.fetchData(),
      memberMasterController.fetchData(),
    ]).then((_) {
      // Call afterSyncing to handle post-sync actions after both fetches complete
      afterSyncing();
    });
  }
}




// import 'package:get/get.dart';
// import 'package:kanha_bmc/controller/masters/member_master_controller.dart';
// import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';

// class DataSyncingHomepageScreenController extends GetxController {
//   RxBool isLoading = true.obs;

//   final RateCheckController rateCheckController = Get.put(RateCheckController());
//     final MemberMasterController memberMasterController = Get.put(MemberMasterController());

//   Future<void> afterSyncing() async {
//     await Future.delayed(const Duration(seconds: 5));
//     isLoading.value = false; // Stop loading after delay
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     rateCheckController.fetchData().then((_) {
//       // Call afterSyncing to handle post-sync actions
//       afterSyncing();
//     });


// memberMasterController.fetchData().then((_) {
//       // Call afterSyncing to handle post-sync actions
//       afterSyncing();
//     });

//   }
// }