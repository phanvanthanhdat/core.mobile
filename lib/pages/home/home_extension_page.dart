
import 'package:flutter/material.dart';
import 'package:coremobiledemo/navigator_service.dart';
import 'package:coremobiledemo/pages/home/home_page.dart';
import 'package:coremobiledemo/observer/action_back_android.dart';
import 'package:provider/provider.dart';

class HomeExtensionPage extends StatelessWidget {

  static const routeName = 'home_extension';

  Future<bool> _onWillPop(BuildContext context) async {
    ActionBackAndroidObserver backAction = Provider.of<ActionBackAndroidObserver>(context, listen: false);
    backAction?.data = true;
    return false;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: Navigator(
        initialRoute: MyHomePage.routeName,
        onGenerateRoute: NavigatorService.generateHomeRoute,
      ),
    );
  }
}