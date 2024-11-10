import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  num _value = 0;

  CounterProvider([this._value = 0]);

  num get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }

  void decrement() {
    _value--;
    notifyListeners();
  }
}
