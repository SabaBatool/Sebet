class Signup2Data {
  final String uid;
  final String city;
  final String state;
  final String zipcode;
  final String referralCode;
  final String description;

  Signup2Data({
    required this.uid,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.referralCode,
    required this.description,
  });

  factory Signup2Data.fromMap(Map<String, dynamic> map) {
    return Signup2Data(
      uid: map['uid'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipcode: map['zipcode'] ?? '',
      referralCode: map['referralCode'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'city': city,
      'state': state,
      'zipcode': zipcode,
      'referralCode': referralCode,
      'description': description,
    };
  }
}
