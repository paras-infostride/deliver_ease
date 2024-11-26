import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/global_providers.dart';
import '../../../domain/app_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

final dashboardScreenControllerProvider = StateNotifierProvider.autoDispose<DashboardScreenController, DashboardScreenState>((ref) {
  SharedPreferences sharedPreferences=  ref.read(sharedPreferencesProvider).requireValue;
  AppRepo appRepo = ref.read(appRepoProvider);
  return DashboardScreenController(
    appRepo: appRepo,
     sharedPreferenceInstance: sharedPreferences
  );
});


class DashboardScreenController extends StateNotifier<DashboardScreenState> {
  final SharedPreferences sharedPreferenceInstance;
  final  AppRepo appRepo;

  DashboardScreenController({required this.sharedPreferenceInstance,
    required this.appRepo})
      : super(DashboardScreenState(
    showLoader: false,
    hasMessage: "",
  ));

  getData() async {
    try {
      state =
          state.copyWith(showLoader: true ,hasMessage: '');
        UserProfile userProfile  =   await  appRepo.fetchUserDetail(FirebaseAuth.instance.currentUser!.uid);
      state = state.copyWith(
        showLoader: false,
        userProfile: userProfile
      );
    }
    catch (e) {
      debuggerAdvance(tag: "At Catch Login Controller", value: e.runtimeType);
      state = state.copyWith(showLoader: false, hasMessage: e.toString());
    }
  }

}


class DashboardScreenState {

  bool showLoader = false;
  String hasMessage = "";
  UserProfile? userProfile;

//<editor-fold desc="Data Methods">
  DashboardScreenState({
    required this.showLoader,
    required this.hasMessage,
    this.userProfile,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DashboardScreenState &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          hasMessage == other.hasMessage &&
          userProfile == other.userProfile);

  @override
  int get hashCode =>
      showLoader.hashCode ^ hasMessage.hashCode ^ userProfile.hashCode;

  @override
  String toString() {
    return 'DashboardScreenState{' +
        ' showLoader: $showLoader,' +
        ' hasMessage: $hasMessage,' +
        ' userProfile: $userProfile,' +
        '}';
  }

  DashboardScreenState copyWith({
    bool? showLoader,
    String? hasMessage,
    UserProfile? userProfile,
  }) {
    return DashboardScreenState(
      showLoader: showLoader ?? this.showLoader,
      hasMessage: hasMessage ?? this.hasMessage,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showLoader': this.showLoader,
      'hasMessage': this.hasMessage,
      'userProfile': this.userProfile,
    };
  }

  factory DashboardScreenState.fromMap(Map<String, dynamic> map) {
    return DashboardScreenState(
      showLoader: map['showLoader'] as bool,
      hasMessage: map['hasMessage'] as String,
      userProfile: map['userProfile'] as UserProfile,
    );
  }

//</editor-fold>
}