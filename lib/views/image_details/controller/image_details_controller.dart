import 'dart:developer';
import 'dart:typed_data';
import 'package:damian/views/image_details/models/bounding_model.dart';
import 'package:damian/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:bounding_box_annotation/bounding_box_annotation.dart';

class ImageDetailsController extends GetxController {
  RxList<AnnotationDetails> annotationList = <AnnotationDetails>[].obs;
  ApiService apiService = ApiService();
  RxBool isEditing = false.obs;
  RxBool showAIAnnotations = false.obs;
  RxBool showEditModeAnnotations = false.obs; 
  RxString imageDate = DateTime.now().toString().obs;
  RxBool showUserCount = false.obs;
  RxBool showConfirmCount = false.obs;
  RxList<Map<String, String>> deletedLabels = <Map<String, String>>[].obs; // Change to list of maps
  RxInt confirmCount = 0.obs;
  Uint8List? _imageBytes;

  Uint8List? get imageBytes => _imageBytes;

  set imageBytes(value) {
    _imageBytes = value;
    update();
  }

  RxBool isSaving = false.obs;

  final AnnotationController annotationController = AnnotationController();

  RxList<BoundingModel> staticAnnotations = <BoundingModel>[ ].obs;

  // Function to handle adding annotations
  Future<void> handleAddAnnotation() async {
    final annotations = await annotationController.getData();
    if (annotations.isNotEmpty) {
      for (var annotation in annotations) {
        final existingLabels = [
          ...staticAnnotations.map((e) => e.label?.toLowerCase()),
          ...annotationList.map((e) => e.label.toLowerCase())
        ];

        if (existingLabels.contains(annotation.label.toLowerCase())) {
          Get.snackbar(
            "Error",
            "Name already exists. Try another one.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
          return;
        }
      }
      annotationList.addAll(annotations);
      await addAnnotation(); // Save annotations via API
    }
  }

  // Function to add annotations via API
  Future<void> addAnnotation() async {
    EasyLoading.show();
    final annotation = await annotationController.getData();

    if (annotation.isNotEmpty) {
      annotationList.addAll(annotation);

      final annotationData = {
        "boxes": annotation.map((annot) {
          return {
            "x": annot.p1.dx,
            "y": annot.p1.dy,
            "h": annot.p3.dy - annot.p1.dy,
            "w": annot.p2.dx - annot.p1.dx,
            "label": annot.label,
            "status": "user",
          };
        }).toList()
      };

      final imageName = Get.arguments['imageName'] ?? "default_image";
      log('Saving annotations for image: $imageName');
      try {
        await ApiService.saveAnnotation(imageName, annotationData);
        EasyLoading.dismiss();
        EasyLoading.showToast('Annotation Added Successfully');
      } catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showToast('Failed to add annotation');
        log('Error saving annotation: $e');
      }
    } else {
      EasyLoading.showToast('No annotations to add');
      log('No annotations to add.');
    }
  }

  // Function to convert a network image to a Uint8List
  Future<Uint8List?> networkImageToUint8List() async {
    EasyLoading.show();
    try {
      final response = await http.get(Uri.parse(Get.arguments['imageUrl']));
      if (response.statusCode == 200) {
        imageBytes = response.bodyBytes;
        update();
        final bounding = await apiService.fetchBoundingList(Get.arguments['imageName']);
        staticAnnotations.addAll(bounding);
        update();
        EasyLoading.dismiss();
        return response.bodyBytes;
      } else {
        EasyLoading.dismiss();
        log('Failed to load image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      EasyLoading.dismiss();
      log('Error fetching image: $e');
      return null;
    }
  }

  // Function to toggle editing mode
Future<void> toggleEditingMode() async {
  isEditing.value = !isEditing.value;

  // Show annotations in edit mode
  showEditModeAnnotations.value = isEditing.value;

  // Optionally, retain the logic for AI annotations visibility (toggle based on checkbox or other condition)
  showAIAnnotations.value = false;  // If you don't want to show AI annotations in edit mode

  // Only toggle user-related UI states
  showUserCount.value = isEditing.value;
  showConfirmCount.value = isEditing.value;

  // Reset confirm count when exiting edit mode
  if (!isEditing.value) {
    confirmCount.value = 0;
  }
}


  // Function to save annotations via API
  Future<void> saveAnnotations() async {
    isSaving.value = true;
    EasyLoading.show();
    await _deleteAnnotationsFromApi();

    annotationList.clear();
    final newAnnotations = await annotationController.getData();

    if (newAnnotations.isEmpty) {
      log('No new annotations to save.');
      EasyLoading.dismiss();
      isSaving.value = false;
      return;
    }

    annotationList.addAll(newAnnotations);

    final annotationData = {
      "boxes": newAnnotations.map((annot) {
        return {
          "x": annot.p1.dx,
          "y": annot.p1.dy,
          "h": annot.p3.dy - annot.p1.dy,
          "w": annot.p2.dx - annot.p1.dx,
          "label": annot.label,
          "status": "user",
        };
      }).toList()
    };

    final imageName = Get.arguments['imageName'] ?? "default_image";
    log('Saving annotations for image: $imageName');
    try {
      await ApiService.saveAnnotation(imageName, annotationData);
        EasyLoading.dismiss();
      EasyLoading.showToast('Annotations saved successfully');
    } catch (e) {
      EasyLoading.showToast('Failed to save annotations');
        EasyLoading.dismiss();
      log('Error saving annotations: $e');
    }

    isSaving.value = false;
  }

  // Function to remove an annotation and add the label to the deleted list
  void removeAnnotation(BoundingModel annotation) {
    // Add label to deleted list as a map
    deletedLabels.add({"label": annotation.label!});

    log(deletedLabels.length.toString());

    // Remove annotation from static list
    staticAnnotations.remove(annotation);

    // If it's a user-drawn annotation, also remove it from annotationList
    annotationList.removeWhere((element) => element.label == annotation.label);

    // Call API to delete the annotation on the backend
    update();
  }

  // API call to delete annotations
  Future<void> _deleteAnnotationsFromApi() async {
    if (deletedLabels.isNotEmpty) {
      final imageName = Get.arguments['imageName'] ?? "default_image";
      try {
        await ApiService().deleteAnnotations(imageName, deletedLabels);
        EasyLoading.showToast("Deleted SuccessFully");
        deletedLabels.clear(); // Clear the deleted labels list after sending to API
      } catch (e) {
        log('Error deleting annotations: $e');
        EasyLoading.showToast('Something Went Wrong');
        // Optionally, show a message to the user if something goes wrong.
      }
    }
  }

  // Function to get AI annotation count
  int getAICount() {
    return showAIAnnotations.value ? staticAnnotations.length : 0;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    annotationController.addListener(() async {
      await addAnnotation();
    });
    await networkImageToUint8List();
   
  }
}
