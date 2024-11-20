import 'package:damian/views/main_screen/controller/main_screen_controller.dart';
import 'package:damian/views/main_screen/main_views/mobile_view/widgets/header_mobile.dart';
import 'package:damian/views/main_screen/main_views/mobile_view/widgets/left_box_mobile.dart';
import 'package:damian/views/main_screen/main_views/mobile_view/widgets/right_box_mobile.dart';
import 'package:damian/views/main_screen/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final MainScreenController controller = Get.put(MainScreenController());

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Update screen width and isMobile flag in the controller
          controller.updateScreenWidth(constraints.maxWidth);

          return const Stack(
            children: [
              Column(
                children: [
                  // Header Row with Menu Icon, Title, and Upload Button
                  HeaderMobile(),
                  SizedBox(height: 10), // Add space below header

                  Expanded(
                    flex: 12,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Left Box
                          LeftBoxMobile(),

                          SizedBox(height: 20),

                          // Right Details Section with smaller font size for mobile
                          RightBoxMobile(),
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
      // Add Drawer to display the NavBar
      drawer: const NavBarMainScreen(),
    );
  }
}
