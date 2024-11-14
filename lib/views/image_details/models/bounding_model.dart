class BoundingModel {
  double? x;
  double? y;
  double? width;
  double? height;
  String? label;

  BoundingModel({this.x, this.y, this.width, this.height, this.label});

  BoundingModel.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
    width = json['width'];
    height = json['height'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() { 
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['x'] = x;
    data['y'] = y;
    data['width'] = width;
    data['height'] = height;
    data['label'] = label;
    return data;
  }
}