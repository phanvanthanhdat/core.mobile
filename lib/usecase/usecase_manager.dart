
import 'package:coremobiledemo/pages/home/home_usecase.dart';
import 'package:coremobiledemo/pages/signin/sign_in_usecase.dart';
import 'package:coremobiledemo/usecase/auth_login.dart';
import 'package:coremobiledemo/usecase/auth_logout.dart';
import 'package:flutter/cupertino.dart';

class UseCaseManager {
  static T getUseCase<T>(BuildContext context) {
    switch (T) {
      case HomeUserCase: return HomeUserCase(context) as T;
      case SignInUseCase: return SignInUseCase(context) as T;
      case AuthLogoutUseCase: return AuthLogoutUseCase(context) as T;
      case AuthLoginUseCase: return AuthLoginUseCase(context) as T;
      default:
        return null;
    }
  }
}