import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/data/exceptions_string_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final otpVerifyControllerProvider = StateNotifierProvider.autoDispose<
    OTPVerifyScreenController, OTPVerifyScreenState>((ref) {
  return OTPVerifyScreenController();
});

class OTPVerifyScreenController extends StateNotifier<OTPVerifyScreenState> {

  OTPVerifyScreenController()
      : super(OTPVerifyScreenState(
            showLoader: false,
            hasMessage: "",
            validationErrorText: ExceptionStrings.invalidPin,
            showValidationText: false));

  getData() async {
    try {
      state = state.copyWith(showLoader: true, hasMessage: '');
      // List<HomeResItemModel> res = await ref.getContentForHomeScreen();
      // List<HomeResItemModel> res = await _repository.getContentForHomeScreen();
      state = state.copyWith(
        showLoader: false,
      );
    } catch (e) {
      debuggerAdvance(tag: "At Catch Login Controller", value: e.runtimeType);
      state = state.copyWith(showLoader: false, hasMessage: e.toString());
    }
  }

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
    await FirebaseAuth.instance.signInWithCredential(credential)
        .then((UserCredential userCredential) {


         });
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
