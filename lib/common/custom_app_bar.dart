import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanha_bmc/common/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonVisible;

  const CustomAppBar({super.key, 
    required this.title,
    this.isBackButtonVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
            backgroundColor: CustomColors.appColor,
            title:  Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18,  fontWeight: FontWeight.w600,),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.wifi),
                onPressed: () {               
                },
              ),
              Image.asset(
                "assets/images/app_bar_logo.png",
                height: Get.height * 0.08,
                width: Get.width * 0.1,
              )
            ],
          );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}





class ProcCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonVisible;

  const ProcCustomAppBar({super.key, 
    required this.title,
    this.isBackButtonVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
            backgroundColor: CustomColors.appColor,
            title:  Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18,  fontWeight: FontWeight.w600,),
            ),
            actions: [
             Image.asset(
                "assets/icons/a.png",
                height: Get.height * 0.08,
                width: Get.width * 0.1,
              ),
              Image.asset(
                "assets/icons/w.png",
                height: Get.height * 0.08,
                width: Get.width * 0.1,
              )
            ],
          );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
