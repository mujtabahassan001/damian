import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'dart:typed_data'; // for Uint8List

class ImageData {
  final String path;
  final String uploadDate;
  final String name;
  final Uint8List? bytes; // To handle image data for web

  ImageData({
    required this.path,
    required this.uploadDate,
    required this.name,
    this.bytes,
  });
}

class MainScreenController extends GetxController {
  List<ImageData> _images = [];

  List<ImageData> get images => _images;

  set images(List<ImageData> value) {
    _images = value;
    update();
  }

  // Getter for the last image uploaded date
  String get lastUpdated {
    if (_images.isNotEmpty) {
      return _images.last.uploadDate;
    } else {
      return 'No images uploaded yet';
    }
  }

  // Function to handle file picking and applying FIFO (First In, First Out) for image list
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      String uploadDate = DateTime.now().toString();
      String name = result.files.single.name;

      if (kIsWeb) {
        final bytes = result.files.single.bytes!;

        // Add new image and apply FIFO logic (if length exceeds 9, remove the first image)
        _addImageToList(ImageData(
          path: '',
          uploadDate: uploadDate,
          name: name,
          bytes: bytes,
        ));
      } else {
        String path = result.files.single.path!;

        // Add new image and apply FIFO logic (if length exceeds 9, remove the first image)
        _addImageToList(ImageData(
          path: path,
          uploadDate: uploadDate,
          name: name,
          bytes: null,
        ));
      }
    } else {
      print("No file selected");
    }
  }

  // Helper function to add image and apply FIFO logic
  void _addImageToList(ImageData newImage) {
    // Check if images list already has 9 images
    if (_images.length >= 9) {
      _images.removeAt(0); // Remove the first image if the list exceeds 9
    }
    _images.add(newImage); // Add the new image to the list
    update(); // Update the UI
  }
}
