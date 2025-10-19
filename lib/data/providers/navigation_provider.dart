import 'package:flutter/foundation.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;
  String? _nfcTagId;

  int get selectedIndex => _selectedIndex;
  String? get nfcTagId => _nfcTagId;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  set nfcTagId(String? id) {
    _nfcTagId = id;
    notifyListeners();
  }
}
