import 'package:damian/views/main_screen/controller/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderMobile extends StatelessWidget {
  const HeaderMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainScreenController>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Icon to open sidebar
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
              size: controller.isMobile ? 20 : 28, // Use controller.isMobile here
            ),
            onPressed: () {
              // Open the Navbar (Drawer)
              Scaffold.of(context).openDrawer();
            },
          ),

          // Title Text
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 15, top: 15),
              child: Text(
                '110-kV-Freileitung für Schleswig-Holstein Netz AG\nTower number 1: St. Michaelisdonn',
                style: GoogleFonts.abel(
                  fontSize: controller.isMobile ? 14 : 18, // Use controller.isMobile here
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),

          // Upload Image Button
          ElevatedButton(
            onPressed: controller.pickImage,
            child: Icon(Icons.upload,
                color: Colors.black, size: controller.isMobile ? 18 : 22), // Use controller.isMobile here
          ),
        ],
      ),
    );
  }
}
