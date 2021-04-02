import 'dart:async';
import 'package:coremobiledemo/base/presenter.dart';
import 'package:coremobiledemo/base/subject.dart';
import 'package:coremobiledemo/config/strings_resource.dart';
import 'package:coremobiledemo/entities/signin/sign_in_response.dart';
import 'package:coremobiledemo/navigator_service.dart';
import 'package:coremobiledemo/pages/home/home_interface.dart';
import 'package:coremobiledemo/pages/home/home_usecase.dart';
import 'package:coremobiledemo/usecase/usecase_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePresenter extends BasePresenter {
  HomePresenter({BuildContext context, HomeView view})
      : _view = view,
        super(context: context);

  final HomeView _view;
  HomeUserCase _homeUseCase;
  var titleApp = getTextLz("home_title");
  var logoutButtonTitle = getTextLz("logout_title");
  BehaviorSubject<SignInModel> _dataUserSubject = BehaviorSubject();
  Stream<SignInModel> get dataUserStream => _dataUserSubject.stream;

  @override
  void loadData() {
    super.loadData();
    getUser();
  }

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
    _homeUseCase = UseCaseManager.getUseCase<HomeUserCase>(context);
  }

  void getUser() {
    _dataUserSubject.value = _homeUseCase.userLogin();
  }

  Future<void> logout() async {
    await _view.showLoading();
    String err = await _homeUseCase.logout();
    await _view.hideLoading();
    if (isStringNullOrEmpty(err)) {
      NavigatorService.switchSignIn(context);
    } else {
      _view.showToast(err);
    }
  }

  @override
  void dispose() {}
}
