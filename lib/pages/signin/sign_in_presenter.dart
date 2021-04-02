import 'package:coremobiledemo/base/presenter.dart';
import 'package:coremobiledemo/pages/signin/sign_in_interface.dart';
import 'package:coremobiledemo/pages/signin/sign_in_usecase.dart';
import 'package:coremobiledemo/usecase/usecase_manager.dart';
import 'package:flutter/material.dart';
import 'package:coremobiledemo/base/subject.dart';
import 'package:coremobiledemo/config/strings_resource.dart';
import 'package:coremobiledemo/navigator_service.dart';

class SignInPresenter extends BasePresenter implements SignInUseCaseOutput { // kế thừa từ basePresenter và các abstract Use case
  //Presenter dùng để điều hướng cho page giao tiếp với Use case
  SignInPresenter({@required BuildContext context, @required SignInView view})
      : super(context: context) {
    _view = view;
  }

  SignInView _view;
  FocusNode usernameFocusNode = FocusNode();

  BehaviorSubject<String> _usernameError = BehaviorSubject();
  Stream<String> get usernameErrorObserver => _usernameError.stream;

  FocusNode passwordFocusNode = FocusNode();

  BehaviorSubject<String> _passwordError = BehaviorSubject();
  Stream<String> get passwordErrorObserver => _passwordError.stream;
  SignInUseCase _signInUseCase;
// tất cả các text của ứng dụng khai báo ở đây
  String titleApp = getTextLz("login_title");
  String titleAppContent = getTextLz("sign_in_app_content");
  String loginButtonTitle = getTextLz("login");
  String signInPlease = getTextLz("sign_in_please");
  String signInUsername = getTextLz("sign_in_username");
  String signInPassword = getTextLz("sign_in_password");
  String signInFail = getTextLz("sign_in_failed");

  @override
  void updateDependencies(BuildContext context) {
    _signInUseCase = UseCaseManager.getUseCase<SignInUseCase>(context);
    super.updateDependencies(context);
  }

  Future<void> login() async {
    if (_signInUseCase.validateData(this, true)) {
      await _view.showLoading();
      String err = await _signInUseCase.submit();
      await _view.hideLoading();
      if (isStringNullOrEmpty(err)) {
        gotoHome();
      } else {
        _view.showLoginFail();
      }
    }
  }

  void onChangePass(String text) {
    _signInUseCase.onChangePass(text);
    _signInUseCase.validateData(this, false);
  }

  void onChangeUserName(String text) {
    _signInUseCase.onChangeUserName(text);
    _signInUseCase.validateData(this, false);
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    _usernameError.close();
    _passwordError.close();
  }

  void gotoHome() {
    NavigatorService.gotoHome(context);
  }

  @override
  void passwordWithError(String err, bool isLogin) {
    if (isLogin) {
      _passwordError.addError(err);
    }
    if (isStringNullOrEmpty(err)) {
      _passwordError.value = err;
    }
  }

  @override
  void userNameWithError(String err, bool isLogin) {
    if (isLogin) {
      _usernameError.addError(err);
    }
    if (isStringNullOrEmpty(err)) {
      _usernameError.value = err;
    }
  }
}
