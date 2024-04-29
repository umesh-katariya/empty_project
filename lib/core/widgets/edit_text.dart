import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_theme/app_colors.dart';

class EditText extends StatelessWidget {
  TextEditingController? controller;
  double fontSize;
  FontWeight fontWeight;
  Color? textColor;
  String? labelText;
  TextStyle? labelStyle;
  String? hint;
  TextStyle? hintStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? inputType;
  TextCapitalization textCapitalization;
  List<TextInputFormatter>? inputFormatters;
  bool obscureText;
  bool? filled;
  Color? fillColor;
  bool showRectangularInputBorder;
  bool? showOutLine;
  Color outlineColor;
  double outlineRadius;
  double? outlineWidth;
  EdgeInsetsGeometry? contentPadding;
  FormFieldValidator<String>? validator;
  int minLines;
  int? maxLines;
  int? maxLength;
  TextAlign textAlign;
  bool enable;
  bool enableSuggestions;
  bool enableInteractiveSelection;
  TextInputAction? inputAction;
  Function(String value)? onFieldSubmitted;
  Function(String value)? onChanged;
  Function()? onEditingComplete;
  void Function()? onTap;
  FocusNode? focusNode = FocusNode();
  void Function(PointerDownEvent)? onTapOutSide;
  String? counterText;
  bool autoFocus;
  bool readOnly;
  bool showCounter;
  bool hideBorder;
  BoxConstraints? prefixIconPadding;

  EditText({super.key,
    this.controller,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.textColor,
    this.labelText,
    this.labelStyle,
    this.hint,
    this.hintStyle,
    this.outlineWidth,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.textCapitalization = TextCapitalization.words,
    this.inputFormatters,
    this.obscureText = false,
    this.filled = true,
    this.fillColor = AppColors.transparentColors,
    this.showRectangularInputBorder = true,
    this.showOutLine,
    this.outlineColor = AppColors.borderColor,
    this.outlineRadius = 10.0,
    this.contentPadding,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.enable = true,
    this.enableSuggestions = true,
    this.enableInteractiveSelection = true,
    this.inputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.onEditingComplete,
    this.focusNode,
    this.onTapOutSide,
    this.onTap,
    this.counterText,
    this.autoFocus = false,
    this.readOnly = false,
    this.hideBorder = false,
    this.prefixIconPadding,
    this.showCounter = true}) {
    if (contentPadding == null) {
      if (showRectangularInputBorder) {
        contentPadding = EdgeInsets.only(
            left: outlineRadius > 10 ? 15 : 10,
            right: outlineRadius > 10 ? 15 : 10,
            top: 10,
            bottom: 10);
        showOutLine ??= true;
      } else {
        contentPadding =
        const EdgeInsets.only(left: 20, right: 10, top: 8, bottom: 10);
        showOutLine ??= false;
      }
    } else {
      showOutLine ??= true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (labelText != null && labelText!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            labelText!,
            style: labelStyle,
          ),
          const SizedBox(height: 10),
          textFormField(),
        ],
      );
    }
    return textFormField();
  }

  Widget textFormField() {
    return TextFormField(
      key: key,
      focusNode: focusNode,
      controller: controller,
      readOnly: readOnly,
      keyboardType: inputType,
      textCapitalization: textCapitalization,
      onTap: onTap,
      inputFormatters: inputFormatters,
      onTapOutside: onTapOutSide ?? (f) => focusNode?.unfocus(),
      obscureText: obscureText,
      validator: validator,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor ?? AppColors.white,
      ),
      cursorColor: textColor ?? AppColors.white,
      decoration: InputDecoration(
        hintText: hint,
        counter: showCounter ? null : const SizedBox(),
        hintStyle: hintStyle??TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: AppColors.textHintColor,
      ),
      errorStyle: labelStyle ?? const TextStyle(color: AppColors.appLightRed),
      floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
      labelStyle: labelStyle ?? const TextStyle(color: AppColors.textColor30),
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIconPadding,
      suffixIcon: suffixIcon,
      filled: filled,
      fillColor: fillColor,
      enabledBorder: hideBorder == true ? InputBorder.none : border,
      border: InputBorder.none,
      disabledBorder: hideBorder == true ? InputBorder.none : border,
      errorBorder: hideBorder == true ? InputBorder.none : border,
      // focusedBorder: enableBorder,
      focusedErrorBorder:
      hideBorder == true ? InputBorder.none : enableBorder,
      contentPadding: contentPadding,
      focusedBorder: hideBorder == true ? InputBorder.none : focusedBorder,
      counterText: showCounter ? null : counterText,
    ),
    minLines: minLines,
    maxLines: maxLines,
    maxLength: maxLength,
    textAlign: textAlign,
    enabled: enable,
    enableSuggestions: enableSuggestions,
    enableInteractiveSelection: enableInteractiveSelection,
    textInputAction: inputAction,
    onFieldSubmitted: onFieldSubmitted,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    autofocus: autoFocus,
    );
  }

  OutlineInputBorder? get enableBorder =>
      showOutLine!
          ? showRectangularInputBorder
          ? OutlineInputBorder(
        borderSide: BorderSide(
          color: outlineColor,
        ),
        borderRadius: BorderRadius.circular(outlineRadius),
      )
          : null
          : null;

  OutlineInputBorder? get focusedBorder =>
      showOutLine!
          ? showRectangularInputBorder
          ? OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(outlineRadius),
      )
          : null
          : null;

  OutlineInputBorder? get border =>
      showOutLine!
          ? showRectangularInputBorder
          ? OutlineInputBorder(
        borderSide: BorderSide(
          color: outlineColor,
          width: outlineWidth ?? 1.0,
        ),
        borderRadius: BorderRadius.circular(outlineRadius),
      )
          : null
          : null;
}
