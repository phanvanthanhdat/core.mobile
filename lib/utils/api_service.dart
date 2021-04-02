import 'dart:async';
import 'dart:convert';
import 'package:coremobiledemo/base/api_service_base.dart';
import 'package:coremobiledemo/config/app_config.dart';
import 'package:coremobiledemo/config/domain_url.dart';
import 'package:coremobiledemo/utils/commom.dart';
import 'package:http/http.dart' as http;

const Map<String, String> _headerDefault = {"Content-Type": "application/json"};

class ApiService {
  static String _domain = AppConfig.domain;
  static Future<http.Response> get(String subURL,
      {Map<String, String> headers = _headerDefault,
      bool isTimeout = true}) async {
    final headersAPI = {
      ..._headerDefault,
      ...headers,
    };
    printDebug('header ${json.encode(headersAPI)}');
    printDebug('url $_domain$subURL');
    return await ApiServiceBase
        .getApi('$_domain$subURL', headers: headersAPI, isTimeout:isTimeout);
  }

  static Future<http.Response> post(String subURL,
      {Map<String, String> headers = _headerDefault,
      dynamic data,
      Encoding encoding,
      bool isTimeout = true}) async {
    return await ApiServiceBase
        .postApi('$_domain$subURL', headers: headers, data: data, isTimeout : isTimeout);
  }

  static Future<http.Response> uploadFile(String subURL, List<dynamic> files,
      Map<String, String> data, Function(int, int) listener) async {
    String domain = DomainUrl.getUrl(_domain, subURL);
    return await ApiServiceBase.uploadFileApi(domain, files, data, listener);
  }
}
