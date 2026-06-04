enum UserType { lite, main, tez, starter }

extension UserTypeExtension on UserType {
  String toJson() {
    switch (this) {
      case UserType.main:
        return 'Main';
      case UserType.lite:
        return 'Lite';
      case UserType.tez:
        return 'Tez';
      case UserType.starter:
        return 'Starter';
      default:
        throw Exception('Unknown user type');
    }
  }
}
