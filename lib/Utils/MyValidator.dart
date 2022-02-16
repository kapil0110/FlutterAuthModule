class MyValidator{
  static String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty) {
      return "email can not be empty";
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    String pattern =
        r'^[a-zA-Z0-9-.@&$*_]+$';
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty) {
      return "Password can not be empty";
    } else if(value.length < 8) {
      return "Password must be minimum 8 characters long";
    } else if(value.length > 192) {
      return "Password length can not exceed 192 characters";
    } else if (!regex.hasMatch(value)) {
      return 'Only alphabets, numbers and _ @ . # & \$ characters allowed';
    } else {
      return null;
    }
  }

  static String? validateMobile(String? value) {
    String pattern =
        r'^[0-9]+$';
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty) {
      return "Mobile number can not be empty";
    } else if(value.length != 10) {
      return "Not a valid mobile number";
    } else if (!regex.hasMatch(value)) {
      return 'Only numbers allowed';
    } else {
      return null;
    }
  }

  static String? validateUserNameField(String? value) {
    String pattern =
        r'^[a-zA-Z0-9._-]+$';
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty) {
      return "Username can not be empty";
    } else if (!regex.hasMatch(value)) {
      return 'Only alphabets, numbers and _ . - characters allowed';
    } else if (value.length > 25) {
      return 'Name length can not exceed 25 characters';
    } else {
      return null;
    }
  }

  static String? validateNameField(String? value) {
    String pattern =
        r'^[a-zA-Z ]+$';
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty) {
      return "Name can not be empty";
    } else if (!regex.hasMatch(value)) {
      return 'Only alphabets allowed';
    } else if (value.length > 55) {
      return 'Name length can not exceed 55 characters';
    } else {
      return null;
    }
  }

  static String? validateSearchNameField(String? value) {
    String pattern =
        r'^[a-zA-Z0-9 ._-]+$';
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty) {
      return null;
    } else if (!regex.hasMatch(value)) {
      return 'Only alphabets, numbers, and characters - . _ allowed in Name';
    } else if (value.length > 55) {
      return 'Name length can not exceed 55 characters';
    } else {
      return null;
    }
  }

  static String? validateLinkField(String? value) {
    bool isValid = Uri.parse(value!).isAbsolute;

    if(value.isEmpty) {
      return "link can not be empty";
    }
    if(value.contains(" ")) {
      return "Link can not contain space in address.";
    } else if (!isValid) {
      return 'Not a valid link address';
    } else if (value.length > 55) {
      return 'link length can not exceed 55 characters';
    } else {
      return null;
    }
  }
}