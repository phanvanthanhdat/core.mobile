import 'package:coremobiledemo/config/app_config.dart';

printDebug(String text) {
  if (!AppConfig.isPrintLog) {
    print(text ?? "");
  }
}
