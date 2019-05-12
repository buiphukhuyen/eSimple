class Validations {
  
  static bool isValidEmail(String email) {
    /*if (email.isEmpty) {
      // The form is empty
      return false;
    } */
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(email)) {
      // So, the email is valid
      return true;
    }
    // The pattern of the email didn't match the regex above.
    return false;
  }

  static bool isValidPassword(String password) {
    if (password.length > 5) {
      return true;
    }
    return false;
  }

  static bool isValidEmpty(String value) {
    if(value.length==0) {
      return false;
    }
    return true;
  }

}