class DomainUrl {
  static const urlLogin = 'login';
  static const urlLogOut = 'logout';
  static getUrl(String domain, String subUrl) {
    return '$domain$subUrl';
  }
}
