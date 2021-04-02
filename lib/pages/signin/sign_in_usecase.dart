import 'package:coremobiledemo/base/base_reponse.dart';
import 'package:coremobiledemo/base/usecase.dart';
import 'package:coremobiledemo/config/strings_resource.dart';
import 'package:coremobiledemo/entities/signin/sign_in_response.dart';
import 'package:coremobiledemo/pages/signin/sign_in_interface.dart';
import 'package:coremobiledemo/usecase/auth_login.dart';
import 'package:coremobiledemo/usecase/auth_logout.dart';
import 'package:coremobiledemo/usecase/usecase_manager.dart';
import 'package:flutter/material.dart';
// mỗi Presenter có 1 Use case trong use case presenter có thể gọi nhiều use case nhỏ và chứa phần xử lí chính cho page thông qua presenter
class SignInUseCase extends BaseUseCase {
  String _userName;
  String _pass;
  SignInUseCase(BuildContext context) : super(context);

  void onChangePass(String password) {
    _pass = password;
  }

  void onChangeUserName(String user) {
    _userName = user;
  }

  bool validateData(SignInUseCaseValidateOutput output, bool isLogin) {
    var passError =
        isStringNullOrEmpty(_pass) ? getTextLz("sign_in_password_blank") : "";
    var userNameError = isStringNullOrEmpty(_userName)
        ? getTextLz("sign_in_username_blank")
        : "";
    bool isPass =
        isStringNullOrEmpty(passError) && isStringNullOrEmpty(userNameError);
    if (isLogin || isStringNullOrEmpty(passError)) {
      output.passwordWithError(passError, isLogin);
    }
    if (isLogin || (isStringNullOrEmpty(userNameError))) {
      output.userNameWithError(userNameError, isLogin);
    }
    return isPass;
  }

  Future<String> submit() async {
    //Khởi tạo use case con để sử dụng thông qua use case manager
    var login = UseCaseManager.getUseCase<AuthLoginUseCase>(context);
    ResponseObject<SignInModel> res =
        await login.login(userName: _userName, pass: _pass);
    return res.isSuccess() ? "" : res.msg;
  }

  Future<String> logout({bool forceLogout = false}) async {
    var logout = UseCaseManager.getUseCase<AuthLogoutUseCase>(context);
    return await logout.logout();
  }
}
