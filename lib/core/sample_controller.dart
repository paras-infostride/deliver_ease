import 'package:deliver_ease/core/utils/debug_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sampleControllerProvider = StateNotifierProvider.autoDispose<SampleScreenController, SampleScreenState>((ref) {
  return SampleScreenController();
});


class SampleScreenController extends StateNotifier<SampleScreenState> {

  SampleScreenController()
      : super(SampleScreenState(
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

class SampleScreenState {

  bool showLoader = false;
  String hasMessage = "";
  bool? apiTriggerSuccess;

//<editor-fold desc="Data Methods">
  SampleScreenState({
    required this.showLoader,
    required this.hasMessage,
    this.apiTriggerSuccess,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SampleScreenState &&
          runtimeType == other.runtimeType &&
          showLoader == other.showLoader &&
          hasMessage == other.hasMessage &&
          apiTriggerSuccess == other.apiTriggerSuccess);

  @override
  int get hashCode =>
      showLoader.hashCode ^ hasMessage.hashCode ^ apiTriggerSuccess.hashCode;

  @override
  String toString() {
    return 'SampleScreenState{' +
        ' showLoader: $showLoader,' +
        ' hasMessage: $hasMessage,' +
        ' apiTriggerSuccess: $apiTriggerSuccess,' +
        '}';
  }

  SampleScreenState copyWith({
    bool? showLoader,
    String? hasMessage,
    bool? apiTriggerSuccess,
  }) {
    return SampleScreenState(
      showLoader: showLoader ?? this.showLoader,
      hasMessage: hasMessage ?? this.hasMessage,
      apiTriggerSuccess: apiTriggerSuccess ?? this.apiTriggerSuccess,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showLoader': this.showLoader,
      'hasMessage': this.hasMessage,
      'apiTriggerSuccess': this.apiTriggerSuccess,
    };
  }

  factory SampleScreenState.fromMap(Map<String, dynamic> map) {
    return SampleScreenState(
      showLoader: map['showLoader'] as bool,
      hasMessage: map['hasMessage'] as String,
      apiTriggerSuccess: map['apiTriggerSuccess'] as bool,
    );
  }

//</editor-fold>
}