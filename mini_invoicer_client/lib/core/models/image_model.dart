class ImageModel {
  String id;
  String title;
  String description;
  String url;
  bool sensitive;
  DateTime timestamp;
  List<String> tags;

  ImageModel({
    this.id,
    this.title,
    this.description,
    this.url,
    this.sensitive,
    this.timestamp,
    this.tags,
  });

  factory ImageModel.fromJson(String id, Map<String, dynamic> json) =>
      ImageModel(
        id: id,
        title: json['title'] as String,
        description: json['description'] as String,
        url: json['url'] as String,
        sensitive: json['sensitive'] as bool,
        timestamp: json['timestamp']?.toDate() as DateTime,
        tags: json['tags'] as List<String>,
      );

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'description': this.description,
        'url': this.url,
        'sensitive': this.sensitive,
        'timestamp': this.timestamp,
        'tags': this.tags,
      };
}
