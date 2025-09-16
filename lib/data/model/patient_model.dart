import '../../domain/entities/patient.dart';

class PatientModel extends Patient {
  PatientModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.address,
    super.totalAmount,
    super.discountAmount,
    super.advanceAmount,
    super.balanceAmount,
    super.payment,
    super.dateTime,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      totalAmount: json['total_amount'],
      discountAmount: json['discount_amount'],
      advanceAmount: json['advance_amount'],
      balanceAmount: json['balance_amount'],
      payment: json['payment'],
      dateTime: json['date_nd_time'] != null
          ? DateTime.tryParse(json['date_nd_time'])
          : null,
    );
  }

  static List<PatientModel> fromJsonList(List<dynamic> list) {
    return list.map((e) => PatientModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'total_amount': totalAmount,
      'discount_amount': discountAmount,
      'advance_amount': advanceAmount,
      'balance_amount': balanceAmount,
      'payment': payment,
      'date_nd_time': dateTime?.toIso8601String(),
    };
  }
}
