import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../logger/app_logger.dart';
import '../utils/app_utils.dart';
import 'auth_response.dart';

/// This class represents a utility class for Firebase operations.
class FirebaseUtils {
  /// The static instance of the [FirebaseUtils] class.
  static FirebaseUtils instance = FirebaseUtils();

  /// The Firebase Authentication instance.
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  Future<AuthResponse> signInWithPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
    int? forceResendingToken,
  }) async {
    dynamic error;
    try {
      firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        forceResendingToken: forceResendingToken,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: Duration.zero,
      );
    } on FirebaseAuthException catch (e) {
      error = e;
      AppLog.d("error--- ${error}");
      return AuthResponse.fromData(error: AuthResponse.getErrorString(error));
    } catch (e) {
      error = e;
      AppLog.d("error--- ${error}");
      return AuthResponse.fromData(error: AuthResponse.getErrorString(error));
    }
    AppLog.d("error-11-- ${error}");
    return AuthResponse.fromData(error: error);
  }


  Future<UserCredential?> verifyOtp(
    String otp,
    String verificationCode, {
    bool showLoader = true,
  }) async {
    try {
      await AppUtility.showProgressDialog();

      UserCredential userCredential = await firebaseAuth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationCode,
          smsCode: otp,
        ),
      );
      Get.back();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      AppLog.d(e);
      Get.back();

      AppUtility.showSnackBar(message: AuthResponse.getErrorString(e));
    } catch (e) {
      AppLog.d(e);
    }
    return null;
  }
}
