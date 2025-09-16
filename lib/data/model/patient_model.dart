import '../../domain/entities/patient.dart';

class PatientModel extends Patient {
  final List<PatientDetailModel> patientDetails;
  final BranchModel? branch;

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
    this.patientDetails = const [],
    this.branch,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      totalAmount: json['total_amount'],
      discountAmount: json['discount_amount'],
      advanceAmount: json['advance_amount'],
      balanceAmount: json['balance_amount'],
      payment: json['payment']?.toString(),
      dateTime: json['date_nd_time'] != null
          ? DateTime.tryParse(json['date_nd_time'].toString())
          : null,
      patientDetails: (json['patientdetails_set'] as List<dynamic>?)
          ?.map((e) => PatientDetailModel.fromJson(e))
          .toList() ??
          [],
      branch:
      json['branch'] != null ? BranchModel.fromJson(json['branch']) : null,
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
      'patientdetails_set': patientDetails.map((e) => e.toJson()).toList(),
      'branch': branch?.toJson(),
    };
  }
}

class PatientDetailModel {
  final int id;
  final String male;
  final String female;
  final int patient;
  final String? treatment;

  PatientDetailModel({
    required this.id,
    required this.male,
    required this.female,
    required this.patient,
    this.treatment,
  });

  factory PatientDetailModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailModel(
      id: json['id'],
      male: json['male']?.toString() ?? '',
      female: json['female']?.toString() ?? '',
      patient: json['patient'],
      treatment: json['treatment']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'male': male,
      'female': female,
      'patient': patient,
      'treatment': treatment,
    };
  }
}

class BranchModel {
  final int id;
  final String name;
  final int patientsCount;
  final String location;
  final String phone;
  final String mail;
  final String address;
  final String gst;
  final bool isActive;

  BranchModel({
    required this.id,
    required this.name,
    required this.patientsCount,
    required this.location,
    required this.phone,
    required this.mail,
    required this.address,
    required this.gst,
    required this.isActive,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      name: json['name']?.toString() ?? '',
      patientsCount: json['patients_count'] ?? 0,
      location: json['location']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      mail: json['mail']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      gst: json['gst']?.toString() ?? '',
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'patients_count': patientsCount,
      'location': location,
      'phone': phone,
      'mail': mail,
      'address': address,
      'gst': gst,
      'is_active': isActive,
    };
  }
}
