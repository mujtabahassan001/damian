import 'package:damian/views/image_details/controller/image_details_controller.dart';
import 'package:damian/views/main_screen/models/image_blob.dart';
import 'package:damian/views/main_screen/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bounding_box_annotation/bounding_box_annotation.dart';

class TabDetailView extends StatelessWidget {
  // final Images image;
  const TabDetailView({super.key,});

  @override
  Widget build(BuildContext context) {
    final ImageDetailsController controller = Get.put(ImageDetailsController());

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet =
              constraints.maxWidth > 480 && constraints.maxWidth <= 1046;

          return Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Menu Icon to open sidebar
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                            size: isTablet ? 20 : 28,
                          ),
                          onPressed: () {
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
                                fontSize: isTablet ? 16 : 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Left Content Box
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.blueAccent, width: 0.5),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Text(
                                      "Uploaded on: ${controller.imageDate.value}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  GetBuilder<ImageDetailsController>(
                                    builder: (controller) {
                                      return SizedBox(
                                        height: 300,
                                        child: Obx(() => Stack(
                                              children: [
                                                if (controller.imageBytes != null)
                                                  BoundingBoxAnnotation(
                                                    controller:
                                                        controller.annotationController,
                                                    imageBytes:
                                                        controller.imageBytes!,
                                                  ),
                                                if (controller
                                                    .showAIAnnotations.value)
                                                  for (var annotation
                                                      in controller.staticAnnotations)
                                                    Positioned(
                                                      left: annotation.x,
                                                      top: annotation.y,
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            width: annotation.width,
                                                            height: annotation.height,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: Colors.red,
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                annotation.label!,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors.red,
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 0,
                                                            right: 0,
                                                            child: GestureDetector(
                                                              onTap: () => controller
                                                                  .removeAnnotation(
                                                                      annotation),
                                                              child: Container(
                                                                width: 20,
                                                                height: 20,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: Colors.red,
                                                                ),
                                                                child: const Icon(
                                                                  Icons.close,
                                                                  size: 14,
                                                                  color:
                                                                      Colors.white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              ],
                                            )),
                                      );
                                    }
                                  ),
                                  Row(
                                    children: [
                                      Obx(() => Checkbox(
                                            value: controller
                                                .showAIAnnotations.value,
                                            onChanged: (bool? value) {
                                              controller.showAIAnnotations
                                                  .value = value ?? false;
                                            },
                                          )),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Show AI annotations",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Right Content Box (Moved Below)
                            Container(
                              padding: const EdgeInsets.all(10),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Steel Plates',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Obx(() => controller.isEditing.value
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  controller.toggleEditingMode();
                                                 
                                                },
                                                child: const Text("Save"),
                                              )
                                            : IconButton(
                                                icon: const Icon(Icons.edit,
                                                    color: Colors.black),
                                                onPressed: () {
                                                  controller.toggleEditingMode();
                                                  controller.showAIAnnotations
                                                      .value = true;
                                                },
                                              )),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'AI Count:',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "0",
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'User Count:',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "${controller.staticAnnotations.length}",
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
      drawer: const NavBarMainScreen(),
    );
  }
}
