import 'package:noviindus_technologies_m_t/domain/entities/treatment.dart';

class InvoiceModel {
  final String bookedOn;
  String name;
  String address;
  String whatsappNumber;
  String treatmentDate; // format: "21/02/2024"
  String treatmentTime; // format: "11:00 am"
  List<Treatment> treatments;
  double totalAmount;
  double discountAmount;
  double remainingAmount;
  double advanceAmount;
  double balanceAmount;

  InvoiceModel({
    required this.bookedOn,
    required this.balanceAmount,
    required this.name,
    required this.address,
    required this.whatsappNumber,
    required this.treatmentDate,
    required this.treatmentTime,
    required this.treatments,
    required this.totalAmount,
    required this.discountAmount,
    required this.remainingAmount,
    required this.advanceAmount,
  });

 /* factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      balaceAmount: json['balance'],
      name: json['name'],
      address: json['address'],
      whatsappNumber: json['whatsappNumber'],
      treatmentDate: json['treatmentDate'],
      treatmentTime: json['treatmentTime'],
      treatments: (json['treatments'] as List)
          .map((e) => Treatment.fromJson(e))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      remainingAmount: (json['remainingAmount'] as num).toDouble(),
      advanceAmount: (json['advanceAmount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'whatsappNumber': whatsappNumber,
      'treatmentDate': treatmentDate,
      'treatmentTime': treatmentTime,
      'treatments': treatments.map((e) => e.toJson()).toList(),
      'totalAmount': totalAmount,
      'discountAmount': discountAmount,
      'remainingAmount': remainingAmount,
      'advanceAmount': advanceAmount,
    };
  }*/
}
