import 'package:flutter/material.dart';
import 'package:coremobiledemo/pages/home/home_extension_page.dart';
import 'package:coremobiledemo/pages/home/home_page.dart';
import 'package:coremobiledemo/pages/signin/sign_in_page.dart';
import 'package:coremobiledemo/pages/splash/splash_page.dart';

class NavigatorService {
  static void popToRoot(BuildContext context) {
    Navigator.of(context)
        .popUntil((route) => route.settings.name == MyHomePage.routeName);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(
            settings: settings, builder: (context) => SplashPage());
      case SignInPage.routeName:
        return MaterialPageRoute(
            settings: settings, builder: (context) => SignInPage());
      case MyHomePage.routeName:
        return MaterialPageRoute(
            settings: settings, builder: (context) => HomeExtensionPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Route<dynamic> generateHomeRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyHomePage.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MyHomePage(),
        );
      case SignInPage.routeName:
        return MaterialPageRoute(
            settings: settings, builder: (context) => SignInPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static bool back<T extends Object>(BuildContext context,
      [bool useRootNavigator = false, T result]) {
    Navigator.of(context, rootNavigator: useRootNavigator).pop(result);
    return true;
  }

  static Future gotoHome(BuildContext context) {
    return Navigator.pushNamedAndRemoveUntil(
        context, MyHomePage.routeName, (route) => false);
  }

  static Future switchHome(BuildContext context) {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(MyHomePage.routeName, (route) => false);
  }

  static Future gotoSignIn(BuildContext context) {
    assert(context != null);
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(SignInPage.routeName, (route) => false);
  }

  static Future switchSignIn(BuildContext context) {
    assert(context != null);
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(SignInPage.routeName, (route) => false);
  }
}
