import 'package:ameen/auth/otp_screen/data/otp_arguments.dart';
import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/alerts.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../utill/shared/assets_manager.dart';
import '../../utill/shared/icons_manager.dart';

class ItemDeliveryScreen extends StatefulWidget {
  const ItemDeliveryScreen({super.key});

  @override
  State<ItemDeliveryScreen> createState() => _ItemDeliveryScreenState();
}

class _ItemDeliveryScreenState extends State<ItemDeliveryScreen> {
  bool isLater = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translate(StringsManager.itemDelivery), style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPaddings.p20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppConstants.screenSize(context).width / AppSizes.s6),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            isLater = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !isLater?ColorsManager.PRIMARY_COLOR:ColorsManager.WHITE,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSizesDouble.s11),
                            ),
                            side: !isLater?BorderSide(color: ColorsManager.BLACK):BorderSide()
                          ),
                        ),
                        child: Text(AppLocalizations.translate(StringsManager.now), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: !isLater?ColorsManager.WHITE:ColorsManager.BLACK),),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            isLater = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLater?ColorsManager.PRIMARY_COLOR:ColorsManager.WHITE,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(AppSizesDouble.s11),
                            ),
                            side: isLater?BorderSide(color: ColorsManager.BLACK):BorderSide()
                          ),
                        ),
                        child: Text(AppLocalizations.translate(StringsManager.later), style: Theme.of(context).textTheme.labelLarge!.copyWith(color: isLater?ColorsManager.WHITE:ColorsManager.BLACK),),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizesDouble.s10,),
              DefaultDropDownMenu(
                value: selectedCategory,
                hint: StringsManager.category,
                items: AppConstants.items,
                onChanged: (value){
                  setState(() {
                    selectedCategory = value;
                  });
                }
              ),
              SizedBox(height: AppSizesDouble.s10,),
              DefaultTextInputField(
                controller: _titleController,
                hint: StringsManager.title,
                isRequired: true,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                  }
                  return null;
                },
              ),
              if(isLater)
              SizedBox(height: AppSizesDouble.s10,),
              if(isLater)
              InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    initialDate: DateTime.now().add(Duration(days: 1))
                  ).then((value){
                    if(value != null){
                      _dateController.text = DateFormat(StringsManager.dateFormat).format(value);
                    }
                  });
                },
                child: AbsorbPointer(
                  child: DefaultTextInputField(
                    controller: _dateController,
                    keyboardType: TextInputType.none,
                    hint: StringsManager.deliveryDate,
                    isRequired: true,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                      }
                      return null;
                    },
                    suffixActivated: true,
                    suffixIconInActivated: IconsManager.date,
                    suffixIconActivated: IconsManager.date,
                  ),
                ),
              ),
              SizedBox(height: AppSizesDouble.s10,),
              DefaultTextInputField(
                controller: _descriptionController,
                hint: StringsManager.itemDescription,
                isRequired: true,
                maxLines: 5,
                validator: (value){
                  if(selectedCategory == 'other' && (value == null || value.isEmpty)){
                    return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSizesDouble.s15,),
              Row(
                children: [
                  Expanded(
                    child: DottedBorder(
                      color: ColorsManager.DARK_GREY,
                      padding: EdgeInsets.symmetric(horizontal: AppPaddings.p5, vertical: AppPaddings.p10),
                      radius: Radius.circular(AppSizesDouble.s8),
                      borderType: BorderType.RRect,
                      dashPattern: [AppSizesDouble.s8, AppSizesDouble.s4],
                      strokeWidth: AppSizesDouble.s2,
                      child: Container(
                        height: AppSizesDouble.s50,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
                        child: Row(
                          children: [
                            Text(AppLocalizations.translate(StringsManager.addOriginAddress), style: Theme.of(context).textTheme.labelMedium),
                            Spacer(),
                            DefaultRoundedIconButton(icon: IconsManager.addIcon, onPressed: () => showDialog(context: context, builder: (context) => AddAddressAlert(title: StringsManager.addOriginAddress)))
                          ],
                        ),
                      )
                    ),
                  ),
                  SizedBox(width: AppSizesDouble.s15,),
                  DefaultRoundedIconButton(icon: IconsManager.location, iconColor: ColorsManager.WHITE, onPressed: () => showDialog(context: context, builder: (context) => AddAddressAlert(title: StringsManager.addOriginAddress)), hasBorder: false, filled: true, backgroundColor: ColorsManager.GREEN,)
                ],
              ),
              SizedBox(height: AppSizesDouble.s15,),
              Row(
                children: [
                  Expanded(
                    child: DottedBorder(
                      color: ColorsManager.DARK_GREY,
                      padding: EdgeInsets.symmetric(horizontal: AppPaddings.p5, vertical: AppPaddings.p10),
                      radius: Radius.circular(AppSizesDouble.s8),
                      borderType: BorderType.RRect,
                      dashPattern: [AppSizesDouble.s8, AppSizesDouble.s4],
                      strokeWidth: AppSizesDouble.s2,
                      child: Container(
                        height: AppSizesDouble.s50,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: AppPaddings.p10),
                        child: Row(
                          children: [
                            Expanded(child: Text(AppLocalizations.translate(StringsManager.addDestinationAddress), style: Theme.of(context).textTheme.labelMedium)),
                            DefaultRoundedIconButton(icon: IconsManager.addIcon, onPressed: () => showDialog(context: context, builder: (context) => AddAddressAlert(title: StringsManager.addDestinationAddress)))
                          ],
                        ),
                      )
                    ),
                  ),
                  SizedBox(width: AppSizesDouble.s15,),
                  DefaultRoundedIconButton(icon: IconsManager.location, iconColor: ColorsManager.WHITE, onPressed: () => showDialog(context: context, builder: (context) => AddAddressAlert(title: StringsManager.addDestinationAddress)), hasBorder: false, filled: true, backgroundColor: ColorsManager.RED,)
                ],
              ),
              SizedBox(height: AppSizesDouble.s15,),
              DottedBorder(
                color: ColorsManager.DARK_GREY,
                padding: EdgeInsets.symmetric(horizontal: AppPaddings.p5, vertical: AppPaddings.p10),
                radius: Radius.circular(AppSizesDouble.s8),
                borderType: BorderType.RRect,
                dashPattern: [AppSizesDouble.s8, AppSizesDouble.s4],
                strokeWidth: AppSizesDouble.s2,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SvgPicture.asset(AssetsManager.addImage),
                      Text(AppLocalizations.translate(StringsManager.imagePickingWarning), textAlign: TextAlign.center, style: TextStyle(color: ColorsManager.DARK_GREY),),
                      SizedBox(height: AppSizesDouble.s15,),
                      ElevatedButton.icon(
                        icon: Icon(IconsManager.addIcon, color: ColorsManager.WHITE,),
                        onPressed: () => MainCubit.get(context).pickItemDeliveryImages(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizesDouble.s8)
                          )
                        ),
                        label: Text(AppLocalizations.translate(StringsManager.add), style: TextStyle(color: ColorsManager.WHITE),),
                      )
                    ],
                  ),
                )
              ),
              SizedBox(height: AppSizesDouble.s15,),
              DefaultTextInputField(
                controller: _notesController,
                hint: StringsManager.notes,
                maxLines: 5,
              ),
              SizedBox(height: AppSizesDouble.s20,),
              DefaultButton(
                title: StringsManager.confirm,
                onPressed: (){
                  if(!_formKey.currentState!.validate()){
                    Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.otp, arguments: OtpArguments(false))));
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
