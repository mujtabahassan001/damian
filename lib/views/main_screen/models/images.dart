// images_model.dart
class ImagesModel {
  int? count;
  List<ImageData>? images;

  ImagesModel({this.count, this.images});

  ImagesModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['images'] != null) {
      images = <ImageData>[];
      json['images'].forEach((v) {
        images!.add(ImageData.fromJson(v));
      });
    }
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageData {
  String? originalFilename;
  String? storedFilename;
  String? storedFilepathOriginal;
  String? storedFilepathProcessed;
  String? updatedAt;
  String? uploadedAt;

  ImageData({
    this.originalFilename,
    this.storedFilename,
    this.storedFilepathOriginal,
    this.storedFilepathProcessed,
    this.updatedAt,
    this.uploadedAt,
  });

  ImageData.fromJson(Map<String, dynamic> json) {
    originalFilename = json['original_filename'];
    storedFilename = json['stored_filename'];
    storedFilepathOriginal = json['stored_filepath_original'];
    storedFilepathProcessed = json['stored_filepath_processed'];
    updatedAt = json['updated_at'];
    uploadedAt = json['uploaded_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['original_filename'] = originalFilename;
    data['stored_filename'] = storedFilename;
    data['stored_filepath_original'] = storedFilepathOriginal;
    data['stored_filepath_processed'] = storedFilepathProcessed;
    data['updated_at'] = updatedAt;
    data['uploaded_at'] = uploadedAt;
    return data;
  }
}
