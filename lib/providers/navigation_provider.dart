import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavigationViewModel extends ChangeNotifier {
  int _currentIndex = 1;
  PersistentTabController persistentNavBarController =
      PersistentTabController(initialIndex: 1);
  ScrollController scrollController = ScrollController();

  int get currentIndex => _currentIndex;

  bool _isScroll = false;

  bool get isScroll => _isScroll;

  set isScroll(bool value) {
    _isScroll = value;
    notifyListeners();
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
