import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProgressDialogLoading {
  CustomProgressDialogLoading({this.context, this.useRootNavigator: false});

  final bool useRootNavigator;
  final BuildContext context;
  bool _isTouchOutSide = false;
  bool _isTouchTwp = false;
  bool _isShowLoading = false;

  bool get isShowLoading => this._isShowLoading;

  Future<bool> isTouchOutSide() {
    if(_isTouchOutSide) {
      this._isTouchTwp = true;
    }
    this._isTouchOutSide = true;
    this._isShowLoading = false;
    return Future.value(true);
  }

  Future<bool> show() async {
    this._isShowLoading = true;
    showDialog<dynamic>(
      useRootNavigator: useRootNavigator,
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: this.isTouchOutSide,
          child: Center(
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
    return true;
  }

  Future<bool> hide() async {
    this._isShowLoading = false;
    if (!this._isTouchOutSide) {
      Navigator.of(context).pop();
      return false;
    } else {
      if(!this._isTouchTwp) {
        this._isTouchOutSide = false;
      }
      return true;
    }
  }
}
