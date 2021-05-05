class ImageModel {
  String id;
  String title;
  String description;
  String url;
  bool sensitive;
  DateTime timestamp;
  String ownerId;

  ImageModel({
    this.id,
    this.title,
    this.description,
    this.url,
    this.sensitive,
    this.timestamp,
    this.ownerId,
  });

  factory ImageModel.fromJson(String id, Map<String, dynamic> json) =>
      ImageModel(
        id: id,
        title: json['title'] as String,
        description: json['description'] as String,
        url: json['url'] as String,
        sensitive: json['sensitive'] as bool,
        timestamp: json['timestamp']?.toDate() as DateTime,
        ownerId: json['ownerId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'description': this.description,
        'url': this.url,
        'sensitive': this.sensitive,
        'timestamp': this.timestamp,
        'ownerId': this.ownerId,
      };
}
