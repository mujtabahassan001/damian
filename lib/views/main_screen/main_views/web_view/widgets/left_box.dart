import 'package:damian/views/main_screen/controller/main_screen_controller.dart';
import 'package:damian/views/main_screen/models/image_blob.dart';
import 'package:damian/views/main_screen/models/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';

class LeftBoxContent extends StatelessWidget {
  const LeftBoxContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              child: GetBuilder<MainScreenController>(builder: (controller) {
                // Get the latest 9 images for the grid
                List<Images> displayImages = controller.images.take(9).toList();

                return GridView.builder(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 40, bottom: 20),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisExtent: 120,
                    mainAxisSpacing: 45,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    if (index < displayImages.length) {
                      final image = displayImages[index];
                      return GestureDetector(
                        onTap: () {
                          controller.toImageDetail(image);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize
                              .min, // Ensure it only takes the required space
                          children: [
                            Flexible(
                              child: Container(
                                width: 230,
                                height: 98,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  image: image.blobName != null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              'http://192.168.1.11:5000/get-image/?image_id=${image.blobName!}'),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: image.blobName == null
                                    ? Center(
                                        child: Text(
                                          'No Image',
                                          style: GoogleFonts.roboto(
                                              fontSize: 12,
                                              color: Colors.black45),
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(
                                height:
                                    10), // Spacing between image and timestamp
                            Text(
                              image.timestamp ?? 'Unknown date',
                              style: GoogleFonts.roboto(
                                  fontSize: 12, color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    } else {
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
                                style: GoogleFonts.roboto(
                                    fontSize: 12, color: Colors.black45),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
