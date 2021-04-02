class AppConfig {
  static const bool isPrintLog = !isRelease;
  static const bool isRelease = false; // false is demo, true is production
  static const String domain = isRelease ? 'https://www.google.com/' : "https://www.google.com/";
}