import 'dart:async';

import 'package:bottomnavapp/core/helpers/extensions.dart';
import 'package:bottomnavapp/core/routing/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  bool _value = true;

  @override
  void initState() {
    super.initState();

    scaleController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 1700),
        )..addStatusListener((status) async {
          if (status == AnimationStatus.completed) {
            context.pushNamedAndRemoveUntil(
              AppRoute.mainScreen,
              predicate: (route) => false,
            );

            Timer(const Duration(milliseconds: 300), () {
              scaleController.reset();
            });
          }
        });

    scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 12,
    ).animate(scaleController);

    Timer(const Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        scaleController.forward();
      });
    });
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: AnimatedOpacity(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(seconds: 6),
              opacity: _opacity,
              child: AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,

                duration: const Duration(seconds: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                height: _value ? 50 : context.displayWidth / 2,
                width: _value ? 50 : context.displayWidth / 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  ThisIsFadeRoute({required this.page, required this.route})
    : super(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => page,
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) => FadeTransition(opacity: animation, child: route),
      );
}
