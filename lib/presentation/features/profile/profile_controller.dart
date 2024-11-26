import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileControllerProvider = StateNotifierProvider.autoDispose<ProfileScreenController, ProfileScreenState>((ref) {

  return ProfileScreenController();
});


class ProfileScreenController extends StateNotifier<ProfileScreenState> {

  ProfileScreenController()
      : super(ProfileScreenState(
    showLoader: false,
    hasMessage: "",
  ));
  getData() async {
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
}


class ProfileScreenState {

  bool showLoader = false;
  String hasMessage = "";

//<editor-fold desc="Data Methods">
  ProfileScreenState({
    required this.showLoader,
    required this.hasMessage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileScreenState &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          hasMessage == other.hasMessage);

  @override
  int get hashCode => showLoader.hashCode ^ hasMessage.hashCode;

  @override
  String toString() {
    return 'ProfileScreenState{' +
        ' showLoader: $showLoader,' +
        ' hasMessage: $hasMessage,' +
        '}';
  }

  ProfileScreenState copyWith({
    bool? showLoader,
    String? hasMessage,
  }) {
    return ProfileScreenState(
      showLoader: showLoader ?? this.showLoader,
      hasMessage: hasMessage ?? this.hasMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showLoader': this.showLoader,
      'hasMessage': this.hasMessage,
    };
  }

  factory ProfileScreenState.fromMap(Map<String, dynamic> map) {
    return ProfileScreenState(
      showLoader: map['showLoader'] as bool,
      hasMessage: map['hasMessage'] as String,
    );
  }

//</editor-fold>
}