// class ImagesModel {
//   int? count;
//   List<Images>? images;

//   ImagesModel({this.count, this.images});

//   ImagesModel.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['count'] = this.count;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Images {
//   String? originalFilename;
//   String? storedFilename;
//   String? storedFilepathOriginal;
//   String? storedFilepathProcessed;
//   String? updatedAt;
//   String? uploadedAt;

//   Images(
//       {this.originalFilename,
//       this.storedFilename,
//       this.storedFilepathOriginal,
//       this.storedFilepathProcessed,
//       this.updatedAt,
//       this.uploadedAt});

//   Images.fromJson(Map<String, dynamic> json) {
//     originalFilename = json['original_filename'];
//     storedFilename = json['stored_filename'];
//     storedFilepathOriginal = json['stored_filepath_original'];
//     storedFilepathProcessed = json['stored_filepath_processed'];
//     updatedAt = json['updated_at'];
//     uploadedAt = json['uploaded_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['original_filename'] = this.originalFilename;
//     data['stored_filename'] = this.storedFilename;
//     data['stored_filepath_original'] = this.storedFilepathOriginal;
//     data['stored_filepath_processed'] = this.storedFilepathProcessed;
//     data['updated_at'] = this.updatedAt;
//     data['uploaded_at'] = this.uploadedAt;
//     return data;
//   }
// }