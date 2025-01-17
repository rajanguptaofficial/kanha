// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_gif/flutter_gif.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:flutter_svg/svg.dart';

// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:ntp/ntp.dart';
// // import 'package:platform_device_id/platform_device_id.dart';
// import 'package:param_dispatch_app/available_vehicle/vehicle_list_model.dart';

// import '../manage_drivers/add_driver/add_driver_view.dart';
// import '../manage_drivers/manage_driver_model.dart';
// import 'custom_colors.dart';
// import 'package:path_provider/path_provider.dart';

// // class Utils {
// //   static void showToast(String text, [Color? bgColor]) {
// //     Fluttertoast.cancel();
// //     Fluttertoast.showToast(
// //         msg: text,
// //         toastLength: Toast.LENGTH_LONG,
// //         gravity: ToastGravity.SNACKBAR,
// //         timeInSecForIosWeb: 1,
// //         backgroundColor: Colors.grey.shade900,
// //         textColor: Colors.white,
// //         fontSize: 16.0);
// //   }

// //   static void print(message) {
// //     if (!kReleaseMode) {
// //       debugPrint(message.toString());
// //     }
// //   }

// //   static void showSnackbar(BuildContext context, String text, Color bgColor) {
// //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //       content: Text(text),
// //       backgroundColor: bgColor,
// //       duration: const Duration(seconds: 3),
// //     ));
// //   }

// //   static bool isValidEmail(String email) {
// //     String p =
// //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

// //     RegExp regExp = RegExp(p);

// //     return regExp.hasMatch(email);
// //   }

// //   static bool isNum(String str) {
// //     if (str == null) {
// //       return false;
// //     }
// //     return double.tryParse(str) != null;
// //   }

// //   static Widget textView(
// //       String text, double fontSize, Color textColor, FontWeight fontWeight) {
// //     return Text(
// //       text,
// //       style: TextStyle(
// //           color: textColor, fontSize: fontSize, fontWeight: fontWeight),
// //     );
// //   }

// //   static Widget textViewAlign(String text, double fontSize, Color textColor,
// //       FontWeight fontWeight, TextAlign textAlign) {
// //     return Text(
// //       text,
// //       textAlign: textAlign,
// //       softWrap: true,
// //       style: TextStyle(
// //           color: textColor, fontSize: fontSize, fontWeight: fontWeight),
// //     );
// //   }
// // }

// class Utils {
//   static FlutterGifController? controller;

//   static void showToast(String text, [Color? bgColor]) {
//     if (!kIsWeb) {
//       Fluttertoast.cancel();
//     }

//     if (Platform.isWindows) {
//       Get.rawSnackbar(
//           snackPosition: SnackPosition.BOTTOM,
//           duration: const Duration(seconds: 2),
//           borderRadius: 0,
//           margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//           messageText: Utils.textView(text, 16, Colors.white, FontWeight.bold),
//           backgroundColor: Colors.grey.shade900);
//     } else {
//       Fluttertoast.showToast(
//           msg: text,
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.SNACKBAR,
//           timeInSecForIosWeb: 1,
//           // backgroundColor: bgColor,
//           backgroundColor: Colors.grey.shade900,
//           textColor: Colors.white,
//           fontSize: 16.0);
//     }
//   }

//   static void print(message) {
//     if (!kReleaseMode) {
//       debugPrint(message.toString());
//     }
//   }

//   // static void log(message) {
//   //   if (!kReleaseMode) {
//   //     log(message.toString());
//   //   }
//   // }

//   static Widget toastWidget(text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25.0),
//         color: Colors.greenAccent,
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.check),
//           const SizedBox(
//             width: 12.0,
//           ),
//           Text(text),
//         ],
//       ),
//     );
//   }

//   static bool isValidEmail(String email) {
//     String p =
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

//     RegExp regExp = RegExp(p);

//     return regExp.hasMatch(email);
//   }

// /* 
//   static void showSnackbar(BuildContext context, String text, Color bgColor) {
//     Scaffold.of(context).showSnackBar(SnackBar(
//       content: Text(text),
//       backgroundColor: bgColor,
//       duration: const Duration(seconds: 3),
//     ));
//   }
//  */
//   static String getMonth(String date) {
//     int year = int.parse(date.split('-')[0]);
//     int month = int.parse(date.split('-')[1]);
//     int day = int.parse(date.split('-')[2]);

//     DateTime a = DateTime(year, month, day);

//     return DateFormat('MMM').format(a);
//   }

// /*   static Future<File> getCompressedImage(File file) async {
//     final dir = await getTemporaryDirectory();

//     final targetPath = dir.absolute.path +
//         "/" +
//         (DateTime.now().millisecondsSinceEpoch).toString() +
//         ".jpg";

//     var result = await FlutterImageCompress.compressAndGetFile(
//         file.absolute.path, targetPath,
//         quality: 90, minWidth: 480, minHeight: 1000
//         // rotate: 180,
//         );

//     // Im.Image image =
//     //     Im.decodeImage(imageFile.readAsBytesSync());
//     // var compressedImage = File(imagePath)
//     //   ..writeAsBytesSync(Im.encodeJpg(image, quality: 25));
//     // _markAttendanceController
//     //     .markUserAttendance(compressedImage);

//     return result;
//   } */

//   static String getDay(String date) {
//     int year = int.parse(date.split('-')[0]);
//     int month = int.parse(date.split('-')[1]);
//     int day = int.parse(date.split('-')[2]);

//     DateTime a = DateTime(year, month, day);

//     return DateFormat('EEE').format(a);
//   }

//   static Future<bool> isNetworkConnected() async {
//     try {
//       await InternetAddress.lookup('google.com');
//       return true;
//     } on SocketException catch (_) {
//       Utils.showToast('No Internet Connection', Colors.red);
//       return false;
//     } catch (e) {
//       Utils.showToast('No Internet Connection', Colors.red);
//       return false;
//     }
//   }

//   static void showLoaderDialog(
//       BuildContext context, TickerProvider tickerProvider) {
//     // GifController controller;
//     controller = FlutterGifController(vsync: tickerProvider);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller?.repeat(
//           min: 0, max: 109, period: const Duration(milliseconds: 2500));
//     });

//     AlertDialog alert = AlertDialog(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         content: GifImage(
//           width: 70,
//           height: 70,
//           controller: controller!,
//           repeat: ImageRepeat.noRepeat,
//           image: const AssetImage("assets/images/loader.gif"),
//         ));
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return WillPopScope(
//             onWillPop: () async {
//               return false;
//             },
//             child: alert);
//       },
//     );
//   }

//   static void showLoaderDialogNew(TickerProvider tickerProvider) {
//     try {
//       controller = FlutterGifController(vsync: tickerProvider);

//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         controller?.repeat(
//             min: 0, max: 109, period: const Duration(milliseconds: 2500));
//       });

//       AlertDialog alert = AlertDialog(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           content: GifImage(
//             width: 70,
//             height: 70,
//             controller: controller!,
//             repeat: ImageRepeat.noRepeat,
//             image: const AssetImage("assets/images/loader.gif"),
//           ));

//       Get.generalDialog(
//         pageBuilder: (context, animation1, animation2) {
//           return const SizedBox();
//         },
//         transitionBuilder: (context, a1, a2, widget) {
//           return StatefulBuilder(
//             builder: (context, setState) => Transform.scale(
//               scale: a1.value,
//               child: Opacity(
//                 opacity: a1.value,
//                 child: Container(
//                     alignment: Alignment.center,
//                     child: WillPopScope(
//                         onWillPop: () async {
//                           return false;
//                         },
//                         child: alert)),
//               ),
//             ),
//           );
//         },
//       );
//     } catch (_) {
//       print(_.toString());
//     }
//   }

//   static void printWrapped(String text) {
//     final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
//     pattern.allMatches(text).forEach((match) => print(match.group(0)));
//   }

//   static void hideLoader([BuildContext? context]) {
//     if (controller != null) {
//       controller?.dispose();
//     }
//     controller = null;
//     Get.back();
//   }

//   // static void hideLoader(BuildContext context) {
//   //   if (controller != null) {
//   //     controller.dispose();
//   //   }

//   //   Navigator.pop(context);

//   //   controller = null;
//   // }

//   static Widget textView(
//       String text, double fontSize, Color textColor, FontWeight fontWeight) {
//     return Text(
//       text,
//       style: TextStyle(
//           color: textColor, fontSize: fontSize, fontWeight: fontWeight),
//     );
//   }

//   static Widget textViewAlign(String text, double fontSize, Color textColor,
//       FontWeight fontWeight, TextAlign textAlign) {
//     return Text(
//       text,
//       textAlign: textAlign,
//       softWrap: true,
//       style: TextStyle(
//           color: textColor, fontSize: fontSize, fontWeight: fontWeight),
//     );
//   }

//   static Future<File?> getCompressedImage(File file) async {
//     final dir = await getTemporaryDirectory();

//     final targetPath =
//         "${dir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";

//     var result = await FlutterImageCompress.compressAndGetFile(
//         file.absolute.path, targetPath,
//         quality: 90, minWidth: 480, minHeight: 1000);
//     return result;
//   }

//  /*  static Future<String> getDeviceId() async {
//     var deviceInfo = DeviceInfoPlugin();
//     if (Platform.isIOS) {
//       var iosDeviceInfo = await deviceInfo.iosInfo;
//       debugPrint(iosDeviceInfo.data['utsname.machine']);
//       return iosDeviceInfo.data['utsname.machine']; // unique ID on iOS
//     } else {
//       var androidDeviceInfo = await deviceInfo.androidInfo;
//       debugPrint(androidDeviceInfo.data['id']);
//       return androidDeviceInfo.data['id']; // unique ID on Android
//     }
//   } */

//  static Future<String> getDeviceId() async {
//     var deviceInfo = DeviceInfoPlugin();
//     if (Platform.isIOS) {
//       var iosDeviceInfo = await deviceInfo.iosInfo;
//       return iosDeviceInfo.identifierForVendor!; // unique ID on iOS
//     } else {
//       var androidDeviceInfo = await deviceInfo.androidInfo;
//       return androidDeviceInfo.id; // unique ID on Android
//     }
//   }

//   static Future<bool> checkCorrectTime([BuildContext? context]) async {
//     DateTime myTime;

//     /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
//     try {
//       myTime = await NTP.now();
//     } on SocketException catch (_) {
//       // Utils.hideLoader();
//       return true;
//     } catch (e) {
//       return true;
//       // Utils.hideLoader();
//     }

//     /// Or get NTP offset (in milliseconds) and add it yourself
//     // final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
//     // _ntpTime = _myTime.add(Duration(milliseconds: offset));

//     int timeDiff = DateTime.now().difference(myTime).inMinutes;

//     if (int.parse(timeDiff.toString().replaceAll('-', '')) > 1) {
//       return false;
//     } else {
//       return true;
//     }
//   }

//   // static showDateTimeCorrectionDialog([BuildContext? context]) {
//   //   showDialog(
//   //       context: Get.context!,
//   //       barrierDismissible: false,
//   //       builder: (context) {
//   //         return WillPopScope(
//   //             onWillPop: () async {
//   //               return false;
//   //             },
//   //             child: Dialog(
//   //                 insetPadding:
//   //                     EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
//   //                 shape: RoundedRectangleBorder(
//   //                   borderRadius: BorderRadius.circular(25),
//   //                 ),
//   //                 elevation: 5,
//   //                 backgroundColor: Colors.white,
//   //                 child: Column(
//   //                   mainAxisSize: MainAxisSize.min,
//   //                   children: [
//   //                     Container(
//   //                       padding: EdgeInsets.only(
//   //                           left: 20, right: 20, top: 20, bottom: 20),
//   //                       child: LayoutBuilder(
//   //                           builder: (context, constraints) => Column(
//   //                                 crossAxisAlignment: CrossAxisAlignment.center,
//   //                                 children: [
//   //                                   Utils.textViewAlign(
//   //                                       'Please correct your phone date and time and reopen your app',
//   //                                       17,
//   //                                       Colors.black,
//   //                                       FontWeight.w600,
//   //                                       TextAlign.center),
//   //                                   SizedBox(
//   //                                     height: 15,
//   //                                   ),
//   //                                   Container(
//   //                                     width: constraints.maxWidth * 0.3,
//   //                                     margin: EdgeInsets.only(
//   //                                         right: 5, top: 10, left: 5),
//   //                                     child: RaisedButton(
//   //                                       elevation: 10,
//   //                                       highlightElevation: 0,
//   //                                       onPressed: () {
//   //                                         SystemChannels.platform.invokeMethod(
//   //                                             'SystemNavigator.pop');
//   //                                       },
//   //                                       shape: RoundedRectangleBorder(
//   //                                           borderRadius:
//   //                                               BorderRadius.circular(80.0)),
//   //                                       padding: const EdgeInsets.all(0.0),
//   //                                       child: Ink(
//   //                                         decoration: const BoxDecoration(
//   //                                           gradient: LinearGradient(
//   //                                             colors: <Color>[
//   //                                               CustomColors.gradientBueStart,
//   //                                               CustomColors.gradientBueEnd
//   //                                             ],
//   //                                           ),
//   //                                           borderRadius: BorderRadius.all(
//   //                                               Radius.circular(80.0)),
//   //                                         ),
//   //                                         child: Container(
//   //                                           constraints: const BoxConstraints(
//   //                                               minHeight:
//   //                                                   45.0), // min sizes for Material buttons
//   //                                           alignment: Alignment.center,
//   //                                           child: const Text(
//   //                                             'OK',
//   //                                             textAlign: TextAlign.center,
//   //                                             style: TextStyle(
//   //                                                 color: Colors.white,
//   //                                                 fontSize: 18,
//   //                                                 fontWeight: FontWeight.w600),
//   //                                           ),
//   //                                         ),
//   //                                       ),
//   //                                     ),
//   //                                   ),
//   //                                 ],
//   //                               )),
//   //                     ),
//   //                   ],
//   //                 )));
//   //       });
//   // }

//   static showEditTimeUpDialog(BuildContext context) {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return WillPopScope(
//               onWillPop: () async {
//                 return false;
//               },
//               child: Dialog(
//                   insetPadding: const EdgeInsets.only(
//                       left: 15, right: 15, top: 30, bottom: 30),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   elevation: 5,
//                   backgroundColor: Colors.white,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.only(
//                             left: 20, right: 20, top: 20, bottom: 20),
//                         child: LayoutBuilder(builder: (context, constraints) {
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Utils.textViewAlign(
//                                   'Order edit time has finished. Please contact admin.',
//                                   17,
//                                   Colors.black,
//                                   FontWeight.w600,
//                                   TextAlign.center),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               Container(
//                                 width: constraints.maxWidth * 0.3,
//                                 margin: const EdgeInsets.only(
//                                     right: 5, top: 10, left: 5),
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     Utils.hideLoader(context);
//                                     Utils.hideLoader(context);
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(80.0)),
//                                     padding: const EdgeInsets.all(0.0),
//                                   ),
//                                   child: Ink(
//                                     decoration: const BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: <Color>[
//                                           CustomColors.primaryColorDark,
//                                           CustomColors.primaryColor
//                                         ],
//                                       ),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(80.0)),
//                                     ),
//                                     child: Container(
//                                       constraints: const BoxConstraints(
//                                           minHeight:
//                                               45.0), // min sizes for Material buttons
//                                       alignment: Alignment.center,
//                                       child: const Text(
//                                         'OK',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           );
//                         }),
//                       ),
//                     ],
//                   )));
//         });
//   }

//   static reassignVehicleDialog(
//       {required List<VehicleLists> vehicleList,
//       required void Function() onAddNewTap,
//       required void Function(VehicleLists) onConfirmTap}) {
//     RxInt selectedIndex = (-1).obs;
//     RxList<VehicleLists> tempVehicleList = vehicleList.obs;
//     return Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         contentPadding: EdgeInsets.zero,
//         insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
//         content: Container(
//           width: Get.width,
//           height: Get.height * 0.6,
//           padding: EdgeInsets.only(
//               top: Get.width * 0.04,
//               bottom: Get.width * 0.0,
//               right: Get.width * 0.02,
//               left: Get.width * 0.02),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: Get.width * 0.03,
//                   ),
//                   Text(
//                     'Select Vehicle to assign\nselected distributor',
//                     style: TextStyle(
//                         color: CustomColors.outlineGrey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: Get.width * 0.04),
//                   ),
//                   const Spacer(),
//                   InkWell(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SvgPicture.asset(
//                         'assets/svg/cancel.svg',
//                         semanticsLabel: 'one',
//                         height: Get.height * 0.02,
//                         color: CustomColors.outlineGrey,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: Get.width * 0.03,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               const Divider(
//                 color: CustomColors.grey,
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               Container(
//                 width: Get.width,
//                 margin: EdgeInsets.only(
//                   left: Get.width * 0.02,
//                   right: Get.width * 0.02,
//                 ),
//                 padding: EdgeInsets.only(
//                     left: Get.width * 0.01,
//                     right: Get.width * 0.01,
//                     top: 0,
//                     bottom: 0),
//                 decoration: BoxDecoration(
//                     color: CustomColors.white,
//                     border: Border.all(color: Colors.grey.shade300, width: 1),
//                     borderRadius: BorderRadius.circular(15)),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: Get.width * 0.01,
//                     ),
//                     SvgPicture.asset(
//                       'assets/svg/Search.svg',
//                       semanticsLabel: 'one',
//                       height: Get.height * 0.025,
//                       color: CustomColors.selectedColor,
//                     ),
//                     SizedBox(
//                       width: Get.width * 0.03,
//                     ),
//                     Flexible(
//                       child: TextField(
//                         cursorColor: CustomColors.black,
//                         textInputAction: TextInputAction.next,
//                         keyboardType: TextInputType.text,
//                         onChanged: (value) {
//                           selectedIndex.value = -1;
//                           tempVehicleList.value = vehicleList
//                               .where((element) =>
//                                   ((element.registrationNumber ?? '')
//                                           .toLowerCase())
//                                       .contains(value.toLowerCase()))
//                               .toList();
//                           tempVehicleList.refresh();
//                         },
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             errorBorder: InputBorder.none,
//                             disabledBorder: InputBorder.none,
//                             hintText: 'Search Vehicle',
//                             hintStyle: TextStyle(color: Colors.grey.shade400),
//                             counterText: ''),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.only(
//                     right: Get.width * 0.03,
//                     left: Get.width * 0.03,
//                   ),
//                   child: Obx(
//                     () => ListView.separated(
//                         itemCount: tempVehicleList.length,
//                         separatorBuilder: ((context, index) {
//                           return SizedBox(
//                             height: Get.height * 0.005,
//                           );
//                         }),
//                         itemBuilder: ((context, index) {
//                           VehicleLists vehicle = tempVehicleList[index];
//                           return InkWell(
//                             onTap: () {
//                               selectedIndex.value = index;
//                             },
//                             child: Obx(
//                               () => vehicleListView(
//                                   selectedIndex.value == index, vehicle),
//                             ),
//                           );
//                         })),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           Column(
//             children: [
//               const Divider(
//                 color: CustomColors.grey,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         right: Get.width * 0.01,
//                         left: Get.width * 0.01,
//                         bottom: Get.height * 0.005,
//                       ),
//                       child: DecoratedBox(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                             backgroundColor: Colors.transparent,
//                             disabledForegroundColor: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                           ),
//                           onPressed: () {
//                             onAddNewTap();
//                           },
//                           child: Row(
//                             children: [
//                               Flexible(
//                                 child: Center(
//                                   child: Text(
//                                     'Add New',
//                                     style: TextStyle(
//                                         fontSize: Get.width * 0.045,
//                                         color: CustomColors.primaryColorDark,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         right: Get.width * 0.01,
//                         left: Get.width * 0.01,
//                         bottom: Get.height * 0.005,
//                       ),
//                       child: DecoratedBox(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                             backgroundColor: Colors.transparent,
//                             disabledForegroundColor: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                           ),
//                           onPressed: () {
//                             if (selectedIndex.value >= 0) {
//                               onConfirmTap(
//                                   tempVehicleList[selectedIndex.value]);
//                             } else {
//                               showToast('Please select any vehicle!');
//                             }
//                           },
//                           child: Row(
//                             children: [
//                               Flexible(
//                                 child: Center(
//                                   child: Text(
//                                     'Confirm',
//                                     style: TextStyle(
//                                         fontSize: Get.width * 0.045,
//                                         color: CustomColors.primaryColorDark,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   static reassignSecondaryVehicleDialog(
//       {required List<VehicleLists> vehicleList,
//       required void Function(VehicleLists) onConfirmTap}) {
//     RxInt selectedIndex = (-1).obs;
//     RxList<VehicleLists> tempVehicleList = vehicleList.obs;
//     return Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         contentPadding: EdgeInsets.zero,
//         insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
//         content: Container(
//           width: Get.width,
//           height: Get.height * 0.6,
//           padding: EdgeInsets.only(
//               top: Get.width * 0.04,
//               bottom: Get.width * 0.0,
//               right: Get.width * 0.02,
//               left: Get.width * 0.02),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: Get.width * 0.03,
//                   ),
//                   Text(
//                     'Select Vehicle to assign\nselected distributor',
//                     style: TextStyle(
//                         color: CustomColors.outlineGrey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: Get.width * 0.04),
//                   ),
//                   const Spacer(),
//                   InkWell(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SvgPicture.asset(
//                         'assets/svg/cancel.svg',
//                         semanticsLabel: 'one',
//                         height: Get.height * 0.02,
//                         color: CustomColors.outlineGrey,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: Get.width * 0.03,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               const Divider(
//                 color: CustomColors.grey,
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               Container(
//                 width: Get.width,
//                 margin: EdgeInsets.only(
//                   left: Get.width * 0.02,
//                   right: Get.width * 0.02,
//                 ),
//                 padding: EdgeInsets.only(
//                     left: Get.width * 0.01,
//                     right: Get.width * 0.01,
//                     top: 0,
//                     bottom: 0),
//                 decoration: BoxDecoration(
//                     color: CustomColors.white,
//                     border: Border.all(color: Colors.grey.shade300, width: 1),
//                     borderRadius: BorderRadius.circular(15)),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: Get.width * 0.01,
//                     ),
//                     SvgPicture.asset(
//                       'assets/svg/Search.svg',
//                       semanticsLabel: 'one',
//                       height: Get.height * 0.025,
//                       color: CustomColors.selectedColor,
//                     ),
//                     SizedBox(
//                       width: Get.width * 0.03,
//                     ),
//                     Flexible(
//                       child: TextField(
//                         cursorColor: CustomColors.black,
//                         textInputAction: TextInputAction.next,
//                         keyboardType: TextInputType.text,
//                         onChanged: (value) {
//                           selectedIndex.value = -1;
//                           tempVehicleList.value = vehicleList
//                               .where((element) =>
//                                   ((element.registrationNumber ?? '')
//                                           .toLowerCase())
//                                       .contains(value.toLowerCase()))
//                               .toList();
//                           tempVehicleList.refresh();
//                         },
//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             errorBorder: InputBorder.none,
//                             disabledBorder: InputBorder.none,
//                             hintText: 'Search Vehicle',
//                             hintStyle: TextStyle(color: Colors.grey.shade400),
//                             counterText: ''),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.only(
//                     right: Get.width * 0.03,
//                     left: Get.width * 0.03,
//                   ),
//                   child: Obx(
//                     () => ListView.separated(
//                         itemCount: tempVehicleList.length,
//                         separatorBuilder: ((context, index) {
//                           return SizedBox(
//                             height: Get.height * 0.005,
//                           );
//                         }),
//                         itemBuilder: ((context, index) {
//                           VehicleLists vehicle = tempVehicleList[index];
//                           return InkWell(
//                             onTap: () {
//                               selectedIndex.value = index;
//                             },
//                             child: Obx(
//                               () => vehicleListView(
//                                   selectedIndex.value == index, vehicle),
//                             ),
//                           );
//                         })),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           Column(
//             children: [
//               const Divider(
//                 color: CustomColors.grey,
//               ),
//               Row(
//                 children: [
//                   /* Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         right: Get.width * 0.01,
//                         left: Get.width * 0.01,
//                         bottom: Get.height * 0.005,
//                       ),
//                       child: DecoratedBox(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                             backgroundColor: Colors.transparent,
//                             disabledForegroundColor: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                           ),
//                           onPressed: () {
//                             onAddNewTap();
//                           },
//                           child: Row(
//                             children: [
//                               Flexible(
//                                 child: Center(
//                                   child: Text(
//                                     'Add New',
//                                     style: TextStyle(
//                                         fontSize: Get.width * 0.045,
//                                         color: CustomColors.primaryColorDark,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ), */
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         right: Get.width * 0.01,
//                         left: Get.width * 0.01,
//                         bottom: Get.height * 0.005,
//                       ),
//                       child: DecoratedBox(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                             backgroundColor: Colors.transparent,
//                             disabledForegroundColor: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                           ),
//                           onPressed: () {
//                             if (selectedIndex.value >= 0) {
//                               onConfirmTap(
//                                   tempVehicleList[selectedIndex.value]);
//                             } else {
//                               showToast('Please select any vehicle!');
//                             }
//                           },
//                           child: Row(
//                             children: [
//                               Flexible(
//                                 child: Center(
//                                   child: Text(
//                                     'Confirm',
//                                     style: TextStyle(
//                                         fontSize: Get.width * 0.045,
//                                         color: CustomColors.primaryColorDark,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   static Widget vehicleListView(bool isSelected, VehicleLists vehicle) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: Get.height * 0.005),
//       child: Row(
//         children: [
//           SvgPicture.asset(
//             'assets/svg/green tick.svg',
//             semanticsLabel: 'one',
//             height: Get.height * 0.02,
//             color: isSelected ? CustomColors.selectedColor : CustomColors.grey,
//           ),
//           SizedBox(
//             width: Get.width * 0.02,
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Utils.textView(vehicle.registrationNumber ?? '--',
//                     Get.width * 0.04, Colors.black87, FontWeight.bold),
//                 Utils.textView(vehicle.driverName ?? '--', Get.width * 0.03,
//                     Colors.black54, FontWeight.bold)
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static reassignDriverDialog(
//       {required String vehicleNo,
//       required List<DriverLists> driverList,
//       required void Function() onAddNewTap,
//       required void Function(DriverLists) onConfirmTap}) {
//     RxInt selectedIndexDriver = (-1).obs;
//     RxList<DriverLists> tempDriverList = driverList.obs;
//     return Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         contentPadding: EdgeInsets.only(
//             top: 0, left: Get.width * 0.0, right: Get.width * 0.0, bottom: 0),
//         content: Container(
//           width: Get.width,
//           height: Get.height * 0.6,
//           padding: EdgeInsets.only(
//               top: Get.width * 0.04,
//               bottom: Get.width * 0.0,
//               right: Get.width * 0.02,
//               left: Get.width * 0.02),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: Get.width * 0.03,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Select driver to assign',
//                         style: TextStyle(
//                             color: CustomColors.outlineGrey,
//                             fontWeight: FontWeight.bold,
//                             fontSize: Get.width * 0.04),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             'Vehicle No.',
//                             style: TextStyle(
//                                 color: CustomColors.outlineGrey,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: Get.width * 0.04),
//                           ),
//                           Utils.textView(vehicleNo, Get.width * 0.04,
//                               CustomColors.selectedColor, FontWeight.bold),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   InkWell(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SvgPicture.asset(
//                         'assets/svg/cancel.svg',
//                         semanticsLabel: 'one',
//                         height: Get.height * 0.02,
//                         color: CustomColors.outlineGrey,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: Get.width * 0.03,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               const Divider(
//                 color: CustomColors.grey,
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               Container(
//                 width: Get.width,
//                 margin: EdgeInsets.only(
//                   left: Get.width * 0.02,
//                   right: Get.width * 0.02,
//                 ),
//                 padding: EdgeInsets.only(
//                     left: Get.width * 0.01,
//                     right: Get.width * 0.01,
//                     top: 0,
//                     bottom: 0),
//                 decoration: BoxDecoration(
//                     color: CustomColors.white,
//                     border: Border.all(color: Colors.grey.shade300, width: 1),
//                     borderRadius: BorderRadius.circular(15)),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: Get.width * 0.01,
//                     ),
//                     SvgPicture.asset(
//                       'assets/svg/Search.svg',
//                       semanticsLabel: 'one',
//                       height: Get.height * 0.025,
//                       color: CustomColors.selectedColor,
//                     ),
//                     SizedBox(
//                       width: Get.width * 0.03,
//                     ),
//                     Flexible(
//                       child: TextField(
//                         cursorColor: CustomColors.black,
//                         onChanged: (value) {
//                           selectedIndexDriver.value = -1;
//                           tempDriverList.value = driverList
//                               .where((element) =>
//                                   ((element.firstName ?? '').toLowerCase())
//                                       .contains(value.toLowerCase()))
//                               .toList();
//                           tempDriverList.refresh();
//                         },
//                         // controller: ,
//                         textInputAction: TextInputAction.next,
//                         keyboardType: TextInputType.text,

//                         decoration: InputDecoration(
//                             border: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             errorBorder: InputBorder.none,
//                             disabledBorder: InputBorder.none,
//                             hintText: 'Search Driver',
//                             hintStyle: TextStyle(color: Colors.grey.shade400),
//                             counterText: ''),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.01,
//               ),
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.only(
//                     right: Get.width * 0.03,
//                     left: Get.width * 0.03,
//                   ),
//                   child: Obx(
//                     () => ListView.separated(
//                         itemCount: tempDriverList.length,
//                         separatorBuilder: ((context, index) {
//                           return SizedBox(
//                             height: Get.height * 0.01,
//                           );
//                         }),
//                         itemBuilder: ((context, index) {
//                           DriverLists driver = tempDriverList[index];
//                           return InkWell(
//                             onTap: () {
//                               selectedIndexDriver.value = index;
//                             },
//                             child: Obx((() => driverListView(
//                                 selectedIndexDriver.value == index, driver))),
//                           );
//                         })),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           Column(
//             children: [
//               const Divider(
//                 color: CustomColors.grey,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         right: Get.width * 0.01,
//                         left: Get.width * 0.01,
//                         bottom: Get.height * 0.005,
//                       ),
//                       child: DecoratedBox(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                             backgroundColor: Colors.transparent,
//                             disabledForegroundColor: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                           ),
//                           onPressed: () {
//                             Get.to(() => const AddDriver());
//                           },
//                           child: Row(
//                             children: [
//                               Flexible(
//                                 child: Center(
//                                   child: Text(
//                                     'Add New',
//                                     style: TextStyle(
//                                         fontSize: Get.width * 0.045,
//                                         color: CustomColors.primaryColorDark,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         right: Get.width * 0.01,
//                         left: Get.width * 0.01,
//                         bottom: Get.height * 0.005,
//                       ),
//                       child: DecoratedBox(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                             backgroundColor: Colors.transparent,
//                             disabledForegroundColor: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                           ),
//                           onPressed: () {
//                             if (selectedIndexDriver.value >= 0) {
//                               onConfirmTap(
//                                   tempDriverList[selectedIndexDriver.value]);
//                             } else {
//                               showToast('Please select any driver!');
//                             }
//                           },
//                           child: Row(
//                             children: [
//                               Flexible(
//                                 child: Center(
//                                   child: Text(
//                                     'Confirm',
//                                     style: TextStyle(
//                                         fontSize: Get.width * 0.045,
//                                         color: CustomColors.primaryColorDark,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   static Widget driverListView(bool isSelected, DriverLists driver) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: Get.height * 0.005),
//       child: Row(
//         children: [
//           SvgPicture.asset(
//             'assets/svg/green tick.svg',
//             semanticsLabel: 'one',
//             height: Get.height * 0.02,
//             color: isSelected ? CustomColors.selectedColor : CustomColors.grey,
//           ),
//           SizedBox(
//             width: Get.width * 0.02,
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Utils.textView(driver.firstName ?? '--', Get.width * 0.04,
//                         Colors.black87, FontWeight.bold),
//                     Utils.textView(driver.lastName ?? '', Get.width * 0.04,
//                         Colors.black87, FontWeight.bold),
//                   ],
//                 ),
//                 // Utils.textView(vehicle.driverName ?? '--', Get.width * 0.03,
//                 //     Colors.black54, FontWeight.bold)
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
