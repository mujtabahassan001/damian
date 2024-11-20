class ImageBlob {
  int? count;
  List<Images>? images;

  ImageBlob({this.count, this.images});

  ImageBlob.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = this.count;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? blobName;
  String? timestamp;

  Images({this.blobName, this.timestamp});

  Images.fromJson(Map<String, dynamic> json) {
    blobName = json['blob_name'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blob_name'] = this.blobName;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
