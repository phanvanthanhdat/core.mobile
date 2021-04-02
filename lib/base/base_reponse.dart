import 'package:flutter/cupertino.dart';
import 'package:coremobiledemo/config/strings_resource.dart';

class _BaseResponse {
  int code;
  String _msg;
  String msgToken;

  _BaseResponse(this.code, String msg, this.msgToken) {
    if (msg == null || msg == "") {
      this._msg = StringResource.getTextResource("try_again_issue");
    }
  }
  String get msg {
    return _msg ?? StringResource.getTextResource("try_again_issue");
  }

  // ignore: unnecessary_getters_setters
  set msg(String value) {
    _msg = value;
  }

  bool isSuccess() => code == 1;

  bool isExpired() => code == 2;

  bool isNotPermission() => code == 401;
}

class ResponseObject<T> extends _BaseResponse {
  T data;
  ResponseObject({
    @required int code,
    String msg,
    String msgToken,
    T data,
  }) : super(code, msg, msgToken) {
    this.data = data;
  }
  factory ResponseObject.initDefault() {
    int code = 0;
    return ResponseObject(code: code);
  }
}

class ResponseListNew<T> extends _BaseResponse {
  List<T> _datas;
  int total = 0;
  ResponseListNew(
      {@required int code,
      String msg,
      String msgToken,
      List<T> data,
      this.total})
      : super(code, msg, msgToken) {
    this._datas = data;
  }

  List<T> get datas {
    return this._datas ?? [];
  }

  // ignore: unnecessary_getters_setters
  set datas(List<T> datas) {
    this._datas = datas;
  }

  factory ResponseListNew.initDefault() {
    int code = 0;
    return ResponseListNew(code: code);
  }
}
