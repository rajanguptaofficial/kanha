import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username; // Variable to hold the username

  @override
  void initState() {
    super.initState();
    getProfileData(); // Fetch profile data during initialization
  }

  Future<void> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username'); // Fetch username
    setState(() {
      username = savedUsername ?? "No username found"; // Update state
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final height = Get.height;
    final width = Get.width;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(radius: isPortrait ? height * 0.1 : width * 0.1,
                backgroundColor: CustomColors.appColor,
                child: CircleAvatar(
                  radius: isPortrait ? height * 0.099 : width * 0.099,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/images/logo.png', // Add your logo asset here
                    height: isPortrait ? height * 0.1 : width * 0.1,
                  ),
                ),
              ),
              SizedBox(height: Get.height * .01),
              Text(
                username ?? "Loading...", // Display username or loading text
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Get.height * .02),
              InfoCard(
                title: 'Company Name',
                value: 'KMTEPL',
                height: height,
                width: width,
              ),
              InfoCard(
                title: 'Plant Name',
                value: 'KMTEPL12',
                height: height,
                width: width,
              ),
              InfoCard(
                title: 'BMC Name',
                value: 'KM02',
                height: height,
                width: width,
              ),
              SizedBox(height: Get.height * 1),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final double height;
  final double width;

  const InfoCard({
    required this.title,
    required this.value,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.05,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.015,
          horizontal: width * 0.05,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
