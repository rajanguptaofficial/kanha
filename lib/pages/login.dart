import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';
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
        body: SingleChildScrollView(
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo and App Title
                    SizedBox(height: Get.height * 0.1),
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: Get.height * 0.1,
                          ), // Replace with your logo
                          SizedBox(height: Get.height * 0.02),
                          Text(
                            "BMC APP",
                            style: TextStyle(
                              fontSize: Get.width * 0.06,
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
                          fontSize: Get.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                
                    // Username Field
                    TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        labelText: "User ID",
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                
                    // Password Field
                    TextFormField(
                      obscureText: !isPasswordVisible,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
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
                
                    // Remember Me Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: true, // Default checked (state management can be added if required)
                          onChanged: (value) {},
                        ),
                        const Text("Remember me"),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),
                
                    // Login Button
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
                                  final userName = userNameController.text;
                                  final password = passwordController.text;
                
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
                    SizedBox(height: Get.height * 0.05),
                
                    // Footer
                  
                  ],
                ),
              ),
            ),
          ),
        ),
         bottomNavigationBar: Container(color:CustomColors.primaryColor ,
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(
               '© KMTEPL | App Version-1.0 | 17 Dec 2024',
               textAlign: TextAlign.center,
               style: TextStyle(fontSize: 12, color: Colors.black),
             ),
           ),
         ),
      ),
    );
  }
}

