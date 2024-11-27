import 'package:flutter/material.dart';

import 'common_components.dart';

/// Usage:
/// CustomDropdown<String>(
//     items: ['A', 'B', 'C'],
//     onChanged: (val) => _selectedValue = val,
//     center: true,
//  ),
/// --> Remember: f.toString() at line 105 is @override String toString() in your class
// @override
// String toString() {
//   return name;
// }          CustomDropdown<StatusModel>(
//             fontSize: AppFonts.placeHolderFilterAndSearch,
//             trailingIcon:  const Icon(
//                 Icons.filter_alt_outlined,
//               size: 18,
//               color: AppColors.blackColor,
//             ),
//
//             margin: const EdgeInsets.only(right: 18),
//             padding: const EdgeInsets.symmetric(horizontal: 18),
//             items: listOfStatusModel,
//             onChanged: (val)
//             {
//               _SelectedStatusModel = val;
//               appDebugger(tag: "custom dropdown", value: val.status);
//             },
//              onInit: (StatusModel val) {
//                _SelectedStatusModel = val;
//               appDebugger(tag: "custom dropdown init", value: val);
//           },
//             initialText: AppStrings.filterByStatusText,
//
//           ),

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final Function(T value) onChanged;
  double borderRadius;
  final Function(T value) onInit;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double height;
  Color? borderColor;
  final String initialText;
  final int? selectedValueIndex;
  final String headingText;
  final bool isExpanded;
  final Widget? trailingIcon;
  final double? fontSize;
  final Color? color;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  CustomDropdown(
      {Key? key,
      required this.items,
      required this.onChanged,
      required this.onInit,
      this.borderRadius = 8.0,
      this.headingText = '',
      this.padding = const EdgeInsets.symmetric(horizontal: 12),
      this.margin = EdgeInsets.zero,
      this.height = 50,
      this.initialText = '',
      this.selectedValueIndex,
      this.borderColor,
      this.isExpanded = false,
      this.trailingIcon = const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 22,
        color: Colors.grey,
      ),
      this.fontSize = 18,
      this.color,
      this.textStyle,
      this.hintStyle})
      : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  /// current selected value
  late T? _selectedValue;

  @override
  void initState() {
    super.initState();
    debugPrint("custom dropdown initState is called");
    _initValue();
  }

  @override
  void dispose() {
    super.dispose();
    _selectedValue = null;
  }

  @override
  void didUpdateWidget(covariant CustomDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("did widget update called");
    _initValue();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("custom dropdown build ${_selectedValue.toString()}");
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.headingText.isNotEmpty) ...[
            TextView(
              title: widget.headingText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              margin: const EdgeInsets.only(bottom: 6),
            ),
          ],
          Container(
            // padding: widget.padding,
            // height: widget.height,
            // decoration: BoxDecoration(
            //   color: widget.color ?? Colors.white,
            //   border: Border.all(width: 1.2, color: widget.color ?? Colors.grey),
            //   borderRadius: const BorderRadius.all(Radius.circular(8)),
            // ),
            child: DropdownButtonFormField<T>(
              // itemHeight: 200,
              validator: (value) {
                if (value == null) {
                  return 'Relationship is required';
                }
              },
              decoration: InputDecoration(
                  errorStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                      //TODO
                      fontFamily: ''),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                        color: widget.borderColor ?? Colors.grey, width: 1.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                        color: widget.borderColor ?? Colors.grey, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: const BorderSide(color: Colors.red, width: 1.0),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(widget.borderRadius)),
                  )),
              isExpanded: widget.isExpanded,
              hint: Text(
                widget.initialText,
                style: widget.hintStyle ??
                    const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xff9f9e9f)),
              ),
              // dropdownColor: ,
              icon: Container(
                  margin: const EdgeInsets.only(right: 6),
                  child: widget.trailingIcon),
              value: _selectedValue,
              onChanged: (T? newValue) {
                if (newValue != null) {
                  _selectedValue = newValue;
                  widget.onChanged(newValue);
                  setState(() {});
                }
              },
              items: widget.items.map((T f) {
                return DropdownMenuItem<T>(
                  value: f,
                  child: Text(
                    f.toString(),
                    style: widget.textStyle ??
                        const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xff010001)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// set default selected value when init
  _initValue() {
    if (widget.selectedValueIndex != null) {
      _selectedValue = widget.items[widget.selectedValueIndex!];
    } else if (widget.selectedValueIndex == null &&
        widget.initialText.isNotEmpty) {
      _selectedValue = null;
      debugPrint(
        "custom dropdown init  ${_selectedValue.toString()}",
      );
    } else if (widget.initialText.isEmpty) {
      _selectedValue = widget.items[0];
      widget.onInit(_selectedValue as T);
    }
  }
}
