import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:bounding_box_annotation/bounding_box_annotation.dart';
import 'package:damian/views/image_details/models/bounding_model.dart';
import 'package:damian/views/image_details/models/boxes.dart';
import 'package:damian/views/main_screen/models/image_blob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:io';

class ApiService {
  final String _baseUrl = "http://192.168.1.11:5000"; // Base URL for API
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://192.168.1.11:5000",
    headers: {
      "Content-Type": "application/json",
    },
  ));

  // Function to save annotation data
  static Future<void> saveAnnotation(String imageName, Map<String, dynamic> annotationData) async {
    final String endpoint = "http://192.168.1.11:5000/annotate/$imageName";
    log('Attempting to save annotations at: $endpoint');
    log('Payload: ${jsonEncode(annotationData)}');

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(annotationData),
      );

      if (response.statusCode == 200) {
        log('Annotations saved successfully: ${response.body}');
      } else {
        log('Failed to save annotations. Status code: ${response.statusCode}');
        log('Response Body: ${response.body}');
      }
    } catch (e) {
      log('Error saving annotation: $e');
    }
  }

  // Function to delete annotations
  Future<void> deleteAnnotations(String imageName,List<Map<String, String>> labelsToDelete) async {
    try {
      final response = await _dio.post(
        "http://192.168.1.11:5000/annotate/$imageName/delete",
        data: {"boxes":labelsToDelete,},// Send labels to delete
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        log('Annotations deleted successfully');
      } else {
        log('Failed to delete annotations. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error deleting annotations: $e');
    }
  }

  // Fetch recent images from API
  Future<ImageBlob> fetchRecentImages() async {
    final response = await http.get(Uri.parse("http://192.168.1.11:5000/images/recent"));
    log(response.statusCode.toString());
    log(response.body);
    if (response.statusCode == 200) {
      return ImageBlob.fromJson(json.decode(response.body));
    } else {
      log("Failed to load images. Status code: ${response.statusCode}");
      return ImageBlob(images: []);
    }
  }

  // API for uploading images
  Future<Map<String, dynamic>?> uploadImage(File? imageFile, String imageName, Uint8List? imageBytes) async {
    try {
      FormData formData;

      if (kIsWeb) {
        if (imageBytes != null) {
          formData = FormData.fromMap({
            "file": MultipartFile.fromBytes(imageBytes, filename: imageName),
          });
        } else {
          log("No image bytes found for web upload.");
          return null;
        }
      } else {
        if (imageFile != null) {
          formData = FormData.fromMap({
            "file": await MultipartFile.fromFile(imageFile.path, filename: imageName),
          });
        } else {
          log("No image file found for mobile upload.");
          return null;
        }
      }

      final response = await _dio.post(
        "/upload",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showToast(
          'Image uploaded successfully.',
          duration: const Duration(milliseconds: 2000),
          toastPosition: EasyLoadingToastPosition.top,
        );
        log("Image uploaded successfully.");
        return response.data;
      } else {
        log("Failed to upload image. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error uploading image: $e");
    }
    return null;
  }

  Future<List<BoundingModel>> fetchBoundingList(String imageName) async {
  final String endpoint = "http://192.168.1.11:5000/get_annotations/$imageName";
  try {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      log('Bounding data fetched successfully: ${response.body}');

      // Parse the response body
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // Extract the bounding_boxes array
      final List<dynamic> boundingBoxes = responseData['bounding_boxes'];

      // Map each JSON object in the array to a BoundingModel
      return boundingBoxes.map((data) => BoundingModel.fromJson(data)).toList();
    } else {
      log('Failed to fetch bounding data. Status code: ${response.statusCode}');
      log('Response Body: ${response.body}');
      return [];
    }
  } catch (e) {
    log('Error fetching bounding data: $e');
    return [];
  }
}

}
