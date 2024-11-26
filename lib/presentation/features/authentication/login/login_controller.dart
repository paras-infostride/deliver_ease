

import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/data/exceptions_string_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';


final loginControllerProvider = StateNotifierProvider.autoDispose<LoginScreenController, LoginScreenState>((ref) {
  return LoginScreenController();
});


class LoginScreenController extends StateNotifier<LoginScreenState> {

  LoginScreenController()
      : super(LoginScreenState(
    showLoader: false,
    hasMessage: "",
    verificationID: ''
  ));

  submitPhoneNumber({required String phoneNumber}) async {
    try {
      state =
          state.copyWith(showLoader: true ,hasMessage: "" , apiTriggerSuccess: null);
      FirebaseAuth auth = FirebaseAuth.instance;

      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            state = state.copyWith(showLoader: false, hasMessage: "Invalid phone number");
          }
         else if (e.code == 'too-many-requests') {
            state = state.copyWith(showLoader: false, hasMessage: ExceptionStrings.weHaveTemporarilyBlockedAllRequestFromThisDeviceTryAgainLater);
          }
         else {
             state = state.copyWith(showLoader: false, hasMessage: e.toString());
           }

          debuggerAdvance(tag: "error code is : ", value: e.code ,type: DebugType.error );
        },
        codeSent: (String verificationId, int? resendToken) async {
          debuggerAdvance(tag: "verificationId is: ", value: verificationId);
          debuggerAdvance(tag: "resendToken is: ", value: resendToken);

          state = state.copyWith(
              showLoader: false,
              apiTriggerSuccess: true,
            verificationID: verificationId
          );
          // Update the UI to prompt the user to enter the SMS code
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debuggerAdvance(tag: "codeAutoRetrievalTimeout verificationId is: ", value: verificationId);
          // Auto-retrieval timeout has elapsed. Prompt user to enter the code manually.
        },
      );

    }

    catch (e) {
      debuggerAdvance(tag: "At Catch Login Controller", value: e.runtimeType);
      state = state.copyWith(showLoader: false, hasMessage: e.toString());
    }
  }

}

class LoginScreenState {
  bool showLoader = false;
  String hasMessage = "";
  String verificationID = "";
  bool? apiTriggerSuccess;

//<editor-fold desc="Data Methods">
  LoginScreenState({
    required this.showLoader,
    required this.hasMessage,
    required this.verificationID,
    this.apiTriggerSuccess,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginScreenState &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          hasMessage == other.hasMessage &&
          verificationID == other.verificationID &&
          apiTriggerSuccess == other.apiTriggerSuccess);

  @override
  int get hashCode =>
      showLoader.hashCode ^
      hasMessage.hashCode ^
      verificationID.hashCode ^
      apiTriggerSuccess.hashCode;

  @override
  String toString() {
    return 'LoginScreenState{' +
        ' showLoader: $showLoader,' +
        ' hasMessage: $hasMessage,' +
        ' verificationID: $verificationID,' +
        ' apiTriggerSuccess: $apiTriggerSuccess,' +
        '}';
  }

  LoginScreenState copyWith({
    bool? showLoader,
    String? hasMessage,
    String? verificationID,
    bool? apiTriggerSuccess,
  }) {
    return LoginScreenState(
      showLoader: showLoader ?? this.showLoader,
      hasMessage: hasMessage ?? this.hasMessage,
      verificationID: verificationID ?? this.verificationID,
      apiTriggerSuccess: apiTriggerSuccess ?? this.apiTriggerSuccess,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showLoader': this.showLoader,
      'hasMessage': this.hasMessage,
      'verificationID': this.verificationID,
      'apiTriggerSuccess': this.apiTriggerSuccess,
    };
  }

  factory LoginScreenState.fromMap(Map<String, dynamic> map) {
    return LoginScreenState(
      showLoader: map['showLoader'] as bool,
      hasMessage: map['hasMessage'] as String,
      verificationID: map['verificationID'] as String,
      apiTriggerSuccess: map['apiTriggerSuccess'] as bool,
    );
  }

//</editor-fold>
}