import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:noviindus_technologies_m_t/data/repository/register_repository.dart';

import '../../domain/entities/invoice_model.dart';
import '../../domain/entities/treatment.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterRepository _repository;
  RegisterProvider(this._repository);
  // Private fields
  String _name = '';
  String _whatsappNumber = '';
  String _address = '';
  String _location = '';
  String _branch = '';
  String _paymentOption = '';
  List<Treatment> treatments = [];

  DateTime _treatmentDate = DateTime.now(); // format: dd/MM/yyyy
  String _treatmentTime = ''; // format: hh:mm a

  int? _totalAmount;
  int? _discountAmount;
  int? _advanceAmount;
  int? _treatmentAmount;
  // ------------------------
  // Setters / onChange Methods
  // ------------------------
  void onNameChanged(String val) => _name = val.trim();
  void onWhatsappChanged(String val) => _whatsappNumber = val.trim();
  void onAddressChanged(String val) => _address = val.trim();
  void onLocationChanged(String val) => _location = val.trim();
  void onBranchChanged(String val) => _branch = val.trim();
  void onPaymentOptionChanged(String val) => _paymentOption = val.trim();
  void onDateChanged(DateTime val) => _treatmentDate = val;
  void onTimeChanged(String val) => _treatmentTime = val.trim();

  void onTotalAmountChanged(String val) {
    _totalAmount = int.tryParse(val.trim());
  }

  void onTreatmentAmountChanged(String val) {
    _treatmentAmount = int.tryParse(val.trim());
  }

  void onDiscountAmountChanged(String val) {
    _discountAmount = int.tryParse(val.trim());
  }

  void onAdvanceAmountChanged(String val) {
    _advanceAmount = int.tryParse(val.trim());
  }

  // ------------------------
  // Validation
  // ------------------------
  bool isFormValid() {
    return _name.isNotEmpty &&
        _whatsappNumber.isNotEmpty &&
        _address.isNotEmpty &&
        _location.isNotEmpty &&
        _branch.isNotEmpty &&
        _paymentOption.isNotEmpty &&
        _treatmentTime.isNotEmpty &&
        _totalAmount != null &&
        _discountAmount != null &&
        _advanceAmount != null &&
        _treatmentAmount != null &&
        treatments.isNotEmpty;
  }

  List<String> _branchNames = [];
  List<String> _treatmentNames = [];

  bool _isLoading = false;

  List<String> get branchNames => _branchNames;
  bool get isLoading => _isLoading;
  List<String> get treatmentNames => _treatmentNames;

  Future<void> loadBranchesAndTreatments() async {
    _isLoading = true;
    notifyListeners();

    _branchNames = await _repository.getBranchNames();
    _treatmentNames = await _repository.getTreatmentNames();
    _isLoading = false;
    notifyListeners();
  }

  InvoiceModel getInvoiceData() {
    return InvoiceModel(
      bookedOn: DateTime.now().toString(), // or format it properly
      name: _name,
      address: _address,
      whatsappNumber: _whatsappNumber,
      treatmentDate: _treatmentDate.toString(), // format with intl if needed
      treatmentTime: _treatmentTime,
      treatments: treatments,
      totalAmount: (_totalAmount ?? 0).toDouble(),
      discountAmount: (_discountAmount ?? 0).toDouble(),
      advanceAmount: (_advanceAmount ?? 0).toDouble(),
      remainingAmount:
      ((_totalAmount ?? 0) - (_discountAmount ?? 0) - (_advanceAmount ?? 0))
          .toDouble(),
      balanceAmount:
      ((_treatmentAmount ?? 0) - (_advanceAmount ?? 0)).toDouble(),
    );
  }
}
