import 'package:flutter/cupertino.dart';

extension KeyBoardExtension on BuildContext {
  void dismissKeyboard() {
    if (this != null) {
      FocusScopeNode currentFocus = FocusScope.of(this);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.focusedChild.unfocus();
      }
    }
  }
}
