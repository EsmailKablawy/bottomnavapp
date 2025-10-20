import 'package:bottomnavapp/core/helpers/extensions.dart';
import 'package:bottomnavapp/core/helpers/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/main_cubit.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  double alignmentX = -1;
  int selectedIndex = 0;
  bool dragging = false;

  final List<double> tabPositions = [-1, 0, 1];
  final List<String> tabNames = ["Home", "Contact", "Profile"];

  void _updateSelectedIndex(double value) {
    if (value < -0.33) {
      selectedIndex = 0;
      alignmentX = -1;
    } else if (value > 0.33) {
      selectedIndex = 2;
      alignmentX = 1;
    } else {
      selectedIndex = 1;
      alignmentX = 0;
    }
  }

  Color _textColorForIndex(int index) {
    double distance = (alignmentX - tabPositions[index]).abs();
    double t = (1 - distance).clamp(0.0, 1.0);
    return Color.lerp(Colors.black, Colors.white, t)!;
  }

  @override
  Widget build(BuildContext context) {
    double width = (context.displayWidth / 1) - 40.w;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
      width: context.displayWidth,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onPanStart: (_) {
                setState(() {
                  dragging = true;
                });
              },
              onPanUpdate: (details) {
                double relativeX = (details.localPosition.dx / width) * 2 - 1;
                setState(() {
                  alignmentX = relativeX.clamp(-1.0, 1.0);
                });
              },
              onPanEnd: (_) {
                setState(() {
                  dragging = false;
                  _updateSelectedIndex(alignmentX);
                });

                print("Stopped at: ${tabNames[selectedIndex]}");
                context.read<MainCubit>().currentIndex.value = selectedIndex;
              },

              child: Container(
                height: 50.w,
                width: width,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2.w,
                      blurRadius: 5.w,
                      offset: Offset(0, 3.w),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: dragging
                          ? Duration.zero
                          : const Duration(milliseconds: 300),
                      alignment: Alignment(alignmentX, 0),
                      curve: Curves.easeInOut,
                      child: Container(
                        width: width / 3.7,
                        height: 50.w,

                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30.w),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _buildTabButton(
                          index: 0,
                          icon: CupertinoIcons.home,
                          text: "Home",
                        ),
                        _buildTabButton(
                          icon: CupertinoIcons.heart_fill,
                          index: 1,
                          text: "Fav",
                        ),
                        _buildTabButton(
                          icon: CupertinoIcons.profile_circled,
                          index: 2,
                          text: "Profile",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          horizontalSpace(10.w),
          Container(
            height: 50.w,
            width: 50.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.search, color: Colors.black, size: 20.w),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required int index,
    required String text,
    required IconData icon,
  }) {
    double width = (MediaQuery.of(context).size.width / 4.8);

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
          alignmentX = index == 0
              ? -1
              : index == 1
              ? 0
              : 1;
        });
        context.read<MainCubit>().currentIndex.value = selectedIndex;
        print("Tapped on: $text");
      },
      child: Container(
        width: width,
        height: 50.w,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: _textColorForIndex(index), size: 20.w),
            verticalSpace(4),

            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: _textColorForIndex(index),
              ),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
