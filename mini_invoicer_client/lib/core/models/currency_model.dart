class Currency {
  final String id;
  final String name;
  final String shorthand;
  final String sign;

  const Currency({
    this.id,
    this.name,
    this.shorthand,
    this.sign,
  });

  factory Currency.fromJson(String id, Map<String, dynamic> json) => Currency(
        id: id,
        name: json['name'] as String,
        shorthand: json['shorthand'] as String,
        sign: json['sign'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'shorthand': this.shorthand,
        'sign': this.sign,
      };

  Map<String, dynamic> toJsonWithId(String id) => {
        'id': this.id,
        'name': this.name,
        'shorthand': this.shorthand,
        'sign': this.sign,
      };
}
