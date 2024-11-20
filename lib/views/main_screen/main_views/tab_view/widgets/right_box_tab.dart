import 'package:damian/views/main_screen/controller/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';

class RightBoxTab extends StatelessWidget {
  const RightBoxTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<MainScreenController>(builder: (controller) {
          String lastUpdated = 'No uploads yet';
          if (controller.images.isNotEmpty) {
            controller.images
                .sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
            lastUpdated = controller.images.first.timestamp!;
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overview',
                  style: GoogleFonts.roboto(
                    fontSize: controller.screenWidth <= 1046 ? 14 : 18,
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
                        fontSize: controller.screenWidth <= 1046 ? 12 : 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${controller.images.length}',
                      style: GoogleFonts.roboto(
                        fontSize: controller.screenWidth <= 1046 ? 12 : 14,
                        color: Colors.black,
                      ),
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
                        fontSize: controller.screenWidth <= 1046 ? 12 : 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      lastUpdated,
                      style: GoogleFonts.roboto(
                        fontSize: controller.screenWidth <= 1046 ? 12 : 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Details:',
                  style: GoogleFonts.roboto(
                    fontSize: controller.screenWidth <= 1046 ? 14 : 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.images.map((image) {
                    final index = controller.images.indexOf(image);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Image ${index + 1}',
                            style: GoogleFonts.roboto(
                              fontSize: controller.screenWidth <= 1046 ? 12 : 14,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Uploaded on: ${image.timestamp}',
                            style: GoogleFonts.roboto(
                              fontSize: controller.screenWidth <= 1046 ? 12 : 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
