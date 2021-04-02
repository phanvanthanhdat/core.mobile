import 'package:coremobiledemo/base/base_reponse.dart';
import 'package:coremobiledemo/base/usecase.dart';
import 'package:coremobiledemo/entities/signin/sign_in_request.dart';
import 'package:coremobiledemo/entities/signin/sign_in_response.dart';
import 'package:coremobiledemo/providers/auth_provider.dart';
import 'package:coremobiledemo/repositories/auth/auth_repo.dart';
import 'package:coremobiledemo/repositories/repo_manager.dart';
import 'package:coremobiledemo/extension/buildcontext_extension.dart';
import 'package:flutter/material.dart';

class AuthLoginUseCase extends BaseUseCase {
  final AuthRepo authRepo = RepoManager().get<AuthRepo>();
  AuthProvider _authModelProvider;

  AuthLoginUseCase(BuildContext context) : super(context) {
    _authModelProvider = context.getProvider<AuthProvider>();
  }

  Future<ResponseObject<SignInModel>> login({String userName, String pass}) async {
    final SignInRequest request =
    SignInRequest(userName: userName, password: pass, deviceId: "");
    final ResponseObject<SignInModel> response =
    await authRepo.login(request: request);
    _authModelProvider.data = response.data;
    return response;
  }

}