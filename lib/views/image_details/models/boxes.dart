class Boxes {
  List<BoundingBoxes>? boundingBoxes;
  String? imageId;
  String? message;

  Boxes({this.boundingBoxes, this.imageId, this.message});

  Boxes.fromJson(Map<String, dynamic> json) {
    if (json['bounding_boxes'] != null) {
      boundingBoxes = <BoundingBoxes>[];
      json['bounding_boxes'].forEach((v) {
        boundingBoxes!.add(new BoundingBoxes.fromJson(v));
      });
    }
    imageId = json['image_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.boundingBoxes != null) {
      data['bounding_boxes'] =
          this.boundingBoxes!.map((v) => v.toJson()).toList();
    }
    data['image_id'] = this.imageId;
    data['message'] = this.message;
    return data;
  }
}

class BoundingBoxes {
  double? h;
  String? label;
  String? status;
  double? w;
  double? x;
  double? y;

  BoundingBoxes({this.h, this.label, this.status, this.w, this.x, this.y});

  BoundingBoxes.fromJson(Map<String, dynamic> json) {
    h = json['h'];
    label = json['label'];
    status = json['status'];
    w = json['w'];
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h'] = this.h;
    data['label'] = this.label;
    data['status'] = this.status;
    data['w'] = this.w;
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}
