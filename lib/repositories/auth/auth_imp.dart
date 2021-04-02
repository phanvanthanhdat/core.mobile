import 'package:coremobiledemo/base/base_reponse.dart';
import 'package:coremobiledemo/entities/logout/logout_request.dart';
import 'package:coremobiledemo/entities/signin/sign_in_request.dart';
import 'package:coremobiledemo/entities/signin/sign_in_response.dart';
import 'package:coremobiledemo/storage/auth/local/auth_local.dart';
import 'package:coremobiledemo/storage/auth/remote/auth_remote.dart';
import 'package:coremobiledemo/storage/storage_manager.dart';

import 'auth_repo.dart';

class AuthImp implements AuthRepo {
  final AuthLocal authLocal = StorageManager.getLocalStorage<AuthLocal>();
  final AuthRemote authRemote = StorageManager.getRemoteStorage<AuthRemote>();

  @override
  Future<ResponseObject<SignInModel>> login({SignInRequest request}) async {
    ResponseObject<SignInModel> signInResponse =
        await authRemote.login(request: request);
    return signInResponse;
  }

  @override
  Future<ResponseObject<bool>> logout(
      {LogoutRequest request, String token}) async {
    ResponseObject<bool> logoutResponse =
        await authRemote.logout(request: request, token: token);
    return logoutResponse;
  }
}
