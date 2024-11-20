import 'package:bounding_box_annotation/bounding_box_annotation.dart';
import 'package:damian/export.dart';
import 'package:damian/views/image_details/controller/image_details_controller.dart';
import 'package:damian/views/main_screen/models/image_blob.dart';
import 'package:damian/views/main_screen/widgets/nav_bar.dart';

class WebDetailView extends StatelessWidget {
  const WebDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageDetailsController());

    return Stack(
      children: [
        Row(
          children: [
            const NavBarMainScreen(),
            const SizedBox(width: 20),
            Expanded(
              flex: 12,
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
                              border: Border.all(
                                  color: Colors.blueAccent, width: 0.5),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Uploaded on: ${controller.imageDate.value}",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                GetBuilder<ImageDetailsController>(
                                    builder: (controller) {
                                  return Expanded(
                                    child: Obx(() {
                                      return Stack(
                                        children: [
                                          if (controller.imageBytes != null)
                                            BoundingBoxAnnotation(
                                              controller: controller
                                                  .annotationController,
                                              imageBytes:
                                                  controller.imageBytes!,
                                            ),
                                          // Show static bounding boxes based on the new variable
                                          if (controller
                                              .showEditModeAnnotations.value)
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
                                                          color: Colors
                                                              .blue, // Blue color for edit mode
                                                          width: 2,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          annotation.label!,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.blue,
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
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.blue,
                                                          ),
                                                          child: const Icon(
                                                            Icons.close,
                                                            size: 14,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        ],
                                      );
                                    }),
                                  );
                                }),
                                Row(
                                  children: [
                                    Obx(() => Checkbox(
                                          value: controller
                                              .showAIAnnotations.value,
                                          onChanged: (bool? value) {
                                            // This will be used to toggle AI annotations separately
                                          },
                                        )),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Show AI annotations",
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Steel Plates',
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Obx(() {
                                        return controller.isEditing.value
                                            ? IconButton(
                                                icon: const Icon(
                                                    Icons.visibility_off,
                                                    size: 20,
                                                    color: Colors.black),
                                                onPressed: () {
                                                  controller
                                                      .toggleEditingMode();
                                                  controller
                                                          .showEditModeAnnotations
                                                          .value =
                                                      false; // Hide annotation boxes
                                                },
                                              )
                                            : IconButton(
                                                icon: const Icon(Icons.edit,
                                                    color: Colors.black),
                                                onPressed: () {
                                                  controller
                                                      .toggleEditingMode();
                                                  // Show static bounding boxes in edit mode
                                                  controller
                                                          .showEditModeAnnotations
                                                          .value =
                                                      true; // Show annotation boxes
                                                },
                                              );
                                      }),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\t AI Count: ',
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "0", // Static value for AI count, update as per your logic
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  // Conditionally render User Count based on isEditing state
                                  Obx(() {
                                    return controller.showUserCount.value
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\t Change Count: ',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                "${controller.staticAnnotations.length}",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(); // Return an empty container when not in edit mode
                                  }),
                                  const SizedBox(height: 20),
                                  // Conditionally render Confirm Count and Save Button based on isEditing state
                                  Obx(() {
                                    return controller.isEditing.value
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\t Confirm Count',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              OutlinedButton(
                                                onPressed: () async {
                                                  await controller
                                                      .saveAnnotations();
                                                },
                                                style: OutlinedButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  backgroundColor: Colors.white,
                                                   // Set text color to green
                                                  side: BorderSide(
                                                      color: Colors.black,
                                                      width:
                                                          2), // Set green border color
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(5), // Apply a slight curve
                                                  ),
                                                ),
                                                child: const Text("Save",style: TextStyle(fontWeight: FontWeight.w300),),
                                              )
                                            ],
                                          )
                                        : const SizedBox(); // Return an empty container when not in edit mode
                                  }),
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
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                '110-kV-Freileitung für Schleswig-Holstein Netz AG\nTower number 1: St. Michaelisdonn',
                style: GoogleFonts.abel(
                  fontSize: 22,
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
  }
}
