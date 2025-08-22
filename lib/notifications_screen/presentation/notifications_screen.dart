import 'package:flutter/material.dart';

import '../../utill/local/localization/app_localization.dart';
import '../../utill/shared/strings_manager.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translate(StringsManager.notifications), style: Theme.of(context).textTheme.headlineSmall,),
      ),
    );
  }
}
