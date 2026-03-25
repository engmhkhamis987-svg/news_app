import 'package:flutter/material.dart';

class OnboardingController extends ChangeNotifier {
  int currentIndex = 0;
  bool isLastPage = false;
  final PageController pageController = PageController();

  void onPageChange(int index) {
    currentIndex = index;
    if (index == 2) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }
    notifyListeners();
  }
}
