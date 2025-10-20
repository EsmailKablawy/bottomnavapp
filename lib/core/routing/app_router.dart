import 'package:bottomnavapp/feature/fav/screen/fav_screen.dart';
import 'package:bottomnavapp/feature/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/home/screen/home_screen.dart';
import '../../feature/main_screen/cubit/main_cubit.dart';
import '../../feature/splash_screen.dart';
import '../../feature/main_screen/ui/screen/main_screen.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      //splash
      case AppRoute.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      //
      case AppRoute.mainScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
            create: (context) => getIt<MainCubit>(),
            child: const MainScreen(),
          ),

          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}

final screens = [HomeScreen(), FavScreen(), ProfileScreen(), Container()];
