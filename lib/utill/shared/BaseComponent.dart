import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors_manager.dart';

class DefaultTextInputField extends StatefulWidget {
  const DefaultTextInputField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.hint,
    this.onSuffixPressed,
    this.suffixActivated = true,
    this.suffixIconActivated,
    this.suffixIconInActivated
  });
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hint;
  final VoidCallback? onSuffixPressed;
  final bool suffixActivated;
  final IconData? suffixIconActivated;
  final IconData? suffixIconInActivated;
  @override
  State<DefaultTextInputField> createState() => _DefaultTextInputFieldState();
}

class _DefaultTextInputFieldState extends State<DefaultTextInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizesDouble.s60,
      width: double.infinity,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType??TextInputType.text,
        obscureText: widget.keyboardType == TextInputType.visiblePassword?widget.suffixActivated:false,
        cursorColor: ColorsManager.PRIMARY_COLOR,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsManager.BLACK),
                borderRadius: BorderRadius.circular(AppSizesDouble.s20)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsManager.RED),
                borderRadius: BorderRadius.circular(AppSizesDouble.s20)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsManager.PRIMARY_COLOR),
                borderRadius: BorderRadius.circular(AppSizesDouble.s20)
            ),
            hintText: widget.hint,
            suffixIcon: widget.suffixIconActivated != null?IconButton(
                onPressed: widget.onSuffixPressed,
                icon: Icon(widget.suffixActivated?widget.suffixIconActivated:widget.suffixIconInActivated, color: widget.suffixActivated?ColorsManager.PRIMARY_COLOR:ColorsManager.DARK_GREY,)
            ):null
        ),
      ),
    );
  }
}

