// ignore_for_file: prefer_const_constructors, avoid_print

import '../../utils/colors.dart';
import '../../utils/text_style.dart';
import 'package:flutter/material.dart';
import 'common_space_divider_widget.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final FocusNode? focusNode;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final GestureTapCallback? onTap;
  final bool? autocorrect;
  final Function(String v)? validator;
  final bool? readOnly;
  final String? labelText;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;
  final String? obscuringCharacter;
  final int? maxLine;
  final int? length;

  const CommonTextField({
    super.key,
    this.controller,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.onChanged,
    this.obscuringCharacter,
    this.onTap,
    this.validator,
    this.labelText,
    this.hintText,
    this.prefix,
    this.suffix,
    this.focusNode,
    this.maxLine,
    this.length,
    this.onSaved, this.onFieldSubmitted,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final TextAlign textAlign = TextAlign.start;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
    setState(() {});
  }

  String err = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.labelText == ''
            ? verticalSpace(0)
            : Text(
                widget.labelText!,
                style: pMedium14,
              ),
        widget.labelText == '' ? verticalSpace(0) : verticalSpace(8),
        SizedBox(
          height: widget.maxLine != 1
              ? null
              : err == ''
                  ? 45
                  : 50,
          child: Center(
            child: TextFormField(
              controller: widget.controller,
              cursorColor: AppColor.cHintFont,
              autofocus: widget.autofocus ?? false,
              focusNode: _focus,
              readOnly: widget.readOnly ?? false,
              validator: (v) {
                setState(() {
                  err = widget.validator!(v!);
                });
                print("======= $err");
                if (err == '') {
                  return null;
                } else {
                  return err;
                }
              },
              onChanged: widget.onChanged,
              onSaved: widget.onSaved,
              onFieldSubmitted:widget.onFieldSubmitted ,
              onTap: widget.onTap,
              obscureText: widget.obscureText ?? false,
              obscuringCharacter: widget.obscuringCharacter ?? ' ',
              keyboardType: widget.keyboardType,
              style: pRegular14.copyWith(fontSize: 13),
              maxLines: widget.maxLine ?? 1,
              maxLength: widget.length,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                fillColor: AppColor.cTextField,
                filled: true,
                hintText: widget.hintText,
                hintStyle: pRegular14.copyWith(color: AppColor.cHintText, fontSize: 13),
                errorStyle: TextStyle(
                  height: 0,
                  fontSize: 0,
                  decorationThickness: 0,
                ),
                counterText: '',
                counterStyle: TextStyle(fontSize: 0, height: 0),
                prefixIcon: widget.prefix,
                suffixIcon: widget.suffix,
                // prefixIconConstraints: BoxConstraints(maxWidth: 55, minWidth: 54),
                suffixIconConstraints: BoxConstraints(maxWidth: 45, minWidth: 42),
                contentPadding: EdgeInsets.only(bottom: 8, left: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.cBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.cBorder),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.cRedText, width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.cBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.themeGreenColor, width: 1),
                ),
              ),
            ),
          ),
        ),
        err == '' ? SizedBox() : Text(err, style: pMedium12.copyWith(color: AppColor.cRedText)),
      ],
    );
  }
}
