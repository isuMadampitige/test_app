extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension PhoneNumberValidation on String {
  bool isMobileNumberValid() {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = new RegExp(regexPattern);

    if (this.length == 0) {
      return false;
    } else if (regExp.hasMatch(this)) {
      return true;
    } else if (RegExp(r'^[a-z]+$').hasMatch(this)) {
      return false;
    }
    return false;
  }
}
