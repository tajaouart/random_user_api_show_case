import 'package:flutter/material.dart';

class ViewModel<T> extends ChangeNotifier {
  ViewModel(T state) {
    _state = state;
  }

  late T _state;

  T get state => _state;

  /// Notifies the listeners once and then goes back to the previous state
  void notifyOnce(value) {
    // Save old state
    final oldValue = _state;
    // Update state
    _state = value;
    // Notify listeners once so they get the information/update
    notifyListeners();
    // Go back to the previous state
    _state = oldValue;
  }

  /// Changes the view model state and then notifies
  void changeState(value) {
    // Update state
    _state = value;
    // Notify listeners once so they get the information/update
    notifyListeners();
  }
}
