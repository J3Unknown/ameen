import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/BaseComponent.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/values_manager.dart';
import 'package:flutter/material.dart';

class SahlReuestScreen extends StatefulWidget {
  const SahlReuestScreen({super.key});

  @override
  State<SahlReuestScreen> createState() => _SahlReuestScreenState();
}

class _SahlReuestScreenState extends State<SahlReuestScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _gadaController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translate(StringsManager.sahlRequest), style: Theme.of(context).textTheme.headlineSmall,)
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPaddings.p20),
        child: Column(
          children: [
            DefaultTextInputField(
              controller: _nameController,
              hint: StringsManager.name,
              keyboardType: TextInputType.name,
              isRequired: true,
              validator: (value){
                if(value == null || value.isEmpty){
                  return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                }
                return null;
              },
            ),
            SizedBox(height: AppSizesDouble.s20,),
            DefaultTextInputField(
              controller: _phoneController,
              hint: StringsManager.phoneNumber,
              keyboardType: TextInputType.phone,
              maxLength: 8,
              isRequired: true,
              validator: (value){
                if(value == null || value.isEmpty){
                  return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                } else if(value.length < 8){
                  return AppLocalizations.translate(StringsManager.phoneNumberRangeError);
                }
                return null;
              },
            ),
            SizedBox(height: AppSizesDouble.s10,),
            Row(
              children: [
                Expanded(
                  child: DefaultTextInputField(
                    controller: _gadaController,
                    hint: 'Gada',
                    isRequired: true,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: AppSizesDouble.s15,),
                Expanded(
                  child: DefaultTextInputField(
                    controller: _streetController,
                    hint: StringsManager.street,
                    isRequired: true,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizesDouble.s20,),
            Row(
              children: [
                Expanded(
                  child: DefaultTextInputField(
                    controller: _buildingController,
                    hint: StringsManager.building,
                    isRequired: true,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: AppSizesDouble.s15,),
                Expanded(
                  child: DefaultTextInputField(
                    controller: _floorController,
                    hint: StringsManager.floor,
                    isRequired: true,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizesDouble.s20,),
            DefaultTextInputField(
              controller: _landmarkController,
              hint: StringsManager.landmark,
              isRequired: true,
              validator: (value){
                if(value == null || value.isEmpty){
                  return AppLocalizations.translate(StringsManager.emptyFieldMessage);
                }
                return null;
              },
            ),
            SizedBox(height: AppSizesDouble.s20,),
            DefaultButton(title: StringsManager.next, onPressed: () => Navigator.push(context, RoutesGenerator.getRoute(RouteSettings(name: Routes.payment))))
          ],
        ),
      ),
    );
  }
}
