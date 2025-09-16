class Patient {
  final int id;
  final String name;
  final String phone;
  final String address;
  final int? totalAmount;
  final int? discountAmount;
  final int? advanceAmount;
  final int? balanceAmount;
  final String? payment;
  final DateTime? dateTime;

  Patient({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    this.totalAmount,
    this.discountAmount,
    this.advanceAmount,
    this.balanceAmount,
    this.payment,
    this.dateTime,
  });
}
