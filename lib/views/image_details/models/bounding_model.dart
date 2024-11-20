class BoundingModel {
 double? height;
  String? label;
  String? status;
  double? width;
  double? x;
  double? y;


  BoundingModel({
    required this.x,
    required this.y,
    required this.height,
    required this.width,
    required this.label,
    required this.status,
  });

  // You might also want to create a method to convert annotation to a map for API requests
  Map<String, dynamic> toMap() {
    return {
      'x': x,
      'y': y,
      'h': height,
      'w': width,
      'label': label,
      'status': status,
    };
  }
 
  BoundingModel.fromJson(Map<String, dynamic> json) {
    height = json['h'];
    label = json['label'];
    status = json['status'];
    width = json['w'];
    x = json['x'];
    y = json['y'];
  }
}
