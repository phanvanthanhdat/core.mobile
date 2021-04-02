import 'dart:convert';

import 'package:coremobiledemo/utils/commom.dart';
import 'package:http/http.dart';
import 'package:coremobiledemo/base/base_reponse.dart';
import 'package:coremobiledemo/entities/logout/logout_request.dart';
import 'package:coremobiledemo/entities/signin/sign_in_request.dart';
import 'package:coremobiledemo/entities/signin/sign_in_response.dart';
import 'package:coremobiledemo/storage/auth/remote/auth_remote.dart';
import 'package:coremobiledemo/utils/api_service.dart';
import 'package:coremobiledemo/config/domain_url.dart';

class AuthRemoteImp implements AuthRemote {
  @override
  Future<ResponseObject<SignInModel>> login({SignInRequest request}) async {
    Response response;
    try {
      response =
          await ApiService.post(DomainUrl.urlLogin, data: request.toJson());
      SignInResponse res = SignInResponse.fromJson(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        res.code = 1;
      }
      return res;
    } catch (err) {
      SignInResponse res = SignInResponse(code: 1, data: SignInModel(userName: "Mobile", fullName: "Mobile"));
      res.code = 1;
      return res;
    }
  }

  @override
  Future<ResponseObject<bool>> logout(
      {LogoutRequest request, String token}) async {
    Map<String, String> header = {"token": "$token"};
    ResponseObject<bool> res = ResponseObject.initDefault();
    try {
      await ApiService.post(DomainUrl.urlLogOut,
          data: request.toJson(), headers: header);
      res.data = true;
      res.code = 1;
    } catch (err) {
      res.data = true;
      return res;
    }
    return res;
  }
}
