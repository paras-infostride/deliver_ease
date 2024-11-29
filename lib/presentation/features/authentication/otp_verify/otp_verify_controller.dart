import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/core/utils/shared_prefs.dart';
import 'package:deliver_ease/data/exceptions_string_constants.dart';
import 'package:deliver_ease/domain/app_repo.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/global_providers.dart';

final otpVerifyControllerProvider = StateNotifierProvider.autoDispose<
    OTPVerifyScreenController, OTPVerifyScreenState>((ref) {
   SharedPreferences sharedPreferences=  ref.read(sharedPreferencesProvider).requireValue;
     AppRepo appRepo = ref.read(appRepoProvider);
  return OTPVerifyScreenController(
    appRepo: appRepo,
    sharedPreferenceInstance: sharedPreferences
  );
});

class OTPVerifyScreenController extends StateNotifier<OTPVerifyScreenState> {

 final SharedPreferences sharedPreferenceInstance;
 final  AppRepo appRepo ;

  OTPVerifyScreenController(
      {required this.sharedPreferenceInstance,
        required this.appRepo})
      : super(OTPVerifyScreenState(
            showLoader: false,
            hasMessage: "",
            validationErrorText: ExceptionStrings.invalidPin,
            showValidationText: false));



  validateIt({required String pin ,required String verificationID}) async {

   if(pin.isEmpty)
   {
       state = state.copyWith(
         showValidationText: true,
         validationErrorText: ExceptionStrings.pinIsEmpty
       );
       return;
     }
   else if (pin.length !=6 )
   {
      state = state.copyWith(
          showValidationText: true,
          validationErrorText: ExceptionStrings.invalidPin);
      return;
    }
   else
   {
       state = state.copyWith(
           showValidationText: false,
           validationErrorText: '',
           showLoader: true,
       );
     }

    // / Use the verificationId and smsCode to create a PhoneAuthCredential
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: pin);

   // Sign in the user with the credential
   UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    User? user = FirebaseAuth.instance.currentUser;
    debuggerAdvance(
        tag: "user credential",
        value: userCredential.additionalUserInfo.toString());

    // if user not exist will create identity
    // if ( ) {
    //
    //
    // }

  bool isUserAlreadyExist  = await appRepo.checkUserExist(user!.uid.toString());
  debuggerAdvance(tag: 'isUserAlreadyExist', value: isUserAlreadyExist);
   if (isUserAlreadyExist == false) {
     UserProfile userProfile = UserProfile(
         phoneNumber: user?.phoneNumber,
         userId: user?.uid,
         isVerified: false
     );

     await appRepo.createUserIdentity(userProfile);
   }

    sharedPreferenceInstance.setBool(SharedPreferencesKey.isLogin, true);
    state = state.copyWith(
     showLoader:  false,
     apiTriggerSuccess: true,
   );
  }

}

class OTPVerifyScreenState {
  bool showLoader = false;
  String hasMessage = "";
  bool? apiTriggerSuccess;
  String validationErrorText;

  bool showValidationText = false;

//<editor-fold desc="Data Methods">
  OTPVerifyScreenState({
    required this.showLoader,
    required this.hasMessage,
    this.apiTriggerSuccess,
    required this.validationErrorText,
    required this.showValidationText,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OTPVerifyScreenState &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          hasMessage == other.hasMessage &&
          apiTriggerSuccess == other.apiTriggerSuccess &&
          validationErrorText == other.validationErrorText &&
          showValidationText == other.showValidationText);

  @override
  int get hashCode =>
      showLoader.hashCode ^
      hasMessage.hashCode ^
      apiTriggerSuccess.hashCode ^
      validationErrorText.hashCode ^
      showValidationText.hashCode;

  @override
  String toString() {
    return 'OTPVerifyScreenState{' +
        ' showLoader: $showLoader,' +
        ' hasMessage: $hasMessage,' +
        ' apiTriggerSuccess: $apiTriggerSuccess,' +
        ' validationErrorText: $validationErrorText,' +
        ' showValidationText: $showValidationText,' +
        '}';
  }

  OTPVerifyScreenState copyWith({
    bool? showLoader,
    String? hasMessage,
    bool? apiTriggerSuccess,
    String? validationErrorText,
    bool? showValidationText,
  }) {
    return OTPVerifyScreenState(
      showLoader: showLoader ?? this.showLoader,
      hasMessage: hasMessage ?? this.hasMessage,
      apiTriggerSuccess: apiTriggerSuccess ?? this.apiTriggerSuccess,
      validationErrorText: validationErrorText ?? this.validationErrorText,
      showValidationText: showValidationText ?? this.showValidationText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showLoader': this.showLoader,
      'hasMessage': this.hasMessage,
      'apiTriggerSuccess': this.apiTriggerSuccess,
      'validationErrorText': this.validationErrorText,
      'showValidationText': this.showValidationText,
    };
  }

  factory OTPVerifyScreenState.fromMap(Map<String, dynamic> map) {
    return OTPVerifyScreenState(
      showLoader: map['showLoader'] as bool,
      hasMessage: map['hasMessage'] as String,
      apiTriggerSuccess: map['apiTriggerSuccess'] as bool,
      validationErrorText: map['validationErrorText'] as String,
      showValidationText: map['showValidationText'] as bool,
    );
  }

//</editor-fold>
}
