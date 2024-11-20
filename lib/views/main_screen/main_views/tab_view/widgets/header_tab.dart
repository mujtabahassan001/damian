import 'package:damian/views/main_screen/controller/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderTab extends StatelessWidget {
  const HeaderTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainScreenController());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Icon to open sidebar
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
              size: controller.screenWidth <= 1046
                  ? 20
                  : 28, // Adjust size for smaller screens
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
                  fontSize: controller.screenWidth <= 550
                  ? 18
                  : 20, // Slightly smaller font size
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
            child: const Icon(Icons.upload, color: Colors.black, size: 22),
          ),
        ],
      ),
    );
  }
}
