import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:deliver_ease/core/utils/utils.dart';

// ignore: must_be_immutable
class AppTextField extends StatefulWidget {
  late String? hint;
  TextEditingController? controller;
  final EdgeInsets margin;
  AutovalidateMode autoValidateMode;
  late FocusNode? focusNode;
  List<String>? autoFills;
  BuildContext context;
  String? initialValue;
  bool enable;
  Function? validator;
  bool readOnly;
  Widget? suffixIcon;
  Icon? prefixIcon;
  double? width;
  double hintTextFontSize;
  Color fillColor;
  List<TextInputFormatter>? inputFormatter;
  Function()? onTap;
  int maxLimit;
  Function(String) onChanged;
  Function()? onEditing;
  Function(String)? onSubmitted;
  bool isPassword;
  double borderRadius;
  Color? borderColor;
  TextInputType? keyboard;
  TextStyle? textStyle;

  AppTextField(
      {Key? key,
        this.controller,
        required this.context,
        required this.onChanged,
        this.onSubmitted,
        this.textStyle,
        this.onEditing,
        this.hint,
        this.hintTextFontSize = 16,
        this.enable = true,
        this.validator,
        this.focusNode,
        this.suffixIcon,
        this.width,
        this.inputFormatter,
        this.onTap,
        this.autoValidateMode = AutovalidateMode.disabled,
        this.maxLimit = 10000,
        this.autoFills,
        this.isPassword = false,
        this.borderColor,
        this.prefixIcon,
        this.keyboard = TextInputType.text,
        this.initialValue,
        this.readOnly = false,
        this.fillColor = Colors.white,
        this.borderRadius = 4.0,
        this.margin = EdgeInsets.zero})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: widget.margin,
      child: TextFormField(
          autofillHints: widget.autoFills,
          onTap: () {
            log('tpeed${widget.onTap}');
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          initialValue: widget.initialValue,
          autovalidateMode: widget.autoValidateMode,
          onFieldSubmitted: (val) {
            if (widget.onSubmitted != null) {
              widget.onSubmitted!(val);
            }
          },
          style: widget.textStyle ??
              TextStyle(
                  fontSize: 16,
                  color: const Color(0xff010001),
                  //TODO
                  fontFamily: ""),
          keyboardType: widget.keyboard,
          controller: widget.controller,
          obscureText: widget.isPassword,
          validator: (val) {

            if (widget.validator != null) {
              return widget.validator!(val);
            } else if (val.toString().isNotEmpty) {
              return Validator.validateEmpty(val);
            } else {

              return null;
            }
          },
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatter,
          maxLength: widget.maxLimit,
          readOnly: widget.readOnly,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              counterText: '',
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              hintText: widget.hint ?? '',
              fillColor: widget.fillColor,
              errorMaxLines: 3,
              errorStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  //TODO
                  fontFamily: ''),
              hintStyle: TextStyle(
                  fontSize: widget.hintTextFontSize,
                  color: const Color(0xff9f9e9f),
                  fontWeight: FontWeight.w500,
                  //TODO
                  fontFamily: ''),

              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide:
                const BorderSide(color: Colors.grey, width: 1.0),
              ),
              enabled: widget.enable,
              suffixIcon: widget.suffixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                    color: widget.borderColor ?? Colors.grey, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide:
                const BorderSide(color: Colors.red, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                    color: widget.borderColor ?? Colors.grey, width: 1.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide:
                const BorderSide(color: Colors.grey, width: 1.0),
              ))),
    );
  }
}