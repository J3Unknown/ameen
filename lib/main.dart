import 'dart:developer';

import 'package:ameen/auth/cubit/auth_cubit.dart';
import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/local/localization/localization_helper.dart';
import 'package:ameen/utill/local/shared_preferences.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/themes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalizations().init();
  await CacheHelper.init();
  
  // await CacheHelper.saveData(key: KeysManager.isAuthenticated, value: false);
  // await CacheHelper.saveData(key: KeysManager.isGuest, value: false);
  // await CacheHelper.saveData(key: KeysManager.locale, value: 'EN');

  _loadCaches();

  runApp(const MyApp());
}

void _loadCaches() async{
  AppConstants.isAuthenticated = await CacheHelper.getData(key: KeysManager.isAuthenticated)??false;
  AppConstants.isGuest = await CacheHelper.getData(key: KeysManager.isGuest)??false;
  AppConstants.locale = await CacheHelper.getData(key: KeysManager.locale)??'EN';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyHomePageState? state = context.findAncestorStateOfType<_MyHomePageState>();
    state?.setLocale(newLocale);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  static final navKey = GlobalKey<NavigatorState>();
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (_locale == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ScreenUtilInit(
      designSize: const Size(390, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context)=> AuthCubit()),
            BlocProvider(create: (context)=> MainCubit()),
          ],
          child: MaterialApp(
            navigatorKey: navKey,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode &&
                    supportedLocale.countryCode == locale?.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            theme: lightTheme(),
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                child: widget!,
              );
            },
            onGenerateRoute: RoutesGenerator.getRoute,
            initialRoute: Routes.splashScreen,
          ),
        );
      },
    );
  }


}