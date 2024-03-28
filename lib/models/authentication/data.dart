class Data {
  final String phoneNumber;

  Data({required this.phoneNumber});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}
