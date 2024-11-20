import 'dart:developer';

import 'package:damian/views/main_screen/controller/main_screen_controller.dart';
import 'package:damian/views/main_screen/main_views/mobile_view/mobile_view.dart';
import 'package:damian/views/main_screen/main_views/tab_view/tab_view.dart';
import 'package:damian/views/main_screen/main_views/web_view/web_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainScreenController());
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          log(constraints.maxWidth.toString());
          bool isMobile = constraints.maxWidth < 480;
          bool isTablet =constraints.maxWidth >= 480 && constraints.maxWidth <= 1046;
          controller. hideLeftBar.value = constraints.maxWidth >= 1046 && constraints.maxWidth <= 1295;

          return isMobile
              ? const MobileView()
              : isTablet
                  ? const TabView()
                  : const WebView();
        },
      ),
    );
  }
}
