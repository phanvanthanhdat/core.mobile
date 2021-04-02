import 'package:coremobiledemo/pages/splash/splash_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coremobiledemo/base/page.dart';
import 'package:coremobiledemo/components/loading.dart';
import 'package:coremobiledemo/config/colors_resource.dart';

class SplashPage extends StatefulWidget {
  static const routeName = 'SplashPage';

  const SplashPage();

  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends BaseState<SplashPresenter, SplashPage> {
  @override
  void init() {
    presenter = SplashPresenter(context: context);
  }

  @override
  void onPostFrame() {
    super.onPostFrame();
    presenter.next();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0063AD),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Loading(
              circleColor: ColorsResource.primaryColor,
              backgroundColor: Colors.white,
              size: 40.0,
            )
          ],
        ),
      ),
    );
  }
}
