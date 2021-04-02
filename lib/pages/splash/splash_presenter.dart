import 'package:coremobiledemo/base/presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:coremobiledemo/navigator_service.dart';

class SplashPresenter extends BasePresenter {
  SplashPresenter({BuildContext context}) : super(context: context);

  @override
  void updateDependencies(BuildContext context) {
    super.updateDependencies(context);
  }

  Future<void> next() async {
    NavigatorService.switchSignIn(context);
  }

  @override
  void dispose() {}
}
