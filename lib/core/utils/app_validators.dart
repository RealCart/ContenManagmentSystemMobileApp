class AppValidators {
  static String? loginValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is empty!";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is empty!";
    }

    return null;
  }

  static String? repeatPasswordValudator(
    String? repeatPassword,
    String? password,
  ) {
    if (password != repeatPassword) {
      return "Password is not equal to repeat password!";
    }

    return null;
  }
}
