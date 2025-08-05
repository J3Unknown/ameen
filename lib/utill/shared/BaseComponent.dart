import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/local/shared_preferences.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../home_layout/cubit/main_cubit.dart';
import 'assets_manager.dart';
import 'colors_manager.dart';
import 'icons_manager.dart';

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
          child: Text('${AppLocalizations.translate(widget.title??' ')} ${widget.isRequired?'*':''}', style: Theme.of(context).textTheme.labelMedium),
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
            hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.DARK_GREY),
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
    this.borderColor = ColorsManager.RED,
    this.isInfiniteWidth = true,
    this.width = double.infinity
  });
  final VoidCallback onPressed;
  final bool isLoading;
  final double height;
  final double width;
  final bool hasBorder;
  final double borderRadius;
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final bool isInfiniteWidth;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
        height: widget.height,
        child: !widget.isLoading?ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              side: widget.hasBorder?BorderSide(color: widget.borderColor):BorderSide(color: ColorsManager.TRANSPARENT)
            )
          ),
          onPressed: widget.onPressed,
          child: FittedBox(child: Text(AppLocalizations.translate(widget.title), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: widget.foregroundColor),))
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

class DefaultRadioTile extends StatelessWidget {
  const DefaultRadioTile({super.key, this.borderRadius = 35, this.icon, required this.title, required this.value, required this.groupValue, required this.onChanged});
  final ValueChanged onChanged;
  final dynamic groupValue;
  final dynamic value;
  final String title;
  final String? icon;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.WHITE,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: ColorsManager.BLACK)
      ),
      padding: EdgeInsets.symmetric(vertical: AppPaddings.p10, horizontal: AppPaddings.p15),
      child: Row(
        children: [
          if(icon != null)
          SvgPicture.asset(icon!, fit: BoxFit.contain, width: AppSizesDouble.s35,),
          if(icon != null)
          SizedBox(width: AppSizesDouble.s10,),
          Text(title, style: Theme.of(context).textTheme.labelLarge,),
          Spacer(),
          Radio.adaptive(
            value: value,
            groupValue: groupValue,
            activeColor: ColorsManager.PRIMARY_COLOR,
            onChanged: onChanged
          ),
        ],
      ),
    );
  }
}

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key, required this.cubit});

  final dynamic cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.BLACK, width: 2),
        borderRadius: BorderRadius.circular(35),
      ),
      child: BottomNavigationBar(
        currentIndex: cubit.screenIndex,
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset(AssetsManager.home, colorFilter: ColorFilter.mode(getColor(AppSizes.s0, cubit.screenIndex), BlendMode.srcIn),), label: StringsManager.home,),
          if(!AppConstants.isRepresentativeAuthenticated)BottomNavigationBarItem(icon: SvgPicture.asset(AssetsManager.orders, colorFilter: ColorFilter.mode(getColor(AppSizes.s1, cubit.screenIndex), BlendMode.srcIn)), label: StringsManager.orders,),
          if(!AppConstants.isRepresentativeAuthenticated)BottomNavigationBarItem(icon: SvgPicture.asset(AssetsManager.wallet, colorFilter: ColorFilter.mode(getColor(AppSizes.s2, cubit.screenIndex), BlendMode.srcIn)), label: StringsManager.wallet,),
          BottomNavigationBarItem(icon: SvgPicture.asset(AssetsManager.more, colorFilter: ColorFilter.mode(getColor(AppSizes.s3, cubit.screenIndex), BlendMode.srcIn)), label: StringsManager.more,),
        ],
        backgroundColor: ColorsManager.TRANSPARENT,
        elevation: AppSizesDouble.s0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsManager.BLACK,
        onTap: (index){
          cubit.changeBottomNavBarIndex(index);
        },
        selectedIconTheme: IconThemeData(color: ColorsManager.BLACK),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      )
    );
  }

  Color getColor(int index, int cubitIndex){
    return index == cubitIndex? ColorsManager.BLACK:ColorsManager.DARK_GREY;
  }
}

class DefaultDropDownMenu extends StatefulWidget {
  const DefaultDropDownMenu({super.key, this.title, required this.value, required this.hint, required this.items, required this.onChanged});
  final dynamic value;
  final String hint;
  final String? title;
  final List<dynamic> items;
  final ValueChanged onChanged;

  @override
  State<DefaultDropDownMenu> createState() => _DefaultDropDownMenuState();
}

class _DefaultDropDownMenuState extends State<DefaultDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.title != null)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPaddings.p20),
          child: FittedBox(child: Text(AppLocalizations.translate(widget.title!), style: Theme.of(context).textTheme.labelMedium,)),
        ),
        Container(
          height: AppSizesDouble.s70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizesDouble.s35),
            border: Border.all(color: ColorsManager.BLACK)
          ),
          padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
          child: DropdownButton(
            value: widget.value,
            dropdownColor: ColorsManager.WHITE,
            elevation: 0,
            underline: SizedBox(),
            hint: Text(AppLocalizations.translate(widget.hint), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: ColorsManager.DARK_GREY)),
            isExpanded: true,
            items: widget.items.map((e) => DropdownMenuItem(value: e['title'],child: Text(e['title']??'', style: Theme.of(context).textTheme.labelLarge,),)).toList(),
            onChanged: (value) => widget.onChanged(value),
          ),
        ),
      ],
    );
  }
}

class DefaultRoundedIconButton extends StatefulWidget {
  const DefaultRoundedIconButton({super.key, this.iconColored = true, this.svgIcon, this.isSvg = false, this.icon, this.iconColor = ColorsManager.BLACK, this.borderColor = ColorsManager.BLACK, this.filled = false, this.backgroundColor = ColorsManager.WHITE, required this.onPressed, this.hasBorder = true});
  final Color borderColor;
  final Color backgroundColor;
  final Color iconColor;
  final IconData? icon;
  final String? svgIcon;
  final VoidCallback onPressed;
  final bool hasBorder;
  final bool filled;
  final bool iconColored;
  final bool isSvg;
  @override
  State<DefaultRoundedIconButton> createState() => _DefaultRoundedIconButtonState();
}

class _DefaultRoundedIconButtonState extends State<DefaultRoundedIconButton> {
  @override
  Widget build(BuildContext context) {
    if(widget.isSvg) assert(widget.svgIcon != null);
    if(!widget.isSvg) assert(widget.icon != null);

    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: widget.filled?widget.backgroundColor:null,
        shape: widget.hasBorder?RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizesDouble.s40),
          side: BorderSide(color: widget.borderColor)
        ):null
      ),
      onPressed: widget.onPressed,
      icon: !widget.isSvg?Icon(widget.icon, color: widget.iconColored?widget.iconColor:null,):SvgPicture.asset(widget.svgIcon!, colorFilter: widget.iconColored?ColorFilter.mode(widget.iconColor, BlendMode.srcIn):null,)
    );
  }
}


void showSnackBar(context, String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
    snackBarAnimationStyle: AnimationStyle(reverseCurve: Curves.fastEaseInToSlowEaseOut, curve: Curves.fastEaseInToSlowEaseOut),
  );
}


class DefaultItemCard extends StatefulWidget {
  const DefaultItemCard({super.key, required this.index});
  final int index;

  @override
  State<DefaultItemCard> createState() => _DefaultItemCardState();
}

class _DefaultItemCardState extends State<DefaultItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPaddings.p10),
      decoration: BoxDecoration(
        color: ColorsManager.GREY1,
        borderRadius: BorderRadius.circular(AppSizesDouble.s15)
      ),
      width: double.infinity,
      height: AppSizesDouble.s150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(AssetsManager.itemIcon),
          SizedBox(width: AppSizesDouble.s5,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('This is a very big title which has to reach the end of the item', style: Theme.of(context).textTheme.labelLarge, maxLines: 2, overflow: TextOverflow.ellipsis,),
                SizedBox(height: AppSizesDouble.s10,),
                Text('${AppLocalizations.translate(StringsManager.deliveryDate)} ${DateFormat('EEE dd, MMM, yyyy').format(DateTime.now())}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)), //TODO: change the date into today's date
                Text('${AppLocalizations.translate(StringsManager.orderFee)} 12 ${AppLocalizations.translate(StringsManager.kwd)}', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                Row(
                  children: [
                    Text(AppLocalizations.translate(StringsManager.status), style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.DARK_GREY)),
                    Text(' Received', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorsManager.YELLOW)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: AppSizesDouble.s5,),
          getIcon(widget.index % 2 == 0? 'Received':widget.index % 3 == 0?'Delivered':'Out for Delivery')
        ],
      ),
    );
  }

  DefaultRoundedIconButton getIcon(String status){
    if(status == 'Received') {
      return DefaultRoundedIconButton(icon: IconsManager.close, hasBorder: false, filled: true, backgroundColor: ColorsManager.RED, iconColor: ColorsManager.WHITE, onPressed: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.orderCancellation))));
    } else if(status == 'Delivered'){
      return DefaultRoundedIconButton(isSvg: true, svgIcon: AssetsManager.deliveredIcon, hasBorder: false, onPressed: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.orderReporting))));
    } else if(status == 'Delivery Guy'){
      return DefaultRoundedIconButton(icon: IconsManager.rightArrow, hasBorder: true, onPressed: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.orderReporting)))); //TODO: change this to delivery Guy Details Screen
    }
    return DefaultRoundedIconButton(icon: IconsManager.location, filled: true, backgroundColor: ColorsManager.GREEN, hasBorder: false, iconColor: ColorsManager.WHITE, onPressed: (){});
  }
}

void navigateToAuth(context) async{
  await CacheHelper.saveData(key: KeysManager.isAuthenticated, value: false);
  await CacheHelper.saveData(key: KeysManager.isGuest, value: false);
  AppConstants.isAuthenticated = false;
  AppConstants.isGuest = false;
  Navigator.pushAndRemoveUntil(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.login)), (route) => false);
}