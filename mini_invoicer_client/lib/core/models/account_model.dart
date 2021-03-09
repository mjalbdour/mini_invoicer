class Account {
  String id;
  double balance;
  DateTime lastUpdated;
  String ownerId;

  Account({
    this.id,
    this.balance,
    this.lastUpdated,
    this.ownerId,
  });

/*
`'id'`
`'balance'`
`'lastUpdated'`
`'ownerId'`
*/

  factory Account.fromJson(String id, Map<String, dynamic> json) => Account(
        id: id,
        balance: json['balance'] as double,
        lastUpdated: json['lastUpdated'].toDate() as DateTime,
        ownerId: json['ownerId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'balance': this.balance,
        'lastUpdated': this.lastUpdated,
        'ownerId': this.ownerId,
      };
  Map<String, dynamic> toJsonWithId() => {
        'id': this.id,
        'balance': this.balance,
        'lastUpdated': this.lastUpdated,
        'ownerId': this.ownerId,
      };
}
