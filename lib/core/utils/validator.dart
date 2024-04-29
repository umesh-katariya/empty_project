// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

class Validator {
  // Validations
  static const EMAIL_VALIDATOR =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const PASS_VALIDATOR =
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*?[!@#\\\$&*~]).{6,}';
  static const PHONE_VALIDATOR = r'(^(?:[+0]9)?[0-9]{10,12}$)';

  static String? notValidCheck(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter valid value';
    }
    return null;
  }

  static String? notValidAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter valid address';
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    }

    return null;
  }

  static Future<String?> phoneValidator(String? value, String isoCode) async {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    if (!RegExp(PHONE_VALIDATOR).hasMatch(value) && kReleaseMode) {
      return 'Please enter valid phone number';
    }

    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mail';
    }
    if (!RegExp(EMAIL_VALIDATOR).hasMatch(value) && !kReleaseMode) {
      return 'Please enter valid email';
    }
    return null;
  }

  static String? lPassValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 6) {
      return 'Please enter valid password';
    }
    return null;
  }

  static String? passValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (!RegExp(PASS_VALIDATOR).hasMatch(value) && kReleaseMode) {
      return 'Password is not valid (should contain at least one upper case, one lower case, one digit, one Special character and at least 6 characters in length)';
    }

    return null;
  }

  static String? confirmPassValidator(
      String? value, TextEditingController passController) {
    if (value == null || value.isEmpty) {
      return 'Please enter your confirm password';
    }

    if (passController.text != value) {
      return 'Both password must be same';
    }

    return null;
  }

  static String? promptValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length < 5) {
        return 'Please enter more than 5 chars';
      }
    }

    return null;
  }

  static String? dobValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your date';
    }

    // final temp = value.trim().replaceAll('-', '').replaceAll('/', '');
    final parts = value.trim().split('/');
    final dayString = parts[0].replaceAll('-', '');
    final monthString = parts[1].replaceAll('-', '');
    final yearString = parts[2].replaceAll('-', '');
    // Validate day and month as the user types
    if (dayString.isNotEmpty) {
      // Validate day
      int day = int.tryParse(dayString) ?? 0;
      if (day > 31 || day < 1) {
        return 'Please enter a valid date';
      }
    }
    if (monthString.isNotEmpty) {
      // Validate month
      int month = int.tryParse(monthString) ?? 0;
      if (month > 12 || month < 1) {
        return 'Please enter a valid date';
      }
    }
    if (yearString.isNotEmpty) {
      // Full validation when the date is completely entered
      DateFormat format = DateFormat(Constants.DATE_FORMATE);
      try {
        final dob = format.parseStrict(value);

        DateTime now = DateTime.now();
        DateTime eighteenthBirthday =
            DateTime(dob.year + 18, dob.month, dob.day)
                .add(const Duration(days: 1));
        DateTime seventySecondYearAgo =
            DateTime(now.year - 72, now.month, now.day)
                .subtract(const Duration(days: 1));
        if (eighteenthBirthday.isAfter(now)) {
          return 'You must be at least 18 years old';
        }

        if (!seventySecondYearAgo.isBefore(dob)) {
          return 'Please enter a valid date';
        }
      } catch (e) {
        print('error in parsing date $e');
        return 'Please enter a valid date ';
      }
    }else {
      return 'Please enter a valid date';
    }

    return null; // No errors
  }

  static String? bioValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your bio';
    }

    if (value.length < 70) {
      return 'Please enter more than 70 chars';
    }

    return null;
  }

  static String? reportValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your bio';
    }

    if (value.length < 20) {
      return 'Please enter more than 20 chars';
    }

    return null;
  }

  // add height validator
  static String? heightValidator(String? value, int? unit) {
    print("heightValidator -- value:$value  unit:$unit");
    if (value != null && value.isNotEmpty) {
      switch (unit) {
        case 0:
          int? height = int.tryParse(value);
          if (height == null) {
            return 'Height must be a number';
          }

          if (height < 50 || height > 250) {
            return 'Enter a valid height (50 - 250 cm)';
          }
          break;

        case 1:
          int? height = int.tryParse(value);
          print("height-- $height");
          if (height == null) {
            return 'Height must be a number';
          }

          if (height < 2 || height > 8) {
            return 'Enter a valid height (2 - 8 feet)';
          }
          break;
        default:
      }
    }

    return null;
  }

  // add height validator
  static bool isHeightValidator(String? value, int? unit) {
    print("heightValidator -- value:$value  unit:$unit");
    if (value != null && value.isNotEmpty) {
      switch (unit) {
        case 0:
          int? height = int.tryParse(value);
          if (height == null) {
            return false;
          }

          if (height < 50 || height > 250) {
            return false;
          }
          break;

        case 1:
          int? height = int.tryParse(value);
          if (height == null) {
            return false;
          }

          if (height < 2 || height > 8) {
            return false;
          }
          break;
        default:
      }
    }

    return true;
  }

  static String? captionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your caption';
    }

    if (value.length < 5) {
      return 'Please enter more than 5 chars';
    }

    return null;
  }
}
