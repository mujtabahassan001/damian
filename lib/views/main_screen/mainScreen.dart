import 'package:damian/views/image_details/image_details.dart';
import 'package:damian/views/main_screen/models/images.dart';
import 'package:damian/views/main_screen/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb check
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'mainScreencontroller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainScreenController controller = Get.put(MainScreenController());
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check if the screen is mobile, tablet or web based on the width
          bool isMobile = constraints.maxWidth <= 600;
          bool isTablet = constraints.maxWidth > 600 && constraints.maxWidth <= 800;
          bool isWeb = constraints.maxWidth > 800;

          return Stack(
            children: [
              Row(
                children: [
                  // Navigation Bar (Visible on Tablet and Web)
                  if (isWeb || isTablet) const NavBarMainScreen(),
                  if (isMobile) const SizedBox(width: 0), // Hide on mobile

                  const SizedBox(width: 20),
                  Expanded(
                    flex: isWeb || isTablet ? 8 : 12, // Adjust flex based on screen size
                    child: Column(
                      children: [
                        const Spacer(flex: 1),
                        Expanded(
                          flex: 6,
                          child: Row(
                            children: [
                              // Left Content Box
                              Expanded(
                                flex: 8,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueAccent, width: 0.5),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.7,
                                        child: GetBuilder<MainScreenController>(
                                          builder: (controller) {
                                            return GridView.builder(
                                              padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 20,
                                                mainAxisExtent: 120,
                                                mainAxisSpacing: 45,
                                              ),
                                              itemCount: 9, // Fixed count for 9 boxes
                                              itemBuilder: (context, index) {
                                                if (controller.images.length > index) {
                                                  final reversedIndex = controller.images.length - 1 - index; // Reverse order
                                                  final image = controller.images[reversedIndex];

                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => ImageDetails(image: image),
                                                        ),
                                                      );
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          width: 230,
                                                          height: 98,
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey[200],
                                                            image: DecorationImage(
                                                              image: kIsWeb && image.bytes != null
                                                                  ? MemoryImage(image.bytes!)
                                                                  : FileImage(File(image.path)),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Text(
                                                          image.uploadDate,
                                                          style: GoogleFonts.roboto(fontSize: 12, color: Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  // Empty box with "No Image"
                                                  return Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        width: 230,
                                                        height: 98,
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey[300],
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            'No Image',
                                                            style: GoogleFonts.roboto(fontSize: 12, color: Colors.black45),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                    ],
                                                  );
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              // Right Content Box (Details and Counts)
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green, width: 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GetBuilder<MainScreenController>(
                                      builder: (controller) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Overview',
                                              style: GoogleFonts.roboto(
                                                fontSize: isMobile ? 14 : 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Number of images: ',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: isMobile ? 12 : 14, color: Colors.black),
                                                ),
                                                Text(
                                                  '${controller.images.length}',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: isMobile ? 12 : 14, color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Last updated: ',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: isMobile ? 12 : 14, color: Colors.black),
                                                ),
                                                Text(
                                                  controller.lastUpdated,
                                                  style: GoogleFonts.roboto(
                                                      fontSize: isMobile ? 12 : 14, color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              'Details:',
                                              style: GoogleFonts.roboto(
                                                fontSize: isMobile ? 14 : 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                shrinkWrap: false,
                                                itemCount: controller.images.length,
                                                itemBuilder: (context, index) {
                                                  final image = controller.images[index];
                                                  return ListTile(
                                                    minTileHeight: 40,
                                                    title: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Image ${index + 1}',
                                                          style: GoogleFonts.roboto(
                                                              fontSize: isMobile ? 12 : 14, color: Colors.black),
                                                        ),
                                                        Text(
                                                          'Uploaded on: ${image.uploadDate}',
                                                          style: GoogleFonts.roboto(
                                                              fontSize: isMobile ? 12 : 14, color: Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(flex: 1),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 30,
                right: 30,
                child: ElevatedButton(
                  onPressed: controller.pickImage,
                  child: Row(
                    children: [
                      Text(
                        'Upload Image',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.upload, color: Colors.black),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 255,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      '110-kV-Freileitung für Schleswig-Holstein Netz AG\nTower number 1: St. Michaelisdonn',
                      style: GoogleFonts.abel(
                        fontSize: isMobile ? 16 : 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
