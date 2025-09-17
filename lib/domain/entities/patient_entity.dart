class PatientRegistration {
  String name;
  String executive;
  String payment;
  String phone;
  String address;
  double totalAmount;
  double discountAmount;
  double advanceAmount;
  double balanceAmount;
  String dateAndTime; // Format: "01/02/2024-10:24 AM"
  String id; // empty string if new
  String male; // comma-separated treatment IDs like "2,3,4"
  String female; // comma-separated treatment IDs
  String branch;
  String treatments; // comma-separated treatment IDs

  PatientRegistration({
    this.name = '',
    this.executive = '',
    this.payment = '',
    this.phone = '',
    this.address = '',
    this.totalAmount = 0,
    this.discountAmount = 0,
    this.advanceAmount = 0,
    this.balanceAmount = 0,
    this.dateAndTime = '',
    this.id = '',
    this.male = '',
    this.female = '',
    this.branch = '',
    this.treatments = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'excecutive': executive,
      'payment': payment,
      'phone': phone,
      'address': address,
      'total_amount': totalAmount,
      'discount_amount': discountAmount,
      'advance_amount': advanceAmount,
      'balance_amount': balanceAmount,
      'date_nd_time': dateAndTime,
      'id': id,
      'male': male,
      'female': female,
      'branch': branch,
      'treatments': treatments,
    };
  }
}
