class Account {
  String id;
  String title;
  num balance;
  DateTime lastUpdated;
  String ownerId;

  Account({
    this.id,
    this.title,
    this.balance,
    this.lastUpdated,
    this.ownerId,
  });

  factory Account.fromJson(String id, Map<String, dynamic> json) => Account(
        id: id,
        title: json['title'] as String,
        balance: json['balance'] as num,
        lastUpdated: json['lastUpdated'].toDate() as DateTime,
        ownerId: json['ownerId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'balance': this.balance,
        'lastUpdated': this.lastUpdated,
        'ownerId': this.ownerId,
      };
}
