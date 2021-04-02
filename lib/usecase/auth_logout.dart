import 'package:coremobiledemo/base/base_reponse.dart';
import 'package:coremobiledemo/base/usecase.dart';
import 'package:coremobiledemo/entities/logout/logout_request.dart';
import 'package:coremobiledemo/providers/auth_provider.dart';
import 'package:coremobiledemo/repositories/auth/auth_repo.dart';
import 'package:coremobiledemo/repositories/repo_manager.dart';
import 'package:coremobiledemo/extension/buildcontext_extension.dart';
import 'package:flutter/material.dart';

class AuthLogoutUseCase extends BaseUseCase { //user sẽ kế thừa từ base use case, use có 1 tác vụ riêng để cho các use case dùng lại phần xử lí logic để tránh lặp lại
  final AuthRepo authRepo = RepoManager().get<AuthRepo>(); // get repo để sử dụng phần data thao tác remote hoặc local, phần này có thể khởi tạo lúc sử dụng
  AuthProvider _authModelProvider;

  AuthLogoutUseCase(BuildContext context) : super(context) {
    _authModelProvider = context.getProvider<AuthProvider>();
  }

  Future<String> logout({bool forceLogout = false}) async {
    ResponseObject<bool> res = ResponseObject.initDefault();

    if(_authModelProvider.data != null){
      LogoutRequest request = LogoutRequest();
      ResponseObject<bool> response = await authRepo.logout(request: request, token: _authModelProvider.data.token ?? "");
      _authModelProvider.data = null;
      res = response;
    }
   return res.isSuccess() ? "" : res.msg;
  }

}