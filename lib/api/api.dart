class ApiUrl {
  static String _baseUrl = 'https://api.gpstrak.in';
  static String get baseUrl => "$_baseUrl/api/";
  static const String login = "login";

  static void setBaseUrl(String url) {
    _baseUrl = url;
  }

  static const String logout = "logout";
  static const String forgetPasswordOtpGet = "client_password_otp_send";
}
