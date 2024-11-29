import 'package:deliver_ease/core/global_providers.dart';
import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/domain/app_repo.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final profileControllerProvider = StateNotifierProvider.autoDispose<ProfileScreenController, ProfileScreenState>((ref) {
  AppRepo appRepo = ref.read(appRepoProvider);
  return ProfileScreenController(
    appRepo: appRepo
  );
});


class ProfileScreenController extends StateNotifier<ProfileScreenState> {

  final  AppRepo appRepo;
  ProfileScreenController({
    required this.appRepo
})
      : super(
      const ProfileScreenState(
          showLoader: false,
          hasMessage: "",
        userProfile: null,
        pickedFile: null,
        apiTriggredSuccess: false,
        isUSerServiceProvider: false,
        )
  );

  isUserServiceProvider(bool isUserProvider) {
    state = state.copyWith(isUSerServiceProvider: isUserProvider);
  }

  setUserServiceProvider(bool isUserProvider) {
    state = state.copyWith(isUSerServiceProvider: isUserProvider);
  }

  updateProfile(UserProfile userProfile)
  async {
    try {
      state =
          state.copyWith(showLoader: true ,hasMessage: '');
       await  appRepo.updateProfile(userProfile: userProfile);
      // List<HomeResItemModel> res = await ref.getContentForHomeScreen();
      // List<HomeResItemModel> res = await _repository.getContentForHomeScreen();
      state = state.copyWith(
        showLoader: false,
        apiTriggredSuccess: true

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
 final bool apiTriggredSuccess;
 final bool isUSerServiceProvider;

//<editor-fold desc="Data Methods">
  const ProfileScreenState({
    required this.showLoader,
    required this.hasMessage,
    this.pickedFile,
    this.userProfile,
    required this.apiTriggredSuccess,
    required this.isUSerServiceProvider,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileScreenState &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          hasMessage == other.hasMessage &&
          pickedFile == other.pickedFile &&
          userProfile == other.userProfile &&
          apiTriggredSuccess == other.apiTriggredSuccess &&
          isUSerServiceProvider == other.isUSerServiceProvider);

  @override
  int get hashCode =>
      showLoader.hashCode ^
      hasMessage.hashCode ^
      pickedFile.hashCode ^
      userProfile.hashCode ^
      apiTriggredSuccess.hashCode ^
      isUSerServiceProvider.hashCode;

  @override
  String toString() {
    return 'ProfileScreenState{' +
        ' showLoader: $showLoader,' +
        ' hasMessage: $hasMessage,' +
        ' pickedFile: $pickedFile,' +
        ' userProfile: $userProfile,' +
        ' apiTriggredSuccess: $apiTriggredSuccess,' +
        ' isUSerServiceProvider: $isUSerServiceProvider,' +
        '}';
  }

  ProfileScreenState copyWith({
    bool? showLoader,
    String? hasMessage,
    XFile? pickedFile,
    UserProfile? userProfile,
    bool? apiTriggredSuccess,
    bool? isUSerServiceProvider,
  }) {
    return ProfileScreenState(
      showLoader: showLoader ?? this.showLoader,
      hasMessage: hasMessage ?? this.hasMessage,
      pickedFile: pickedFile ?? this.pickedFile,
      userProfile: userProfile ?? this.userProfile,
      apiTriggredSuccess: apiTriggredSuccess ?? this.apiTriggredSuccess,
      isUSerServiceProvider:
          isUSerServiceProvider ?? this.isUSerServiceProvider,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showLoader': this.showLoader,
      'hasMessage': this.hasMessage,
      'pickedFile': this.pickedFile,
      'userProfile': this.userProfile,
      'apiTriggredSuccess': this.apiTriggredSuccess,
      'isUSerServiceProvider': this.isUSerServiceProvider,
    };
  }

  factory ProfileScreenState.fromMap(Map<String, dynamic> map) {
    return ProfileScreenState(
      showLoader: map['showLoader'] as bool,
      hasMessage: map['hasMessage'] as String,
      pickedFile: map['pickedFile'] as XFile,
      userProfile: map['userProfile'] as UserProfile,
      apiTriggredSuccess: map['apiTriggredSuccess'] as bool,
      isUSerServiceProvider: map['isUSerServiceProvider'] as bool,
    );
  }

//</editor-fold>
}