import 'debug_logger.dart';

bool listHaveLength<T>(Iterable<T>? values) {
  return values != null && values.isNotEmpty;
}

checkListLength<T>(Iterable<T>? values, {String? tag = "BEFORE"}) {
  if (values == null || values.isEmpty) {
    debuggerAdvance(
        tag: "$tag length of  ${T.toString()} list:", value: "[] or null");
  } else {
    debuggerAdvance(
        tag: "$tag length of  ${T.toString()} list:",
        value: values.length.toString());
  }
}

bool stringHasValue(String? value) {
  return value != null && value.isNotEmpty && value != "null";
}

bool intHaveValue(int? value) {
  return value != null;
}

/*
* USE CASE
 listHaveLength(badgeModel.badgeResModel.badgeCategories)
* */