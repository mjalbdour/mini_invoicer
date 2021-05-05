class DocumentModel {
  String id;
  String title;
  String description;
  List<String> tags;

  DocumentModel({this.id, this.title, this.description, this.tags});

  factory DocumentModel.fromJson(String id, Map<String, dynamic> json) =>
      DocumentModel(
        id: id,
        title: json['title'] as String,
        description: json['description'] as String,
        tags: json['tags'] as List<String>,
      );

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'description': this.description,
        'tags': this.tags,
      };
}
