import 'package:flutter/material.dart';
import 'package:gocaff/models/navigation_item.dart';

class NavigationProvider extends ChangeNotifier {
  NavigationItem _navigationItem = NavigationItem.home;

  NavigationItem get navigationItem => _navigationItem;

  void setNavigationItem(NavigationItem item) {
    _navigationItem = item;
    notifyListeners();
  }
}
