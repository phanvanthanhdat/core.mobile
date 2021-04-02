import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const Map<String, String> _headerDefault = {"Content-Type": "application/json"};

class ApiServiceBase {
  static int timeout = 15;
  static int noTimeout = 90;

  static Future<http.Response> getApi(String domain,
      {Map<String, String> headers = _headerDefault,
      bool isTimeout = true}) async {
    final headersAPI = {
      ..._headerDefault,
      ...headers,
    };
    print('header ${json.encode(headersAPI)}');
    print('url $domain');
    return await http.get('$domain', headers: headersAPI).timeout(Duration(
        seconds:
            isTimeout ? ApiServiceBase.timeout : ApiServiceBase.noTimeout));
  }

  static Future<http.Response> postApi(String domain,
      {Map<String, String> headers = _headerDefault,
      dynamic data,
      Encoding encoding,
      bool isTimeout = true}) async {
    final headersAPI = {
      ..._headerDefault,
      ...headers,
    };
    return await http
        .post('$domain', headers: headersAPI, body: json.encode(data))
        .timeout(Duration(
            seconds:
                isTimeout ? ApiServiceBase.timeout : ApiServiceBase.noTimeout));
  }

  static Future<http.Response> uploadFileApi(String domain, List<dynamic> files,
      Map<String, String> data, Function(int, int) listener) async {
    List<String> listString = [];
    String fileName = "";
    int i = 0;
    List<http.MultipartFile> multipartFiles = [];
    for (final dynamic file in files) {
      print(i.toString());
      http.MultipartFile multipartFile;
      String name = 'randomString' + i.toString();
      if (file is File) {
        listString = file.path.split('/');
        fileName = listString[listString.length - 1];
        name = fileName.split('.').length > 0
            ? fileName.split('.')[0]
            : 'randomstring' + i.toString();
        multipartFile = await http.MultipartFile.fromPath(
            'data', file.path.trim(),
            filename: name.trim());
      } else {
        multipartFile = http.MultipartFile.fromBytes(
          'data',
          file,
          filename: 'randomstring' + i.toString(),
        );
      }
      multipartFiles.add(multipartFile);
      i++;
    }

    String endpoint = domain + i.toString();
    Uri uri = Uri.parse(endpoint);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.headers.addAll(Map.from({
      'Content-Type':
          'multipart/form-data; boundary=----WebKitFormBoundaryuL67FWkv1CA',
    }));
    request.fields.addAll(data);
    request.files.addAll(multipartFiles);
    StreamSubscription<http.StreamedResponse> subcriptionResponse;
    StreamSubscription<List<int>> streamChunk;
    try {
      Future<http.StreamedResponse> futureResponse = request.send();
      http.StreamedResponse response = await futureResponse;
      http.Response res = await http.Response.fromStream(response);
      subcriptionResponse?.cancel();
      streamChunk?.cancel();
      return res;
    } catch (e) {
      throw (e);
    } finally {
      subcriptionResponse?.cancel();
      streamChunk?.cancel();
    }
  }
}
