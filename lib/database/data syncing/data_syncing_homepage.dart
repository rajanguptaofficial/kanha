import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/custom_app_bar.dart';
import 'package:kanha_bmc/common/custom_drawer.dart';
import 'package:kanha_bmc/database/data%20syncing/data_syncing_homepage_controller.dart';



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
        appBar: CustomAppBar(
          title:"Data Syncing Screen"
        ),
         drawer:  CustomDrawer(),
        body:   Obx(() {
          // Check if data is loading
          if (controller.isLoading.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Data Syncing, please wait..."),
                ],
              ),
            );
          } else {
    return
        
       Center(child: Text("Data Syncing, Completed..."));
        
         }}),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(Get.width * 0.02),
            child: const Text(
              '© KMTEPL | App Version-1.0 | 17 Dec 2024',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          )));
        }}
      
  
