import 'package:damian/views/main_screen/controller/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
     Get.find<MainScreenController>(); // Access controller
    return GetBuilder<MainScreenController>(
      builder: (controller) {
        return Stack(
          children: [
            Positioned(
              top: 30,
              right: 30,
              child: ElevatedButton(
                onPressed: controller.pickImage,
                child: const Row(
                  children: [
                    Text(
                      'Upload Image',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.upload, color: Colors.black, size: 22),
                  ],
                ),
              ),
            ),
            Obx(
               () {
                return Positioned(
                  top: 20,
                  left: controller.hideLeftBar.value ? 20 : 255, // Adjust position based on sidebar visibility
                  child: Row(
                    children: [
                      if (controller.hideLeftBar.value)
                        Builder(
                          builder: (context) {
                            return IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            );
                          },
                        ),
                      const SizedBox(width: 10),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          '110-kV-Freileitung für Schleswig-Holstein Netz AG\nTower number 1: St. Michaelisdonn',
                          style: GoogleFonts.abel(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ],
        );
      }
    );
  }
}
