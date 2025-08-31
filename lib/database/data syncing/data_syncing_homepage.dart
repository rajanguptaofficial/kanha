// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/common/colors.dart';
// import 'package:kanha_bmc/common/custom_app_bar.dart';
// import 'package:kanha_bmc/common/custom_drawer.dart';
// import 'package:kanha_bmc/database/data%20syncing/data_syncing_homepage_controller.dart';
// import 'package:kanha_bmc/pages/dashboard.dart';



// class DataSyncingHomepageScreen extends StatefulWidget {
//   const DataSyncingHomepageScreen({super.key});

//   @override
//   State<DataSyncingHomepageScreen> createState() => _DataSyncingHomepageScreenState();
// }

// class _DataSyncingHomepageScreenState extends State<DataSyncingHomepageScreen> {
//   final DataSyncingHomepageScreenController controller = Get.put(DataSyncingHomepageScreenController());


//   @override
//   Widget build(BuildContext context) {
//  return 
//  SafeArea(
//       child: 
//       Scaffold(
//         appBar: CustomAppBar(
//           title:"Data Syncing Screen"
//         ),
//          drawer:  
//           controller.isLoading.value == true ?  null :
//           CustomDrawer(),
        
//         body:   Obx(() {
//           // Check if data is loading
//           if (controller.isLoading.value) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: const [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 16),
//                   Text("Data Syncing, please wait..."),
//                 ],
//               ),
//             );
//           } else {
//     return
//        Center(child: Column(   
//         spacing: 22,
//            mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//          children: [
//            Text("Data Syncing, Completed..."),

//              Visibility(
//              visible:  controller.isLoading.value ? false : true,
//                child: ElevatedButton(style: ElevatedButton.styleFrom(
//                        padding: EdgeInsets.symmetric(
//                          horizontal: Get.width * 0.01,
//                          vertical: Get.height * 0.01,
//                        ),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(10),
//                        ),
//                        backgroundColor: CustomColors.appGreenButtomColor,
//                      ),
//                             onPressed: () {
//                             Get.off(() =>  DashboardScreen()); 
//                             },
//                             child: Text('Go', style: TextStyle(fontSize: 17,color: CustomColors.bgColor)),
//                           ),
//              ),
//          ],
//        ));
        
//          }}),
//           bottomNavigationBar: Padding(
//             padding: EdgeInsets.all(Get.width * 0.02),
//             child: const Text(
//               '© KMTEPL | App Version-1.0 | 17 Dec 2024',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 12, color: Colors.black),
//             ),
//           )));
//         }}
      
  


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data_syncing_homepage_controller.dart';


class DataSyncingHomepageScreen extends StatefulWidget {
  const DataSyncingHomepageScreen({super.key});

  @override
  State<DataSyncingHomepageScreen> createState() => _DataSyncingHomepageScreenState();
}

class _DataSyncingHomepageScreenState extends State<DataSyncingHomepageScreen> {
  final DataSyncingHomepageScreenController controller = Get.put(DataSyncingHomepageScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: CustomAppBar(title: "Data Syncing Screen"),
        // // Fixing the drawer logic to always return a Widget or null
        // drawer: Obx(() {
        //   if (controller.isLoading.value) {
        //     return SizedBox(); // Explicitly return null when loading
        //   }
        //   return CustomDrawer(); // Return the CustomDrawer widget
        // }),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CupertinoActivityIndicator(),
                  SizedBox(height: 22),
                  Text("Data Syncing...",style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Data Syncing Completed!",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 16),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: Get.width * 0.1,
                  //       vertical: Get.height * 0.02,
                  //     ),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     backgroundColor: CustomColors.appGreenButtomColor,
                  //   ),
                  //   onPressed: () => Get.off(() => DashboardScreen()),
                  //   child: Text(
                  //     'Go',
                  //     style: TextStyle(fontSize: 17, color: CustomColors.bgColor),
                  //   ),
                  // ),
                ],
              ),
            );
          }
        }),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(Get.width * 0.02),
          child: const Text(
            '© KMTEPL | App Version-1.0 | 23 Aug 2025',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
      ),
    );
  }
}







