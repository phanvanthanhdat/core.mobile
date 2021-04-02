import 'package:easy_localization/easy_localization.dart' as EasyLocalization;
import 'package:coremobiledemo/config/app_config.dart';

class StringResource {
  static const String baseURLForIcon = '${AppConfig.domain}storage/';

  static String getText(String key) {
    return EasyLocalization.tr(key);
  }

  static String getTextResource(String key) {
    return EasyLocalization.tr(key);
  }

  static String getLinkResource(String url) {
    if (url.startsWith('https') || url.startsWith('http')) {
      return url;
    } else if (url.startsWith('/')) {
      return baseURLForIcon + url.substring(1);
    }
    return baseURLForIcon + url;
  }
}

String getTextLz(String key) {
  return EasyLocalization.tr(key);
}

bool isStringNullOrEmpty(String text) {
    return text == null || text == "";
}