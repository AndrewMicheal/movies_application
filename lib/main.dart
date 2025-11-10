import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/features/on_boarding_screen/prestentation/screen/on_boarding_screen.dart';
import 'package:movies/l10n/app_localizations.dart';
import 'package:movies/core/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
      designSize: const Size(
        430,
        932,
      ), 
      minTextAdapt: true, 
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: "Movies",
          debugShowCheckedModeBanner: false,
          locale: const Locale("ar"),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
           routes: {
            AppRoutes.onBoardingScreen: (context) => const OnBoardingScreen(),
          },
          initialRoute: AppRoutes.onBoardingScreen ,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: widget!,
            );
          },
        );
         
      },
    );
  }
}