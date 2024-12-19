import 'package:deliver_ease/core/global_providers.dart';
import 'package:deliver_ease/core/utils/app_strings.dart';
import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:deliver_ease/core/utils/get_current_lat_long.dart';
import 'package:deliver_ease/data/exceptions_string_constants.dart';
import 'package:deliver_ease/domain/app_repo.dart';
import 'package:deliver_ease/domain/user_profile/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../dashboard_controller.dart';

final serviceProviderStateControllerProvider = StateNotifierProvider.autoDispose<ServiceProviderViewController, ServiceProviderViewState>((ref) {
  AppRepo appRepo = ref.read(appRepoProvider);

  return ServiceProviderViewController(
    ref: ref, repo: appRepo
  );
});

class ServiceProviderViewController extends StateNotifier<ServiceProviderViewState> {

final AppRepo repo;
final Ref ref;

  ServiceProviderViewController({
    required this.ref ,
    required this.repo})
      : super(ServiceProviderViewState(
    showLoader: false,
    hasMessage: "",
    isUSerActive: false,
  ));


   getInitialStatusValue()
   {
     DashboardScreenState dashboardScreenState =  ref.read(dashboardScreenControllerProvider);
     state = state.copyWith(isUSerActive: dashboardScreenState.userProfile?.isServiceProviderActive ?? false);
   }

   setSerViceProviderToActive({required bool newValue,}) async {
    try {
      state = state.copyWith(hasMessage: '' ,isUSerActive: newValue);
       DashboardScreenState dashboardScreenState =  ref.read(dashboardScreenControllerProvider);

      Position position =   await  GetCurrentLatLongUtil.getCurrentPosition();
        UserProfile? userProfile =  dashboardScreenState.userProfile?.copyWith(isServiceProviderActive: newValue ,
         latitude: position.latitude,
         longitude: position.longitude
       );

       if (userProfile != null) {
         await repo.updateProfile(userProfile: userProfile);
       }
       else {
           throw ExceptionStrings.someThingWentWrong;
         }
       state = state.copyWith(hasMessage: AppStrings.updatedStatusSuccessfully);
    }
    catch (e) {
      debuggerAdvance(tag: "At Catch Service Provider View Controller", value: e.runtimeType);
      state = state.copyWith(hasMessage: e.toString() , isUSerActive: !newValue);
    }
  }


}

class ServiceProviderViewState {

  bool showLoader = false;
  String hasMessage = "";
  bool? apiTriggerSuccess;
  bool  isUSerActive;

//<editor-fold desc="Data Methods">
  ServiceProviderViewState({
    required this.showLoader,
    required this.hasMessage,
    this.apiTriggerSuccess,
    required this.isUSerActive,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceProviderViewState &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          hasMessage == other.hasMessage &&
          apiTriggerSuccess == other.apiTriggerSuccess &&
          isUSerActive == other.isUSerActive);

  @override
  int get hashCode =>
      showLoader.hashCode ^
      hasMessage.hashCode ^
      apiTriggerSuccess.hashCode ^
      isUSerActive.hashCode;

  @override
  String toString() {
    return 'ServiceProviderViewState{' +
        ' showLoader: $showLoader,' +
        ' hasMessage: $hasMessage,' +
        ' apiTriggerSuccess: $apiTriggerSuccess,' +
        ' isUSerActive: $isUSerActive,' +
        '}';
  }

  ServiceProviderViewState copyWith({
    bool? showLoader,
    String? hasMessage,
    bool? apiTriggerSuccess,
    bool? isUSerActive,
  }) {
    return ServiceProviderViewState(
      showLoader: showLoader ?? this.showLoader,
      hasMessage: hasMessage ?? this.hasMessage,
      apiTriggerSuccess: apiTriggerSuccess ?? this.apiTriggerSuccess,
      isUSerActive: isUSerActive ?? this.isUSerActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showLoader': this.showLoader,
      'hasMessage': this.hasMessage,
      'apiTriggerSuccess': this.apiTriggerSuccess,
      'isUSerActive': this.isUSerActive,
    };
  }

  factory ServiceProviderViewState.fromMap(Map<String, dynamic> map) {
    return ServiceProviderViewState(
      showLoader: map['showLoader'] as bool,
      hasMessage: map['hasMessage'] as String,
      apiTriggerSuccess: map['apiTriggerSuccess'] as bool,
      isUSerActive: map['isUSerActive'] as bool,
    );
  }

//</editor-fold>

}