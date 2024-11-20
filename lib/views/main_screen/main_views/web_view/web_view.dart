import 'package:damian/export.dart';
import 'package:damian/views/main_screen/controller/main_screen_controller.dart';
import 'package:damian/views/main_screen/widgets/export.dart';
import 'package:damian/views/main_screen/main_views/web_view/widgets/left_box.dart';
import 'package:damian/views/main_screen/main_views/web_view/widgets/main_header.dart';
import 'package:damian/views/main_screen/main_views/web_view/widgets/right_box.dart';

class WebView extends StatelessWidget {
  const WebView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainScreenController());
    return LayoutBuilder(
      builder: (context, constraints) {
        controller.screenWidth = constraints.maxWidth; // Update screen width in controller
        return Scaffold(
          drawer: controller.hideSidebar ? const Drawer(child: NavBarMainScreen()) : null,
          body: Stack(
            children: [
              Row(
                children: [
                  if (!controller.hideSidebar) const NavBarMainScreen(),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: controller.hideSidebar ? 12 : 8, // Adjust layout based on sidebar visibility
                    child: const Column(
                      children: [
                        Spacer(flex: 1),
                        Expanded(
                          flex: 6,
                          child: Row(
                            children: [
                              LeftBoxContent(),
                              SizedBox(width: 20),
                              RightBoxContent(),
                            ],
                          ),
                        ),
                        Spacer(flex: 1),
                      ],
                    ),
                  ),
                ],
              ),
              const MainHeader(),
            ],
          ),
        );
      },
    );
  }
}
