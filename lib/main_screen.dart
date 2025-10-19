import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/widget/slide_enimation_widget.dart';
import 'feature/main/widget/bottom_nav_bar_widget.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: currentIndex, children: screens),
          PositionedDirectional(
            bottom: 5.w,
            start: 0,
            end: 0,
            child: SlideEnimationWidget(index: 0, child: BottomNavBarWidget()),
          ),
        ],
      ),
    );
  }

  final screens = [
    Container(color: Colors.green),
    Container(color: Colors.blue),
    Container(color: Colors.red),
  ];
  // final screens = [HomeScreen(), FavScreen(), ProfileScreen(), Container()];
}
