import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberShiftReportController extends GetxController {
  final List<Map<String, String>> _data = List.generate(
    125,
    (index) => {
      'Sr. No.': '${index + 1}',
      'Member Code': 'KM02',
      'Collection Date/Shift': '12/12/2024/M',
    },
  );

  final int itemsPerPage = 10; // Number of items per page
  int currentPage = 1; // Current page number
  final int maxVisiblePages = 6; // Maximum visible page numbers
  final pageController = TextEditingController();

  List<Map<String, String>> get currentPageData {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return _data.sublist(
      startIndex,
      endIndex > _data.length ? _data.length : endIndex,
    );
  }

  int get totalPages => (_data.length / itemsPerPage).ceil();

  List<int> get visiblePageNumbers {
    int startPage =
        ((currentPage - 1) ~/ maxVisiblePages) * maxVisiblePages + 1;
    int endPage = startPage + maxVisiblePages - 1;
    endPage = endPage > totalPages ? totalPages : endPage;

    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      update();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      update();
    }
  }

  void jumpToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      currentPage = page;
      update();
    }
  }
}
