import 'package:ameen/splashScreen/presentation/SplashScreen.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/local/localization/localization_helper.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'languagePage/presentation/LanguagePage.dart';
import 'loginScreen/presentation/LoginScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalizations().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
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
        return MaterialApp(
          navigatorKey: navKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
           // AppLocalizations.delegate,
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
          theme: ThemeData(
            textTheme: TextTheme(labelLarge: TextStyle(fontSize: 18.sp)),
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
              child: widget!,
            );
          },
          home: LoginScreen(),
        );
      },
    );
  }


}