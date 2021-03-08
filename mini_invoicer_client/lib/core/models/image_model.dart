class Image {
  String id;
  String title;
  String description;
  String url;
  bool sensitive;
  DateTime timestamp;
  String ownerId;

  Image({
    this.id,
    this.title,
    this.description,
    this.url,
    this.sensitive,
    this.timestamp,
    this.ownerId,
  });

  factory Image.fromJson(String id, Map<String, dynamic> json) => Image(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        url: json['url'] as String,
        sensitive: json['sensitive'] as bool,
        timestamp: json['timestamp']?.toDate() as DateTime,
        ownerId: json['ownerId'] as String,
      );

  static Map<String, dynamic> toJson(Image image) => {
        'title': image.title,
        'description': image.description,
        'url': image.url,
        'sensitive': image.sensitive,
        // timestamp should be done server-side
        'timestamp': DateTime.now().toIso8601String(),
        'ownerId': image.ownerId,
      };

  static Map<String, dynamic> toJsonWithId(Image image) => {
        'id': image.id,
        'title': image.title,
        'description': image.description,
        'url': image.url,
        'sensitive': image.sensitive,
        // timestamp is done server-side
        'timestamp': DateTime.now().toIso8601String(),
        'ownerId': image.ownerId,
      };
}
