import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coremobiledemo/observer/force_logout.dart';
import 'package:provider/provider.dart';

abstract class Presenter {
  void loadData();
  void updateDependencies(BuildContext context);
}

abstract class BasePresenter implements Presenter {
  BuildContext _context;
  ForceLogoutObserver _logoutObserver;

  BasePresenter({@required BuildContext context})
      : assert(context != null),
        _context = context;

  BuildContext get context => _context;
  ForceLogoutObserver get logoutObserver => _logoutObserver;

  @override
  void loadData() {
  }

@override
  void updateDependencies(BuildContext context) {
    // TODO: implement updateDependencies
  this._context = context;
  _logoutObserver = Provider.of(context);
  }

  void observerLogout() {
    this.logoutObserver.dataObserver.value = true;
  }

  StreamSubscription<void> listenerLogoutObserver(Function(bool) onchange) {
    if (onchange != null) {
      return this.logoutObserver.listener(onDataChange: onchange);
    }
    return null;
  }

  void dispose();
}
