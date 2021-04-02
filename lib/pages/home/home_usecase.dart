
import 'package:coremobiledemo/base/usecase.dart';
import 'package:coremobiledemo/entities/signin/sign_in_response.dart';
import 'package:coremobiledemo/providers/auth_provider.dart';
import 'package:coremobiledemo/usecase/auth_logout.dart';
import 'package:coremobiledemo/usecase/usecase_manager.dart';
import 'package:flutter/material.dart';
import 'package:coremobiledemo/extension/buildcontext_extension.dart';

class HomeUserCase extends BaseUseCase {
  AuthProvider _authProvider;
  HomeUserCase(BuildContext context) : super(context){
    _authProvider = context.getProvider<AuthProvider>();
  }

  SignInModel userLogin(){
    return _authProvider.data;
  }
  Future<String> logout({bool forceLogout = false}) async {
    var logout = UseCaseManager.getUseCase<AuthLogoutUseCase>(context);
    return await logout.logout();
  }
}
