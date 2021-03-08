class Currency {
  String id;
  String name;
  String shorthand;
  String sign;

  Currency({
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

  static Map<String, dynamic> toJson(Currency currency) => {
        'name': currency.name,
        'shorthand': currency.shorthand,
        'sign': currency.sign,
      };

  static Map<String, dynamic> toJsonWithId(Currency currency) => {
        'id': currency.id,
        'name': currency.name,
        'shorthand': currency.shorthand,
        'sign': currency.sign,
      };
}
