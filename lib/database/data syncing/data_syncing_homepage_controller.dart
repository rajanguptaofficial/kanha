import 'package:get/get.dart';
import 'package:kanha_bmc/controller/masters/bmc_master_controller.dart';
import 'package:kanha_bmc/controller/masters/member_master_controller.dart';
import 'package:kanha_bmc/controller/masters/mpp_master_controller.dart';
import 'package:kanha_bmc/controller/masters/rate_check_controller.dart';
import 'package:kanha_bmc/controller/masters/rate_master_controller.dart';
import 'package:kanha_bmc/controller/masters/route_master_controller.dart';
import 'package:kanha_bmc/pages/dashboard.dart';

class DataSyncingHomepageScreenController extends GetxController {
  RxBool isLoading = true.obs;

  final BmcMasterController bmcMasterController = Get.put(BmcMasterController());
  final MemberMasterController memberMasterController = Get.put(MemberMasterController());
  final MppMasterController mppMasterController = Get.put(MppMasterController());
  final RateCheckMasterController rateCheckMasterController = Get.put(RateCheckMasterController());
  final RateMasterController rateMasterController = Get.put(RateMasterController());
  final RuteMasterController ruteController = Get.put(RuteMasterController());
 

  Future<void> afterSyncing() async {
    await Future.delayed(const Duration(seconds: 15));
    isLoading.value = false; // Stop loading after delay
    Get.off(DashboardScreen());
  }

  @override
  void onInit() {
    super.onInit();

    // Perform data fetch for both controllers
    Future.wait([
        bmcMasterController.fetchData(),
       memberMasterController.fetchData(),
      mppMasterController.fetchData(),
        rateCheckMasterController.fetchData(),
       rateMasterController.fetchData(),
      ruteController.fetchData()
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