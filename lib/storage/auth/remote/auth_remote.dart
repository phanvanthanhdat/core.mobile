import 'package:coremobiledemo/base/base_reponse.dart';
import 'package:coremobiledemo/entities/signin/sign_in_request.dart';
import 'package:coremobiledemo/entities/signin/sign_in_response.dart';
import 'package:coremobiledemo/entities/logout/logout_request.dart';

abstract class AuthRemote {
  Future<ResponseObject<SignInModel>> login({SignInRequest request});
  Future<ResponseObject<bool>> logout({LogoutRequest request, String token });
}