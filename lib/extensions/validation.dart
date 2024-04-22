extension Validation on String {
  bool get isValidEmail {
    RegExp emailPattern = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailPattern.hasMatch(this);
  }

  bool get isValidPassword {
    RegExp passwordPatten =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}');
    return passwordPatten.hasMatch(this);
  }
}
