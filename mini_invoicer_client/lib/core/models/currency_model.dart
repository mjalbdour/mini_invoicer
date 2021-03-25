class Currency {
  String id;
  String name;
  String code;
  String symbol;

  Currency({
    this.id,
    this.name,
    this.code,
    this.symbol,
  });

  factory Currency.fromJson(String id, Map<String, dynamic> json) => Currency(
        id: id,
        name: json['name'] as String,
        code: json['code'] as String,
        symbol: json['symbol'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'code': this.code,
        'symbol': this.symbol,
      };

  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'name': this.name,
        'code': this.code,
        'symbol': this.symbol,
      };
}
