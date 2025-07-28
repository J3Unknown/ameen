import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';

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
    this.suffixIconInActivated,
    this.validator,
    this.borderRadius = 35,
    this.title,
    this.isRequired = false,
    this.maxLines = 1,
    this.maxLength
  });
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hint;
  final VoidCallback? onSuffixPressed;
  final bool suffixActivated;
  final IconData? suffixIconActivated;
  final IconData? suffixIconInActivated;
  final String? Function(String? value)? validator;
  final double borderRadius;
  final String? title;
  final bool isRequired;
  final int? maxLines;
  final int? maxLength;

  @override
  State<DefaultTextInputField> createState() => _DefaultTextInputFieldState();
}

class _DefaultTextInputFieldState extends State<DefaultTextInputField> {
  @override
  Widget build(BuildContext context) {
    if(widget.isRequired) assert(widget.validator != null);
    if(widget.keyboardType == TextInputType.visiblePassword) assert(widget.suffixIconActivated != null && widget.suffixIconInActivated != null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.title != null)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPaddings.p20),
          child: Text('${AppLocalizations.translate(widget.title??' ')} ${widget.isRequired?'*':''}'),
        ),
        TextFormField(
          textAlignVertical: TextAlignVertical.center,
          controller: widget.controller,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType??TextInputType.text,
          obscureText: widget.keyboardType == TextInputType.visiblePassword?!widget.suffixActivated:false,
          cursorColor: ColorsManager.PRIMARY_COLOR,
          validator: widget.isRequired?(value) => widget.validator!(value):null,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsManager.BLACK),
              borderRadius: BorderRadius.circular(widget.borderRadius)
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsManager.RED),
              borderRadius: BorderRadius.circular(widget.borderRadius)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsManager.PRIMARY_COLOR),
              borderRadius: BorderRadius.circular(widget.borderRadius)
            ),
            hintText: AppLocalizations.translate(widget.hint??''),
            hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorsManager.DARK_GREY),
            prefixIcon: widget.keyboardType == TextInputType.phone?SizedBox(
              width: AppSizesDouble.s60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.translate(StringsManager.phoneCode)),
                  SizedBox(width: AppSizesDouble.s6,),
                  Container(
                    height: AppSizesDouble.s40,
                    color: ColorsManager.BLACK,
                    width: AppSizesDouble.s0_5,
                  ),
                ],
              ),
            ):null,
            suffixIcon: widget.suffixIconActivated != null?IconButton(
              onPressed: widget.onSuffixPressed,
              icon: Icon(widget.suffixActivated?widget.suffixIconActivated:widget.suffixIconInActivated, color: widget.suffixActivated?ColorsManager.PRIMARY_COLOR:ColorsManager.DARK_GREY,)
            ):null
          ),
        ),
      ],
    );
  }
}

class DefaultButton extends StatefulWidget {
  const DefaultButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.borderRadius = 35,
    this.hasBorder = false,
    this.height = 60,
    this.backgroundColor = ColorsManager.PRIMARY_COLOR,
    this.foregroundColor = ColorsManager.WHITE,
    this.borderColor = ColorsManager.RED
  });
  final VoidCallback onPressed;
  final bool isLoading;
  final double height;
  final bool hasBorder;
  final double borderRadius;
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
        height: AppSizesDouble.s60,
        child: !widget.isLoading?ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.backgroundColor,
            shape: widget.hasBorder?RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              side: BorderSide(color: widget.borderColor)
            ):null
          ),
          onPressed: widget.onPressed,
          child: Text(AppLocalizations.translate(widget.title), style: Theme.of(context).textTheme.titleLarge!.copyWith(color: widget.foregroundColor),)
        ):Center(child: CircularProgressIndicator())
    );
  }
}

class DefaultTextWithTextButton extends StatelessWidget {
  const DefaultTextWithTextButton({
    super.key,
    required this.title,
    required this.buttonTitle,
    required this.onButtonPressed,
    this.buttonColor = ColorsManager.RED,
    this.isCentered = true
  });

  final String title;
  final String buttonTitle;
  final VoidCallback onButtonPressed;
  final Color buttonColor;
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCentered? MainAxisAlignment.center:MainAxisAlignment.start,
      children: [
        Text(AppLocalizations.translate(title)),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: buttonColor
          ),
          onPressed: onButtonPressed,
          child: Text(AppLocalizations.translate(buttonTitle)),
        )
      ],
    );
  }
}

