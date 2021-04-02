import 'dart:async';
import 'dart:io';
import 'package:coremobiledemo/base/presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_statusbar_text_color/flutter_statusbar_text_color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:coremobiledemo/config/strings_resource.dart';
import 'package:coremobiledemo/utils/alert_dialog.dart';
import 'package:coremobiledemo/utils/constant.dart';
import 'package:coremobiledemo/utils/custom_progress_dialog.dart';

abstract class BaseState<B extends BasePresenter, Page extends StatefulWidget>
    extends State<Page> with RouteAware {
  CustomProgressDialogLoading _progressDialogLoading;
  B presenter;
  bool isInit = false;
  bool isUpdateDependencies = false;
  Timer _timer;
  CustomProgressDialogLoading get progressDialogLoading {
    if (_progressDialogLoading == null) {
      _progressDialogLoading = CustomProgressDialogLoading(
          context: context, useRootNavigator: false);
    }
    return _progressDialogLoading;
  }

  @override
  void initState() {
    super.initState();
    if (!isInit) {
      init();
      isInit = true;
    }
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      _changeColorStatus();
      onPostFrame();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void init();

  void onPostFrame() {
    presenter.loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("updateDependencies " + context.toString());
    if (!isUpdateDependencies) {
      presenter.updateDependencies(context);
      Constant.routeObserver.subscribe(this, ModalRoute.of(context));
      isUpdateDependencies = true;
    }
  }

  @override
  void didPush() {
    _unfocus();
  }

  @override
  void didPop() {
    _unfocus();
  }

  get isLightStatus => true;

  void _changeColorStatus() {
    if (Platform.isIOS) {
      _timer?.cancel();
      _timer = Timer(Duration(milliseconds: 200), () async {
        try {
          FlutterStatusbarTextColor.setTextColor(isLightStatus
              ? FlutterStatusbarTextColor.light
              : FlutterStatusbarTextColor.dark);
        } catch (err) {
          print(err);
        }
      });
    } else {
      // nothing with android
    }
  }

  Future<void> toastMessage({String msg}) {
    return Fluttertoast.showToast(msg: msg);
  }

  Future<void> toastMessageExpired() {
    return toastMessage(msg: StringResource.getText('expired'));
  }

  Future<void> toastMessagePermissionDeny() {
    return toastMessage(msg: StringResource.getText('no_permission'));
  }

  Future<void> toastMessageTimeout() {
    return toastMessage(msg: StringResource.getText('time_out'));
  }

  Future<bool> showPopupWithAction(String message,
      {String title,
      @required List<Widget> actions,
      bool isCancel = false}) async {
    if (title == null || title == "") {
      title = StringResource.getText("information");
    }
    await AlertDialogBuilder(context: context, content: message, title: title)
        .show(cancelable: isCancel, actions: actions);
    return true;
  }

  void _unfocus() {
    FocusScope.of(context).requestFocus(new FocusNode()); //remove focus
  }
}
