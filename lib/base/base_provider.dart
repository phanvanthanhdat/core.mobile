

import 'dart:async';

import 'package:coremobiledemo/base/subject.dart';

abstract class BaseProvider<T> {
  BehaviorSubject<T> _dataObserver = BehaviorSubject<T>();

  StreamSubscription<T> listener({Function(T) onDataChange, Function() onDone, Function onError, bool cancelOnError = false}) {
    return _dataObserver.listen(onDataChange, onDone: onDone, onError: onError, cancelOnError: cancelOnError);
  }

  // ignore: unnecessary_getters_setters
  T get data => _dataObserver.value;

  // ignore: unnecessary_getters_setters
  set data(T value) {
    _dataObserver.value = value;
  }

  BehaviorSubject<T> get dataObserver => _dataObserver;

  void dispose() {
    _dataObserver.close();
  }
}