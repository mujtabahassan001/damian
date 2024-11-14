import 'package:get/get.dart';
import 'package:bounding_box_annotation/bounding_box_annotation.dart';

class ImageDetailsController extends GetxController {
  RxList<AnnotationDetails> annotationList = <AnnotationDetails>[].obs;
  RxBool isEditing = false.obs;
  RxBool showAIAnnotations = false.obs;
  RxString imageDate = DateTime.now().toString().obs;

  final AnnotationController annotationController = AnnotationController();

  Future<void> addAnnotation() async {
    final annotation = await annotationController.getData();
    if (annotation.isNotEmpty && annotation.first.label != null && annotation.first.label!.isNotEmpty) {
      annotationList.addAll(annotation);
      updateUserCount(); // Update count immediately
    }
  }

  void removeAnnotation(AnnotationDetails annotation) {
    annotationList.remove(annotation);
    updateUserCount(); // Update count immediately
  }


  void updateUserCount() {
    print('User Count: ${annotationList.length}');
  }

  void toggleEditingMode() {
    isEditing.value = !isEditing.value;
    showAIAnnotations.value = false; // Turn off AI annotations toggle when edit is toggled
    if (!isEditing.value) {
      saveAnnotations();
    }
  }

  void saveAnnotations() async {
    annotationList.clear();
    annotationList.addAll(await annotationController.getData());
  }

  @override
  void onInit() {
    super.onInit();
    annotationController.addListener(() async {
      await addAnnotation();
    });
  }
}
