import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final profileControllerProvider = StateNotifierProvider.autoDispose<ProfileScreenController, ProfileScreenState>((ref) {

  return ProfileScreenController();
});


class ProfileScreenController extends StateNotifier<ProfileScreenState> {

  ProfileScreenController()
      : super(
      const ProfileScreenState(
          showLoader: false,
          hasMessage: "",
        userProfile: null,
        pickedFile: null
        )
  );

  updateProfile(UserProfile userProfile)
  async {
    try {
      state =
          state.copyWith(showLoader: true ,hasMessage: '');

      // List<HomeResItemModel> res = await ref.getContentForHomeScreen();
      // List<HomeResItemModel> res = await _repository.getContentForHomeScreen();
      state = state.copyWith(
        showLoader: false,
      );
    }

    catch (e) {
      debuggerAdvance(tag: "At Catch Login Controller", value: e.runtimeType);
      state = state.copyWith(showLoader: false, hasMessage: e.toString());
    }
  }


  updateImage({required XFile pickedFile}) async {
    try {
      state =
          state.copyWith(
            pickedFile: pickedFile
          );
    }
    catch (e) {
      debuggerAdvance(tag: "At Catch Login Controller", value: e.runtimeType);
      state = state.copyWith(showLoader: false, hasMessage: e.toString());
    }
  }

}


class ProfileScreenState {

 final  bool showLoader;
 final  String hasMessage;
 final  XFile? pickedFile;
 final  UserProfile? userProfile;

//<editor-fold desc="Data Methods">
  const ProfileScreenState({
    required this.showLoader,
    required this.hasMessage,
    this.pickedFile,
    required this.userProfile,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileScreenState &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          hasMessage == other.hasMessage &&
          pickedFile == other.pickedFile &&
          userProfile == other.userProfile);

  @override
  int get hashCode =>
      showLoader.hashCode ^
      hasMessage.hashCode ^
      pickedFile.hashCode ^
      userProfile.hashCode;

  @override
  String toString() {
    return 'ProfileScreenState{' +
        ' showLoader: $showLoader,' +
        ' hasMessage: $hasMessage,' +
        ' pickedFile: $pickedFile,' +
        ' userProfile: $userProfile,' +
        '}';
  }

  ProfileScreenState copyWith({
    bool? showLoader,
    String? hasMessage,
    XFile? pickedFile,
    UserProfile? userProfile,
  }) {
    return ProfileScreenState(
      showLoader: showLoader ?? this.showLoader,
      hasMessage: hasMessage ?? this.hasMessage,
      pickedFile: pickedFile ?? this.pickedFile,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  ProfileScreenState copyWithForPickedImage({
    bool? showLoader,
    String? hasMessage,
    XFile? pickedFile,
    UserProfile? userProfile,
  }) {
    return ProfileScreenState(
      showLoader: showLoader ?? this.showLoader,
      hasMessage: hasMessage ?? this.hasMessage,
      pickedFile: pickedFile,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showLoader': this.showLoader,
      'hasMessage': this.hasMessage,
      'pickedFile': this.pickedFile,
      'userProfile': this.userProfile,
    };
  }

  factory ProfileScreenState.fromMap(Map<String, dynamic> map) {
    return ProfileScreenState(
      showLoader: map['showLoader'] as bool,
      hasMessage: map['hasMessage'] as String,
      pickedFile: map['pickedFile'] as XFile,
      userProfile: map['userProfile'] as UserProfile,
    );
  }

//</editor-fold>
}