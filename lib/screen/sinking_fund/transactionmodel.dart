class DepositDataModel {
  final String date;
  final String time;
  final double amount;

  DepositDataModel({
    required this.date,
    required this.time,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'time': time,
      'amount': amount,
    };
  }

  factory DepositDataModel.fromMap(Map<String, dynamic> map) {
    return DepositDataModel(
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
    );
  }
}
