import 'dart:developer';
import 'package:damian/services/api_service.dart';
import 'package:damian/views/image_details/image_details.dart';
import 'package:damian/views/main_screen/models/image_blob.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class MainScreenController extends GetxController {
  final ApiService apiService = ApiService();
  List<Images> _images = [];
  double screenWidth = 0;  // To track the screen width
  bool _isMobile = false;
  RxBool hideLeftBar = false.obs; // Variable to track if it's a mobile screen

  List<Images> get images => _images;

  set images(List<Images> value) {
    _images = value;
    update();
  }

  bool get isMobile => _isMobile;  // Getter for _isMobile

  // Getter for the last image uploaded date
  String get lastUpdated {
    if (_images.isNotEmpty) {
      return _images.last.timestamp ?? '';
    } else {
      return 'No images uploaded yet';
    }
  }

  // Getter for hideSidebar logic based on screen width
  bool get hideSidebar {
    return screenWidth >= 1046 && screenWidth <= 1295;
  }

  // Getter for crossAxisCount logic based on screen width
  int get crossAxisCount {
    if (screenWidth >= 700 && screenWidth <= 1046) {
      return 3; // 3 images per row for medium screens
    } else if (screenWidth < 700) {
      return 2; // 2 images per row for smaller screens
    } else {
      return 1; // 1 image per row for larger screens
    }
  }

  // Fetch images from the API on initialization
  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchImagesFromApi();
  }

  // Navigate to image detail page
  void toImageDetail(Images image) {
    Get.to(() => const ImageDetails(),
        arguments: {
          'imageUrl': 'http://192.168.1.11:5000/get-image/?image_id=${image.blobName!}',
          'imageName' : image.blobName,
        });
        
  }

  // Function to fetch images from the API
  Future<void> fetchImagesFromApi() async {
    try {
      EasyLoading.show();
      final fetchedImages = await apiService.fetchRecentImages();
      _images = fetchedImages.images!.map<Images>((imageData) {
        return Images(
          blobName: imageData.blobName,
          timestamp: imageData.timestamp,
          
        );
      }).toList();
      update();
      EasyLoading.dismiss();
    } catch (error) {
          EasyLoading.dismiss();
      log('Error fetching images: $error');
    }
  }

  // Function to handle file picking, upload to the API, and apply FIFO logic
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      final uploadDate = DateTime.now().toString();
      final name = result.files.single.name;

      Uint8List? bytes;
      File? file;

      // For web: Use the `bytes` property to get the image data
      if (kIsWeb) {
        bytes = result.files.single.bytes;
      } else {
        // For mobile: Use the `path` property to get the file and create a File object
        final filePath = result.files.single.path;
        if (filePath != null) {
          file = File(filePath);
        }
      }

      EasyLoading.show();
      // Proceed with uploading the image
      if (bytes != null || file != null) {
        try {
          // Upload the image to the API (for web, we'll send the bytes, for mobile, the file)
          final uploadResult = await apiService.uploadImage(file, name, bytes);

          if (uploadResult != null) {
            await fetchImagesFromApi();
            EasyLoading.dismiss();
            update();
          }
        } catch (error) {
          EasyLoading.dismiss();
          log('Error uploading image: $error');
        }
      } else {
        log("No valid file or bytes found.");
      }
    } else {
      log("No file selected");
    }
    EasyLoading.dismiss();
  }

  // Method to update screen width and determine if it's mobile
  void updateScreenWidth(double width) {
    screenWidth = width;
    _isMobile = width <= 480;  
    update();  // Update the UI
  }
}
