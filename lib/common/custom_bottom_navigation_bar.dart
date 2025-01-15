import 'package:flutter/material.dart';
import 'package:kanha_bmc/common/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final Color backgroundColor;
  final String version;
  const CustomBottomNavigationBar({
    super.key,
    this.backgroundColor = CustomColors.primaryColor,
    this.version = "App Version-1.0",
  });

  String _getCurrentDate() {
    final DateTime now = DateTime.now();
    final String formattedDate = "${now.day.toString().padLeft(2, '0')} "
        "${_getMonthName(now.month)} ${now.year}";
    return formattedDate;
  }

  String _getMonthName(int month) {
    const List<String> months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '© KMTEPL | $version | ${_getCurrentDate()}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Colors.black,fontWeight:FontWeight.bold),
        ),
      ),
    );
  }
}
