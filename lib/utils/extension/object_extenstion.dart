extension UtilsObjectExtension on Object {
  bool get isNull => this == null;

  bool get isNullOrEmpty =>
      isNull ||
          _isStringObjectEmpty ||
          _isIterableObjectEmpty ||
          _isMapObjectEmpty;

  bool get isNullEmptyOrFalse =>
      isNull ||
          _isStringObjectEmpty ||
          _isIterableObjectEmpty ||
          _isMapObjectEmpty ||
          _isNumObjectZero;

  bool get _isStringObjectEmpty =>
      (this is String) ? (this as String).isEmpty : false;

  bool get _isIterableObjectEmpty =>
      (this is Iterable) ? (this as Iterable).isEmpty : false;

  bool get _isMapObjectEmpty => (this is Map) ? (this as Map).isEmpty : false;

  bool get _isNumObjectZero => (this is num) ? (this as num) == 0 : false;
}
