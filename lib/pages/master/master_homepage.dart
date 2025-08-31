// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/pages/master/bmc_master.dart';
// import 'package:kanha_bmc/pages/master/member_master.dart';
// import 'package:kanha_bmc/pages/master/mpp_master.dart';
// import 'package:kanha_bmc/pages/master/rate_check.dart';
// import 'package:kanha_bmc/pages/master/rate_master.dart';
// import '../../common/custom_app_bar.dart';
// import 'route_master.dart';
//
// class MasterHomepageScreen extends StatefulWidget {
//   const MasterHomepageScreen({super.key});
//
//   @override
//   State<MasterHomepageScreen> createState() => _MasterHomepageScreenState();
// }
//
// class _MasterHomepageScreenState extends State<MasterHomepageScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const CustomAppBar(
//           title: 'Master',
//         ),
//         body: OrientationBuilder(
//           builder: (context, orientation) {
//             final isPortrait = orientation == Orientation.portrait;
//             final double cardHeight = Get.height * 0.12;
//             final double cardWidth = Get.width * (isPortrait ? 0.9 : 0.4);
//             final double imageSize = cardHeight * 0.5;
//
//             return SingleChildScrollView(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//                 child: Wrap(
//                   spacing: 16,
//                   runSpacing: 16,
//                   alignment: WrapAlignment.center,
//                   children: [
//                     _buildCard(
//                       title: 'BMC Master',
//                       imagePath: "assets/icons/bmc_collection.png",
//                       cardHeight: cardHeight,
//                       cardWidth: cardWidth,
//                       imageSize: imageSize,
//                       onTap: () {
//                         Get.to(() => BmcMasterScreen());
//                       },
//                     ),
//                     _buildCard(
//                       title: 'MPP Master',
//                       imagePath: "assets/icons/tank.png",
//                       cardHeight: cardHeight,
//                       cardWidth: cardWidth,
//                       imageSize: imageSize,
//                       onTap: () {
//                         Get.to(() => MppMasterScreen());
//                       },
//                     ),
//                     _buildCard(
//                       title: 'Route Master',
//                       imagePath: "assets/icons/truck.png",
//                       cardHeight: cardHeight,
//                       cardWidth: cardWidth,
//                       imageSize: imageSize,
//                       onTap: () {
//                         Get.to(() => RouteMasterScreen());
//                       },
//                     ),
//                     _buildCard(
//                       title: 'Member Master',
//                       imagePath: "assets/icons/member.png",
//                       cardHeight: cardHeight,
//                       cardWidth: cardWidth,
//                       imageSize: imageSize,
//                       onTap: () {
//                         Get.to(() => MemberMasterScreen());
//                       },
//                     ),
//                     _buildCard(
//                       title: 'Rate Master',
//                       imagePath: "assets/icons/rate_rs.png",
//                       cardHeight: cardHeight,
//                       cardWidth: cardWidth,
//                       imageSize: imageSize,
//                       onTap: () {
//                         Get.to(() => RateMasterScreen());
//                       },
//                     ),
//                     _buildCard(
//                       title: 'Rate Check',
//                       imagePath: "assets/icons/rate_check.png",
//                       cardHeight: cardHeight,
//                       cardWidth: cardWidth,
//                       imageSize: imageSize,
//                       onTap: () {
//                         Get.to(() => RateCheckScreen());
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard({
//     required String title,
//     required String imagePath,
//     required double cardHeight,
//     required double cardWidth,
//     required double imageSize,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Container(
//           height: cardHeight,
//           width: cardWidth,
//           padding: const EdgeInsets.all(12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Image.asset(
//                 imagePath,
//                 height: imageSize,
//                 width: imageSize,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/pages/master/bmc_master.dart';
import 'package:kanha_bmc/pages/master/member_master.dart';
import 'package:kanha_bmc/pages/master/mpp_master.dart';
import 'package:kanha_bmc/pages/master/rate_check.dart';
import 'package:kanha_bmc/pages/master/rate_master.dart';
import '../../common/custom_app_bar.dart';
import 'route_master.dart';

class MasterHomepageScreen extends StatefulWidget {
  const MasterHomepageScreen({super.key});

  @override
  State<MasterHomepageScreen> createState() => _MasterHomepageScreenState();
}

class _MasterHomepageScreenState extends State<MasterHomepageScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Masters',
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // First row
                    Row(
                      children: [
                        Expanded(
                          child: _buildCard(
                            title: 'BMC Master',
                            imagePath: "assets/icons/bmc_collection.png",
                            onTap: () {
                              Get.to(() => BmcMasterScreen());
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildCard(
                            title: 'MPP Master',
                            imagePath: "assets/icons/tank.png",
                            onTap: () {
                              Get.to(() => MppMasterScreen());
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Second row
                    Row(
                      children: [
                        Expanded(
                          child: _buildCard(
                            title: 'Route\nMaster',
                            imagePath: "assets/icons/truck.png",
                            onTap: () {
                              Get.to(() => RouteMasterScreen());
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildCard(
                            title: 'Member\nMaster',
                            imagePath: "assets/icons/member.png",
                            onTap: () {
                              Get.to(() => MemberMasterScreen());
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Third row
                    Row(
                      children: [
                        Expanded(
                          child: _buildCard(
                            title: 'Rate Master',
                            imagePath: "assets/icons/rate_rs.png",
                            onTap: () {
                              Get.to(() => RateMasterScreen());
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildCard(
                            title: 'Rate Check',
                            imagePath: "assets/icons/rate_check.png",
                            onTap: () {
                              Get.to(() => RateCheckScreen());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 85,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 48,
              height: 48,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
