class AuthValidators {
  String? userNameValidator(String? val) {
    if (val != null && val.length > 3) {
      return null;
    } else {
      return "User Name must have more than 3 characters";
    }
  }

  String? passwordValidator(String? val) {
    final String password = val ?? "";
    RegExp upperCaseRegex = RegExp(r'[A-Z]');
    RegExp lowerCaseRegex = RegExp(r'[a-z]');
    RegExp digitRegex = RegExp(r'[0-9]');
    RegExp specialCharRegex = RegExp(r'[!@#\$&*~]');

    if (password.isEmpty) {
      return 'Please enter a password';
    } else {
      int strength = 0;

      if (password.length >= 8) strength++;
      if (upperCaseRegex.hasMatch(password)) strength++;
      if (lowerCaseRegex.hasMatch(password)) strength++;
      if (digitRegex.hasMatch(password)) strength++;
      if (specialCharRegex.hasMatch(password)) strength++;

      if (strength == 0) {
        return 'Very weak password';
      } else if (strength <= 2) {
        return 'Weak password';
      } else if (strength == 3) {
        return 'Medium strength password';
      } else if (strength == 4) {
        return 'Strong password';
      } else {
        return 'Very strong password';
      }
    }
  }

  // if (password.isEmpty || password.length <= 5) {
  //   return "password must have at least 6 characters";
  // }

  // return null;

  String? emailValidator(String? val) {
    if (val != null) {
      final bool emailValid = RegExp(
              r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$')
          .hasMatch(val);
      if (emailValid) {
        return null;
      }
    }
    return "Email is Not Valid";
  }
}
