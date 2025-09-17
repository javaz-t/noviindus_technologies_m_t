import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/constants/app_constant.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import 'package:noviindus_technologies_m_t/core/helper/result_dialog.dart';
 import 'package:noviindus_technologies_m_t/domain/entities/treatment.dart';
import 'package:noviindus_technologies_m_t/presentation/providers/register_provider.dart';
import 'package:noviindus_technologies_m_t/presentation/screens/invoice/invoice_screen.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_app_bar.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_button.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_date_picker.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_drop_down.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_text.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_text_field.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_time_picker.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/payment_radio.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/treatment_title.dart';
import 'package:provider/provider.dart';
import '../../../core/extensions/navigation_extension.dart';
import '../../widget/show_patient_dialog.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchBranches();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<RegisterProvider>(
          builder: (context, registerProvider, _) {
            if (registerProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.vs(),
                  const CustomAppBar(),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CustomText(
                      text: 'Register',
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  12.vs(),
                  Divider(color: AppConstants.borderColor),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.vs(),
                        CustomTextField(
                          onChanged: registerProvider.onNameChanged,
                          title: "Name",
                          hintText: "Enter your full name",
                        ),
                        CustomTextField(
                          onChanged: registerProvider.onWhatsappChanged,
                          title: "Whatsapp Number",
                          hintText: "Enter your Whatsapp number",
                        ),
                        CustomTextField(
                          onChanged: registerProvider.onAddressChanged,
                          title: "Address",
                          hintText: "Enter your full address",
                        ),
                        CustomDropdown<String>(
                          title: 'Location',
                          items: AppConstants.locationsInKerala,
                          itemLabel: (item) => item,
                          onChanged: (val) {
                            if (val == null) {
                              return;
                            }
                            registerProvider.onLocationChanged(val);
                          },
                        ),
                        CustomDropdown(
                          hintText: 'Choose your branch',
                          title: 'Branch',
                          items: registerProvider.branchNames,
                          onChanged: (val) {
                            if (val == null) {
                              return;
                            }
                            registerProvider.onBranchChanged(val);
                          },
                        ),
                        const CustomText(text: "Treatment"),
                        5.vs(),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: registerProvider.treatments.length,
                          itemBuilder: (context, index) {
                            var treatment = registerProvider.treatments[index];
                            return TreatmentTile(
                              onDelete: () {
                                registerProvider.treatments.remove(treatment);
                                setState(() {});
                              },
                              onEdit: () {},
                              treatment: Treatment(
                                package: treatment.package,
                                male: treatment.male,
                                female: treatment.female,
                                price: treatment.price,
                              ),
                              index: index,
                            );
                          },
                        ),
                        CustomButton(
                          titleColor: Colors.black,
                          title: "+ Add Treatments",
                          onTap: () async {
                            final result = await showAddPatientDialog(
                              context,
                              registerProvider.treatmentNames,
                            );
                            if (result != null) {
                              var data = Treatment(
                                package: result['treatment'],
                                male: result['male'],
                                female: result['female'],
                                price: 15,
                              );
                              registerProvider.treatments.add(data);
                              setState(() {});
                            }
                          },
                        ),
                        20.vs(),
                        CustomTextField(
                          isNumbersOnlyAllowed: true,

                          title: "Total Amount",
                          onChanged: registerProvider.onTotalAmountChanged,
                        ),
                        CustomTextField(
                          isNumbersOnlyAllowed: true,

                          title: "Discount Amount",
                          onChanged: registerProvider.onDiscountAmountChanged,
                        ),
                        PaymentRadioGroup(
                          onSelectionChanged: (val) {
                            if (val == null) {
                              return;
                            }
                            registerProvider.onPaymentOptionChanged(val);
                          },
                        ),
                        20.vs(),
                        CustomTextField(
                          isNumbersOnlyAllowed: true,
                          title: "Advance Amount",
                          onChanged: registerProvider.onAdvanceAmountChanged,
                        ),
                        CustomTextField(
                          isNumbersOnlyAllowed: true,

                          title: "Treatment Amount",
                          onChanged: (val) {
                            registerProvider.onTreatmentAmountChanged(val);
                          },
                          // You may calculate & display remaining amount instead
                        ),
                        CustomDatePicker(
                          title: 'Treatment Date',
                          onDateSelected: (val) {
                            registerProvider.onDateChanged(val);
                          },
                        ),
                        CustomTimeSelector(
                          title: "Select Appointment Time",
                          onTimeSelected: (hour, minute) {
                            final formatted =
                                "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
                            registerProvider.onTimeChanged(formatted);
                          },
                        ),
                        30.vs(),
                        CustomButton(
                          title: "Save",
                          onTap: () {
                            if (registerProvider.isFormValid()) {
                              ToastUtils.showSuccess(context, 'Good ');
                            } else {
                              ToastUtils.showError(
                                context,
                                'some fields are not filled ',
                              );
                              return;
                            }
                            /// TODO: Replace dummyInvoice with real API call
                            pushToScreen(
                              InvoiceScreen(
                                invoice: registerProvider.getInvoiceData(),
                              ),
                              context,
                            );
                          },
                        ),
                        50.vs(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _fetchBranches() {
    final branchProvider = Provider.of<RegisterProvider>(
      context,
      listen: false,
    );
    branchProvider.loadBranchesAndTreatments();
  }
}
