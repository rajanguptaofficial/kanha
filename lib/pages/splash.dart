import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/shared_preferences.dart';
import 'package:kanha_bmc/database/data%20syncing/data_syncing_homepage.dart';
import 'package:kanha_bmc/pages/login.dart';
import 'package:kanha_bmc/pages/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _attemptAutoLogin();
  }

  Future<void> _attemptAutoLogin() async {
    // Check login status
    bool isLoggedIn = await SharedPrefHelper.hasLoginData();
   // bool storedRememberMe = await SecureStorageService.getRememberMe();
    Future.delayed(const Duration(seconds: 5), () {
      if (isLoggedIn) {
        Get.off(() =>  DataSyncingHomepageScreen()); // Navigate to Dashboard
      } else {
        Get.off(() => LoginScreen()); // Navigate to Login Screen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            bool isLandscape = orientation == Orientation.landscape;
            return Stack(
              children: <Widget>[
                SizedBox(
                  width: Get.width, // Adapt to screen width
                  height: Get.height, // Adapt to screen height
                  child: Image.asset(
                    'assets/images/bg_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: isLandscape ? Get.height * 0.4 : Get.height * 0.2,
                        width: isLandscape ? Get.width * 0.5 : null,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
