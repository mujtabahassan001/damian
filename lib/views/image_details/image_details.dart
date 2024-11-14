import 'package:damian/views/image_details/models/image_details_controller.dart';
import 'package:damian/views/main_screen/mainScreencontroller.dart';
import 'package:damian/views/main_screen/models/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bounding_box_annotation/bounding_box_annotation.dart';
import 'package:damian/views/main_screen/widgets/nav_bar.dart';

class ImageDetails extends StatelessWidget {
  final ImageData image;

  const ImageDetails({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final ImageDetailsController controller = Get.put(ImageDetailsController());

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWeb = constraints.maxWidth > 800;
          bool isTablet = constraints.maxWidth > 600 && constraints.maxWidth <= 800;
          bool isMobile = constraints.maxWidth <= 600;

          return Stack(
            children: [
              Row(
                children: [
                  if (isWeb || isTablet) const NavBarMainScreen(),
                  if (isMobile) const SizedBox(width: 0),

                  const SizedBox(width: 20),
                  Expanded(
                    flex: isWeb || isTablet ? 8 : 12,
                    child: Column(
                      children: [
                        const Spacer(flex: 1),
                        Expanded(
                          flex: 6,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blueAccent, width: 0.5),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Uploaded on: ${controller.imageDate.value}",
                                          style: GoogleFonts.roboto(
                                            fontSize: isMobile ? 14 : 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: BoundingBoxAnnotation(
                                                  controller: controller.annotationController,
                                                  imageBytes: image.bytes!,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Obx(() => Checkbox(
                                            value: controller.showAIAnnotations.value,
                                            onChanged: (bool? value) {
                                              controller.showAIAnnotations.value = value ?? false;
                                            },
                                          )),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Show AI annotations",
                                            style: GoogleFonts.roboto(
                                              fontSize: isMobile ? 14 : 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green, width: 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Item',
                                          style: GoogleFonts.roboto(
                                            fontSize: isMobile ? 16 : 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: isMobile ? 10 : 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Steel Plates',
                                              style: GoogleFonts.roboto(
                                                fontSize: isMobile ? 14 : 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Obx(() => controller.isEditing.value
                                                ? ElevatedButton(
                                                    onPressed: () {
                                                      controller.toggleEditingMode();
                                                      controller.updateUserCount();
                                                    },
                                                    child: Text("Save"),
                                                  )
                                                : IconButton(
                                                    icon: Icon(Icons.edit, color: Colors.black),
                                                    onPressed: () {
                                                      controller.toggleEditingMode();
                                                      controller.showAIAnnotations.value = false;
                                                    },
                                                  )),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '\t AI Count: ',
                                              style: GoogleFonts.roboto(
                                                fontSize: isMobile ? 14 : 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "0", // Placeholder for AI count
                                              style: GoogleFonts.roboto(
                                                  fontSize: isMobile ? 14 : 16,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Obx(() => Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '\t User Count: ',
                                              style: GoogleFonts.roboto(
                                                fontSize: isMobile ? 14 : 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "${controller.annotationList.length}",
                                              style: GoogleFonts.roboto(
                                                  fontSize: isMobile ? 14 : 16,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        )),
                                      ],
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
