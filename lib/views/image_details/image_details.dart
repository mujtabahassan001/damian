import 'dart:developer';
import 'package:damian/views/image_details/controller/image_details_controller.dart';
import 'package:damian/views/image_details/widgets/mobile_detail_view.dart';
import 'package:damian/views/image_details/widgets/tab_detail_view.dart';
import 'package:damian/views/image_details/widgets/web_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageDetails extends StatelessWidget {
 

  const ImageDetails({super.key, });

  @override
  Widget build(BuildContext context) {
    Get.put(ImageDetailsController());

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          log(constraints.toString());
          bool isMobile = constraints.maxWidth < 480;
          bool isTablet = constraints.maxWidth >= 480 && constraints.maxWidth <= 1046;

          return isMobile
              ?  const MobileDetailView()
              : isTablet
                  ?  const TabDetailView()
                  : const WebDetailView();
        },
      ),
    );
  }
}
