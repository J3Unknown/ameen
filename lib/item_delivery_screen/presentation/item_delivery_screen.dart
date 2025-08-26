import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/home_layout/cubit/main_cubit_states.dart';
import 'package:ameen/item_delivery_screen/data/add_address_requests_model/add_destination_address_request.dart';
import 'package:ameen/item_delivery_screen/data/add_address_requests_model/add_origin_address_request.dart';
import 'package:ameen/payment/data/payment_result_arguments.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/alerts.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  int? selectedCategory;
  int? originId;
  int? destinationId;
  double? originLat;
  double? originLong;
  double? destinationLong;
  double? destinationLat;

  @override
  void initState() {
    super.initState();
    if(context.read<MainCubit>().categoriesDataModel == null){
      context.read<MainCubit>().getCategories();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (popped, _){
        if(popped){
          MainCubit.get(context).destinationAddress = null;
          MainCubit.get(context).originAddress = null;
          MainCubit.get(context).adImagesList = [];
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.translate(StringsManager.itemDelivery), style: Theme.of(context).textTheme.headlineSmall,),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(AppPaddings.p20),
          child: BlocConsumer<MainCubit, MainCubitStates>(
            listener: (context, state) {
              if(state is MainCreateDeliveryItemsSuccessState){
                Navigator.pushReplacement(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.paymentResult, arguments: PaymentResultArguments(true, orderNo: MainCubit.get(context).createdItem!.id.toString()))));
              }
            },
            builder: (context, state) => Form(
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
                  ConditionalBuilder(
                    condition: MainCubit.get(context).categoriesDataModel != null,
                    fallback: (context) => Center(child: CircularProgressIndicator(),) ,
                    builder: (context) => FormField(
                      initialValue: selectedCategory,
                      validator: (value){
                        if(value == null){
                          return AppLocalizations.translate(StringsManager.requiredField);
                        }
                        return null;
                      },
                      builder: (state) => InputDecorator(
                        decoration: InputDecoration(
                          errorText: state.errorText,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                        child: DefaultDropDownMenu(
                          value: selectedCategory,
                          hint: StringsManager.category,
                          items: MainCubit.get(context).categoriesDataModel!.category,
                          onChanged: (value){
                            setState(() {
                              selectedCategory = value;
                            });
                          }
                        ),
                      ),
                    ),
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
                      if(value == null || value.isEmpty){
                        return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSizesDouble.s15,),
                  if(MainCubit.get(context).originAddress == null)
                  FormField(
                    initialValue: MainCubit.get(context).originAddress,
                    validator: (value){
                      if(value == null){
                        return AppLocalizations.translate(StringsManager.requiredField);
                      }
                      return null;
                    },
                    builder: (state) => InputDecorator(
                      decoration: InputDecoration(
                        errorText: state.errorText,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DottedBorder(
                              color: state.hasError? ColorsManager.RED:ColorsManager.DARK_GREY,
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
                                    DefaultRoundedIconButton(icon: IconsManager.addIcon, onPressed: () async{
                                      final String? result = await showDialog(context: context, builder: (context) => AddAddressAlert(title: StringsManager.addOriginAddress, requestModel: AddOriginAddressRequest(),));
                                      if(result != null){
                                        originLat = double.parse(result.split(',').first);
                                        originLong = double.parse(result.split(',').last);
                                      }
                                    })
                                  ],
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(MainCubit.get(context).originAddress != null)
                  Container(
                    padding: EdgeInsets.all(AppPaddings.p10),
                    height: AppSizesDouble.s60,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizesDouble.s8),
                      border: Border.all(color: ColorsManager.PRIMARY_COLOR),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text('${MainCubit.get(context).originAddress!.city!.name} - ${MainCubit.get(context).originAddress!.region!.name} - ${MainCubit.get(context).originAddress!.blockNo} - ${MainCubit.get(context).originAddress!.street} - ${MainCubit.get(context).originAddress!.buildingNo} - ${MainCubit.get(context).originAddress!.landmark}', maxLines: 1, overflow: TextOverflow.ellipsis,)),
                        DefaultRoundedIconButton(
                          icon: IconsManager.edit,
                          onPressed: () async {
                            final String? result = await showDialog(context: context, builder: (context) => AddAddressAlert(title: StringsManager.originAddress, requestModel: AddOriginAddressRequest(lat: destinationLat, long: destinationLong), editingAddress: MainCubit.get(context).originAddress,));
                            if(result != null){
                              originLat = double.parse(result.split(',').first);
                              originLong = double.parse(result.split(',').last);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizesDouble.s15,),
                  if(MainCubit.get(context).destinationAddress == null)
                  FormField(
                    initialValue: MainCubit.get(context).destinationAddress,
                    validator: (value){
                      if(value == null){
                        return AppLocalizations.translate(StringsManager.requiredField);
                      }
                      return null;
                    },
                    builder: (state) => InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorText: state.errorText,
                        border: InputBorder.none,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DottedBorder(
                              color: state.hasError? ColorsManager.RED:ColorsManager.DARK_GREY,
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
                                    DefaultRoundedIconButton(icon: IconsManager.addIcon, onPressed: () async{
                                      final String? result = await showDialog(context: context, builder: (context) => AddAddressAlert(title: StringsManager.addDestinationAddress, requestModel: AddDestinationAddressRequest(),));
                                      if(result != null){
                                        destinationLat = double.parse(result.split(',').first);
                                        destinationLong = double.parse(result.split(',').last);
                                      }
                                    })
                                  ],
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(MainCubit.get(context).destinationAddress != null)
                  Container(
                    padding: EdgeInsets.all(AppPaddings.p10),
                    height: AppSizesDouble.s60,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizesDouble.s8),
                      border: Border.all(color: ColorsManager.PRIMARY_COLOR),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text('${MainCubit.get(context).destinationAddress!.city!.name} - ${MainCubit.get(context).destinationAddress!.region!.name} - ${MainCubit.get(context).destinationAddress!.blockNo} - ${MainCubit.get(context).destinationAddress!.street} - ${MainCubit.get(context).destinationAddress!.buildingNo} - ${MainCubit.get(context).destinationAddress!.landmark}', maxLines: 1, overflow: TextOverflow.ellipsis,)),
                        DefaultRoundedIconButton(
                          icon: IconsManager.edit,
                          onPressed: () async{
                            final result = await showDialog(context: context, builder: (context) => AddAddressAlert(title: StringsManager.destination, requestModel: AddDestinationAddressRequest(lat: destinationLat, long: destinationLong), editingAddress: MainCubit.get(context).destinationAddress,));
                            if(result != null){
                              destinationLat = double.parse(result.split(',').first);
                              destinationLong = double.parse(result.split(',').last);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizesDouble.s15,),
                  FormField(
                    initialValue: MainCubit.get(context).adImagesList,
                    validator: (value){
                      if(value == null || MainCubit.get(context).adImagesList.isEmpty){
                        return AppLocalizations.translate(StringsManager.requiredField);
                      }
                      return null;
                    },
                    builder: (state) => InputDecorator(
                      decoration: InputDecoration(
                        errorText: state.errorText,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                      child: DottedBorder(
                        color: state.hasError? ColorsManager.RED:ColorsManager.DARK_GREY,
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
                              if(MainCubit.get(context).adImagesList.isEmpty)
                              Column(
                                children: [
                                  SvgPicture.asset(AssetsManager.addImage),
                                  Text(AppLocalizations.translate(StringsManager.imagePickingWarning), textAlign: TextAlign.center, style: TextStyle(color: ColorsManager.DARK_GREY),),
                                ],
                              ),
                              SizedBox(height: AppSizesDouble.s15,),
                              if(MainCubit.get(context).adImagesList.isNotEmpty)
                              Column(
                                children: [
                                  Wrap(
                                    runSpacing: AppSizesDouble.s8,
                                    spacing: AppSizesDouble.s20,
                                    alignment: WrapAlignment.center,
                                    children: List.generate(
                                      MainCubit.get(context).adImagesList.length,
                                      (index) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            MainCubit.get(context).adImagesList.removeAt(index);
                                          });
                                        },
                                        child: Container(
                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppSizesDouble.s8),
                                            border: Border.all(color: ColorsManager.PRIMARY_COLOR)
                                          ),
                                          child: Image.file(MainCubit.get(context).adImagesList[index], fit: BoxFit.cover, height: AppSizesDouble.s70, width: AppSizesDouble.s70,),
                                        ),
                                      )
                                    ),
                                  ),
                                  SizedBox(height: AppSizesDouble.s10,),
                                  Text(AppLocalizations.translate(StringsManager.tapToDelete), textAlign: TextAlign.center, style: TextStyle(color: ColorsManager.DARK_GREY),),
                                ],
                              ),
                              if(MainCubit.get(context).adImagesList.length < 5)
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
                    ),
                  ),
                  SizedBox(height: AppSizesDouble.s15,),
                  DefaultTextInputField(
                    isRequired: selectedCategory == -1? true:false,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                      }
                      return null;
                    },
                    controller: _notesController,
                    hint: StringsManager.notes,
                    maxLines: 5,
                  ),
                  SizedBox(height: AppSizesDouble.s20,),
                  DefaultButton(
                    title: StringsManager.confirm,
                    isLoading: state is MainCreateDeliveryItemsLoadingState,
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        //Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.otp, arguments: PaymentScreenOtp())));
                        MainCubit.get(context).createItemDelivery(
                          title: _titleController.text,
                          categoryId: selectedCategory!,
                          date: !isLater?DateFormat(StringsManager.dateFormat).format(DateTime.now()):_dateController.text,
                          note: _notesController.text,
                          destinationAddressLat: destinationLat!,
                          originAddressLat: destinationLong!,
                          destinationAddressLong: destinationLong!,
                          originAddressLong: destinationLong!,
                          destinationAddressId: MainCubit.get(context).destinationAddress!.id!,
                          originAddressId: MainCubit.get(context).originAddress!.id!,
                        );
                      }
                    }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
