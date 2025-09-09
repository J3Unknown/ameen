import 'dart:developer';

import 'package:ameen/auth/cubit/auth_cubit.dart';
import 'package:ameen/home_layout/cubit/main_cubit.dart';
import 'package:ameen/representitive/home_layout/cubit/representative_cubit.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/local/localization/locale_changer.dart';
import 'package:ameen/utill/local/observer.dart';
import 'package:ameen/utill/local/shared_preferences.dart';
import 'package:ameen/utill/network/dio.dart';
import 'package:ameen/utill/shared/constants_manager.dart';
import 'package:ameen/utill/shared/routes_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:ameen/utill/shared/themes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalizations().init();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MainBlocObserver();
  LocaleChanger localeChanger = LocaleChanger();
  localeChanger.initializeLocale();
  await loadLocalizations(localeChanger);
  await dotenv.load(fileName: ".env");
  _loadCaches();

  runApp(
    ChangeNotifierProvider(
      create: (context) => localeChanger,
      child: MyHomePage(localeChanger: localeChanger,)
    )
  );
}

//* Caches and Localization Initialization helper methods
Future<void> loadLocalizations(LocaleChanger localeChanger) async{
  await localeChanger.initializeLocale();
  await AppLocalizations().init();
}

void _loadCaches() async{
  AppConstants.isAuthenticated = await CacheHelper.getData(key: KeysManager.isAuthenticated)??false;
  AppConstants.isRepresentativeAuthenticated = await CacheHelper.getData(key: KeysManager.isRepresentativeAuthenticated)??false;
  AppConstants.isGuest = await CacheHelper.getData(key: KeysManager.isGuest)??false;
  AppConstants.locale = await CacheHelper.getData(key: KeysManager.locale)??'en';
  AppConstants.token = await CacheHelper.getData(key: KeysManager.token)??'';
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.localeChanger});
  final LocaleChanger localeChanger;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  static final navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ListenableBuilder(
      listenable: widget.localeChanger,
      builder: (context, _) => ScreenUtilInit(
        designSize: const Size(390, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context)=> AuthCubit()),
              BlocProvider(create: (context)=> MainCubit()..getProfile()..getHome()..getDeliveryItems()),
              BlocProvider(create: (context) => RepresentativeCubit()..getProfile()),
            ],
            child: Directionality(
              textDirection: widget.localeChanger.getLanguage == 'ar'? TextDirection.rtl:TextDirection.ltr,
              child: MaterialApp(
                navigatorKey: navKey,
                debugShowCheckedModeBanner: false,
                locale: Locale(widget.localeChanger.getLanguage),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
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
            ),
          );
        },
      ),
    );
  }


}