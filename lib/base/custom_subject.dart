import 'dart:async';
import 'package:coremobiledemo/config/enum/subject_type.dart';
import 'package:rxdart/rxdart.dart' as Rx;

class CustomSubject<T> {
  CustomSubject({SubjectType sub}) {
    this._subject = this._getSubject(type: sub);
  }

  Rx.Subject<T> _subject;

  set value(T val) {
    this._subject.sink.add(val);
  }

  void close() {
    this._subject.close();
  }

  addError(Object error) {
    if (!this._subject.isClosed) {
      this._subject.sink.addError(error);
    }
  }

  Stream<T> get stream => this._subject.stream;

  StreamSubscription listen(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError}) {
    return _subject.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  Rx.Subject<T> _getSubject({SubjectType type}) {
    switch (type) {
      case SubjectType.ReplaySubject:
        return Rx.ReplaySubject<T>();
        break;
      case SubjectType.PublishSubject:
        return Rx.PublishSubject<T>();
        break;
      case SubjectType.BehaviorSubject:
        return Rx.BehaviorSubject<T>();
        break;
      default:
        return Rx.BehaviorSubject<T>();
    }
  }
}
