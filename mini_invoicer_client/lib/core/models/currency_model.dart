class Currency {
  String id;
  String title;
  String code;
  String symbol;

  Currency({
    this.id,
    this.title,
    this.code,
    this.symbol,
  });

  factory Currency.fromJson(String id, Map<String, dynamic> json) => Currency(
        id: id,
        title: json['title'] as String,
        code: json['code'] as String,
        symbol: json['symbol'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'code': this.code,
        'symbol': this.symbol,
      };
}
