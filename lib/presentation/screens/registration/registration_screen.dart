import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/constants/app_color_constant.dart';
import 'package:noviindus_technologies_m_t/core/extensions/navigation_extension.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import 'package:noviindus_technologies_m_t/domain/entities/invoice_model.dart';
import 'package:noviindus_technologies_m_t/domain/entities/treatment.dart';
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

import '../../widget/show_patient_dialog.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

List<Treatment> treatments = [];

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.vs(),
              CustomAppBar(),
               Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CustomText(
                  text: 'Register',
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              12.vs(),
              Divider(color: AppColors.borderColor),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.vs(),
                    CustomTextField(
                      title: "Name",
                      hintText: "Enter your full name",
                    ),
                    CustomTextField(
                      title: "Whatsapp Number",
                      hintText: "Enter your Whatsapp number",
                    ),
                    CustomTextField(
                      title: "Address",
                      hintText: "Enter your full address",
                    ),
                    CustomDropdown<String>(
                      title: 'Location',
                      items: ['items', "sdfs0", "sdfsdf"],
                      itemLabel: (item) =>
                          item, // function: take item → return label
                    ),
                    CustomDropdown(
                      hintText: 'Choose your location',
                      title: 'Branch',
                      items: ['items', "sdfs0", "sdfsdf"],
                      onChanged: (val) {
                        print(val);
                      },
                    ),
                    CustomText(text: "Treatment"),
                    5.vs(),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: treatments.length,
                      itemBuilder: (context, index) {
                        var treatment = treatments[index];
                        return TreatmentTile(
                          onDelete: () {
                            treatments.remove(treatment);
                            setState(() {});
                          },
                          onEdit: () {},
                          treatment: Treatment(
                            package: treatment.package,
                            male: treatment.male,
                            female: treatment.female,
                            price: 12,
                          ),
                          index: index,
                        );
                      },
                    ),

                    CustomButton(
                      titleColor: Colors.black,
                      title: "+ Add Treatments",
                      onTap: () async {
                        final result = await showAddPatientDialog(context);
                        if (result != null) {
                          var data = Treatment(
                            package: result['treatment'],
                            male: result['male'],
                            female: result['female'],
                            price: 15,
                          );
                          treatments.add(data);
                          setState(() {});
                        }
                      },
                    ),
                    20.vs(),

                    CustomTextField(title: "Total Amount"),
                    CustomTextField(title: "Discount Amount"),
                    PaymentRadioGroup(
                      onSelectionChanged: (val) {
                        print("val = $val ");
                      },
                    ),
                    20.vs(),
                    CustomTextField(title: "Advance Amount"),
                    CustomTextField(title: "Treatment Amount"),

                    CustomDatePicker(title: 'Treatment Date'),
                    CustomTimeSelector(
                      onTimeSelected: (hour, minute) {
                        debugPrint("Selected time: $hour:$minute");
                      },
                      title: "Select Appointment Time",
                    ),
                    30.vs(),
                    CustomButton(
                      title: "Save",
                      onTap: () {
                        //need to save in server , api status is 500
                        final dummyInvoice = InvoiceModel(
                          bookedOn: '16/09/2025',
                          name: 'John Doe',
                          address: '123 Main Street, Cityville',
                          whatsappNumber: '+919876543210',
                          treatmentDate: '21/02/2024',
                          treatmentTime: '11:00 AM',
                          treatments: [
                            Treatment(
                              package: 'Hair Transplant',
                              price: 2000,
                              female: 2,
                              male: 5,
                            ),
                            Treatment(
                              package: 'PRP Therapy',
                              price: 1500,
                              female: 2,
                              male: 5,
                            ),
                            Treatment(
                              package: 'PRP dsfsd Therapy',
                              price: 1500,
                              female: 2,
                              male: 5,
                            ),
                          ],
                          totalAmount: 3500.0,
                          discountAmount: 500.0,
                          advanceAmount: 1000.0,
                          remainingAmount: 2000.0,
                          balanceAmount: 2500.0,
                        );

                        pushToScreen(
                          InvoiceScreen(invoice: dummyInvoice),
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
        ),
      ),
    );
  }
}
