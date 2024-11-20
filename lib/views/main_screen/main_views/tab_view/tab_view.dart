import 'package:damian/views/main_screen/main_views/tab_view/widgets/header_tab.dart';
import 'package:damian/views/main_screen/main_views/tab_view/widgets/left_box_tab.dart';
import 'package:damian/views/main_screen/main_views/tab_view/widgets/right_box_tab.dart';
import 'package:damian/views/main_screen/widgets/nav_bar.dart';
import 'package:damian/views/main_screen/controller/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabView extends StatelessWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
    final MainScreenController controller = Get.put(MainScreenController());

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Update the screen width in the controller
          controller.screenWidth = constraints.maxWidth;
          controller.update(); // Ensure the controller gets updated

          return const Stack(
            children: [
              Column(
                children: [
                  // Header Row with Menu Icon, Title, and Upload Button
                  HeaderTab(),
                  SizedBox(height: 10), // Add space below header

                  // Main Content Layout
                  Expanded(
                    flex: 12,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Left Image Section
                           LeftBoxTab(),

                           SizedBox(height: 20),

                          // Right Details Section 
                          RightBoxTab(),
                        ],
                      ),
                    ),
                  ),
                   Spacer(flex: 1),
                ],
              ),
            ],
          );
        },
      ),
      drawer: const NavBarMainScreen(),
    );
  }
}
