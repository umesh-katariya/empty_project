import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthResponse<T> {
  int? status;
  User? firebaseUser;
  T? data;
  String? error;

  AuthResponse(
      {@required this.status, this.firebaseUser, this.data, this.error});

  factory AuthResponse.fromData(
      {User? firebaseUser, T? userData, dynamic error}) {
    if (error != null) {
      return AuthResponse(
        status: 0,
        firebaseUser: firebaseUser,
        data: userData,
        error: _getError(error),
      );
    } else {
      if (firebaseUser != null) {
        return AuthResponse(
          status: 0,
          firebaseUser: firebaseUser,
          data: userData,
          error: _getError(error),
        );
      } else {
        return AuthResponse(
          status: 0,
          firebaseUser: firebaseUser,
          data: userData,
          error: _getError("Something went wrong"),
        );
      }
    }
  }

  static String getErrorString(FirebaseException error) {
    String errorMessage;
    switch (error.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";

      case "invalid-verification-code":
        return "Please enter valid OTP.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
      default:
        errorMessage = "Something went wrong.";
    }
    return errorMessage;
  }

  static String _getError(dynamic e) {
    if (e == null) {
      return '';
    } else if (e is String) {
      return e;
    } else if (e is PlatformException) {
      return e.message!;
    } else if (e is FirebaseAuthException) {
      return getErrorString(e);
    } else if (e is SocketException) {
      return e.message;
    } else if (e is Exception) {
      return e.toString();
    } else if (e is Map) {
      return e.toString();
    }
    return '';
  }
}
