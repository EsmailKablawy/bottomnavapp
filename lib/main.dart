import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart';
import 'core/thems/thems.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        child: MaterialApp(
          title: 'Wadai',
          debugShowCheckedModeBanner: false,
          theme: themsApp.light,

          locale: const Locale('en'),
          // context.locale,
          localeResolutionCallback: (locale, supportedLocales) {
            return locale;
          },
          onGenerateRoute: (settings) {
            final appRouter = AppRouter();
            return appRouter.generateRoute(settings);
          },
        ),
      ),
    );
  }
}
