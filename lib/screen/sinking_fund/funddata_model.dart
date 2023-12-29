class FundData {
  String fundName;
  double amountOfGoal;
  DateTime selectedDate;
  int monthsToAchieveGoal;
  double monthlydepositAmount;
  double? adddepositAmount;
  String? documentId;


  FundData({
    required this.fundName,
    required this.amountOfGoal,
    required this.selectedDate,
    required this.monthsToAchieveGoal,
    required this.monthlydepositAmount,
    required this.adddepositAmount,
    required this.documentId,
  });


  Map<String, dynamic> toMap() {
    return {
      'fundName': fundName,
      'amountOfGoal': amountOfGoal,
      'selectedDate': selectedDate.toIso8601String(),
      'monthsToAchieveGoal': monthsToAchieveGoal,
      'documentId':documentId,
      'depositAmount': monthlydepositAmount,
      'adddepositAmount': adddepositAmount,

    };
  }


  factory FundData.fromMap(Map<String, dynamic> map,) {
    return FundData(
      fundName: map['fundName'],
      amountOfGoal: map['amountOfGoal'],
      selectedDate: DateTime.parse(map['selectedDate']),
      monthsToAchieveGoal: map['monthsToAchieveGoal'],
      monthlydepositAmount: map['depositAmount'],
      adddepositAmount: map['adddepositAmount'],
      documentId: map['documentId'],
    );
  }
}
