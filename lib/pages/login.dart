

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
import 'package:kanha_bmc/common/custom_bottom_navigation_bar.dart';
import 'package:kanha_bmc/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
   final TextEditingController userNameController = TextEditingController();
   final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: OrientationBuilder(
          builder: (context, orientation) {
            bool isPortrait = orientation == Orientation.portrait;

            return SingleChildScrollView(
              child: Container(
                height: Get.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg_image.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,
                    vertical: Get.height * 0.02,
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: isPortrait ? Get.height * 0.1 : Get.height * 0.05),

                          // Logo and App Title
                          Center(
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: isPortrait ? Get.height * 0.1 : Get.height * 0.2,
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Text(
                                  "BMC APP",
                                  style: TextStyle(
                                    fontSize: isPortrait ? Get.width * 0.06 : Get.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * 0.05),

                          // Login Text
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: isPortrait ? Get.width * 0.06 : Get.width * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.03),

                          // ✅ Fixed User ID Field
                          TextFormField(
                            controller: loginController.userNameController,
                            decoration: InputDecoration(
                              labelText: "User ID",
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(Icons.person), labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                 ),
                            )
                          ),
                          SizedBox(height: Get.height * 0.02),

                          // ✅ Fixed Password Field
                          TextFormField(
                            obscureText: !isPasswordVisible,
                            controller: loginController.passwordController,
                            decoration: InputDecoration(
                              labelText: "Password",
                              fillColor: Colors.white, 
                              labelStyle: TextStyle(color: CustomColors.appColor), // Label text color
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor), // Border color when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.appColor, width: 1), // Border color when focused
    ),
                              filled: true,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01),

                          // ✅ Remember Me Checkbox
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  value: loginController.rememberMe.value,
                                  onChanged: (value) {
                                    loginController.toggleRememberMe(value!);
                                  },
                                ),
                              ),
                              const Text('Remember Me'),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.02),

                          // ✅ Fixed Login Button
                          Obx(
                            () => loginController.isLoading.value
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.02,
                                        ),
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        final userName = loginController.userNameController.text;
                                        final password = loginController.passwordController.text;

                                        if (userName.isNotEmpty && password.isNotEmpty) {
                                          loginController.login(userName, password);
                                        } else {
                                          Get.snackbar('Error', 'All fields are required');
                                        }
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Get.width * 0.045,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          SizedBox(height: Get.height * 0.2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}


















// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanha_bmc/common/custom_bottom_navigation_bar.dart';
// import 'package:kanha_bmc/controller/login_controller.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final LoginController loginController = Get.put(LoginController());
//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool isPasswordVisible = false;


//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.lightBlue[50],
//         body: OrientationBuilder(
//           builder: (context, orientation) {
//             bool isPortrait = orientation == Orientation.portrait;

//             return SingleChildScrollView(
//               child: Container(
//                 height: Get.height ,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/bg_image.png"),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: Get.width * 0.05,
//                     vertical: Get.height * 0.02,
//                   ),
//                   child: Center(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SizedBox(height: isPortrait ? Get.height * 0.1 : Get.height * 0.05),
                      
//                           // Logo and App Title
//                           Center(
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/logo.png',
//                                     height: isPortrait ? Get.height * 0.1 : Get.height * 0.2,
//                                   ),
//                                   SizedBox(height: Get.height * 0.02),
//                                   Text(
//                                     "BMC APP",
//                                     style: TextStyle(
//                                       fontSize: isPortrait ? Get.width * 0.06 : Get.width * 0.04,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: Get.height * 0.05),
                      
//                           // Login Text
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Login",
//                               style: TextStyle(
//                                 fontSize: isPortrait ? Get.width * 0.06 : Get.width * 0.045,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: Get.height * 0.03),
//                       Obx(
//   () => TextFormField(
//     controller: userNameController..text = loginController.remUserid.value,
//     decoration: InputDecoration(
//       labelText: "User ID",
//       fillColor: Colors.white,
//       filled: true,
//       prefixIcon: const Icon(Icons.person),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//     ),
//   ),
// ),
//                           // // Username Field
//                           // TextFormField(
//                           //   controller: userNameController..text = loginController.remUserid.value,
//                           //   decoration: InputDecoration(
//                           //     labelText: "User ID",
//                           //     fillColor: Colors.white,
//                           //     filled: true,
//                           //     prefixIcon: const Icon(Icons.person),
//                           //     border: OutlineInputBorder(
//                           //       borderRadius: BorderRadius.circular(8.0),
//                           //     ),
//                           //   ),
//                           // ),
//                           SizedBox(height: Get.height * 0.02),
                      
//                           // Password Field
//                         Obx(
//   () =>   TextFormField(
//                             obscureText: !isPasswordVisible,
//                             controller: passwordController..text =loginController.remPass.value,
//                             decoration: InputDecoration(
//                               labelText: "Password",
//                               fillColor: Colors.white,
//                               filled: true,
//                               prefixIcon: const Icon(Icons.lock),
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   isPasswordVisible ? Icons.visibility_off : Icons.visibility,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     isPasswordVisible = !isPasswordVisible;
//                                   });
//                                 },
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                           ),),
//                           SizedBox(height: Get.height * 0.01),
                      
//                           // // Remember Me Checkbox
//                           // Row(
//                           //   children: [
//                           //     Checkbox(
//                           //       value: true,
//                           //       onChanged: (value) {},
//                           //     ),
//                           //     const Text("Remember me"),
//                           //   ],
//                           // ),


// // Add this in LoginScreen inside the relevant section
// // Remember Me Checkbox
// Row(
//   children: [
//     Obx(
//       () => Checkbox(
//         value: loginController.rememberMe.value,
//         onChanged: (value) {
//           loginController.toggleRememberMe(value!);
//         },
//       ),
//     ),
//     const Text('Remember Me'),
//   ],
// ),




//                           SizedBox(height: Get.height * 0.02),
                      
//                           // Login Button
//                           Obx(
//                             () => loginController.isLoading.value
//                                 ? const CircularProgressIndicator()
//                                 : SizedBox(
//                                     width: double.infinity,
//                                     child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                         padding: EdgeInsets.symmetric(
//                                           vertical: Get.height * 0.02,
//                                         ),
//                                         backgroundColor: Colors.blue,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(8.0),
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         final userName = userNameController.text;
//                                         final password = passwordController.text;
                      
//                                         if (userName.isNotEmpty && password.isNotEmpty) {
//                                           loginController.login(userName, password);
//                                         } else {
//                                           Get.snackbar('Error', 'All fields are required');
//                                         }
//                                       },
//                                       child: Text(
//                                         'Login',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: Get.width * 0.045,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                           ),
//                           SizedBox(height: Get.height * 0.2),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//         bottomNavigationBar:CustomBottomNavigationBar()
        
        
         
//       ),
//     );
//   }
// }
