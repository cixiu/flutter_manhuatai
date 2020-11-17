import 'package:flutter/widgets.dart';

class CountModal extends ChangeNotifier {
  int count;

  CountModal({
    this.count = 0,
  });

  void addCount() {
    count++;
    notifyListeners();
  }

  void plusCount() {
    count--;
    notifyListeners();
  }
}
