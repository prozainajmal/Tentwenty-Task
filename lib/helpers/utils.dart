import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'dart:math' as math;

import 'package:tentwenty_test/helpers/app_colors.dart';

Logger logger = Logger();

RegExp mobileRegExp = RegExp(r'^\+\d{1,3}(?!0)\d{7,12}$');

mixin AppUtils {
  void showProgress() async {
    await 0.delay();

    Get.dialog(
        Center(
          child: Container(
            decoration: BoxDecoration(color: Theme.of(Get.context!).cardColor, shape: BoxShape.circle, boxShadow: const [
              BoxShadow(blurRadius: 10, spreadRadius: 1, color: primaryColor),
            ]),
            child: const DualCircularProgressIndicator().paddingAll(10),
          ),
        ),
        // },
        barrierDismissible: false);
  }

  void stopProgress() {
    if (Get.isDialogOpen!) Get.back();
  }
}

class DualCircularProgressIndicator extends StatefulWidget {
  const DualCircularProgressIndicator({super.key});

  @override
  State<StatefulWidget> createState() => _DualCircularProgressIndicatorState();
}

class _DualCircularProgressIndicatorState extends State<DualCircularProgressIndicator> with TickerProviderStateMixin {
  late AnimationController controllerOuter;
  late AnimationController controllerInner;

  @override
  void initState() {
    super.initState();
    controllerOuter = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    controllerInner = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    controllerOuter.dispose();
    controllerInner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AnimatedBuilder(
          animation: controllerInner,
          builder: (context, child) {
            return Transform.rotate(
              angle: -(controllerInner.value * 2.0 * math.pi),
              child: const SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: controllerOuter,
          builder: (context, child) {
            return Transform.rotate(
              angle: controllerOuter.value * 2.0 * math.pi,
              child: const SizedBox(
                width: 35,
                height: 35,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
