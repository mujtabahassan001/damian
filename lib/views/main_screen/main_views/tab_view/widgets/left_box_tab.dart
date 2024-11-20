import 'package:damian/views/main_screen/controller/main_screen_controller.dart';
import 'package:damian/views/main_screen/models/image_blob.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LeftBoxTab extends StatelessWidget {
  const LeftBoxTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 0.5),
      ),
      child: GetBuilder<MainScreenController>(builder: (controller) {
        List<Images> displayImages = controller.images.take(9).toList();

        return GridView.builder(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20,bottom: 20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: controller.crossAxisCount, // Fetch from controller
            crossAxisSpacing: 10,
            childAspectRatio: 1.3,
            mainAxisSpacing: 10,
          ),
          itemCount: displayImages.length,
          itemBuilder: (context, index) {
            final image = displayImages[index];
            return GestureDetector(
              onTap: () {
                controller.toImageDetail(image);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image.blobName != null
                      ? Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            image: DecorationImage(
                              image:
                                  NetworkImage('http://192.168.1.11:5000/get-image/?image_id=${image.blobName!}'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 120,
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
                  const SizedBox(height: 10),
                  Text(
                    image.timestamp ?? 'Unknown date',
                    style:
                        GoogleFonts.roboto(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
