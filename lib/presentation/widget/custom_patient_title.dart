import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/constants/app_color_constant.dart';
 import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import 'package:noviindus_technologies_m_t/core/helper/date_format.dart';
 import 'package:noviindus_technologies_m_t/presentation/widget/custom_text.dart';

import '../../data/model/patient_model.dart';

class CustomPatientTitle extends StatelessWidget {
  final PatientModel patient;
  final int index;

  const CustomPatientTitle({super.key, required this.patient,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 13),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.patientTileBodyFillColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(23.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: '$index',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                14.hs(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: patient.name,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    4.vs(),
                    CustomText(
                      text:patient.name??"No Treatment Selected",
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: AppColors.patientTileSubTitleColor,
                    ),
                    14.vs(),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, color: Colors.red),
                        4.hs(),
                        CustomText(
                          text:formatDate(patient.dateTime??DateTime.now()),
                          color: AppColors.patientTileSubDetailsColor,
                          fontSize: 15,
                        ),
                        22.hs(),
                        Icon(Icons.people_outline, color: Colors.red),
                        4.hs(),
                        CustomText(
                          text: patient.name,
                          color: AppColors.patientTileSubDetailsColor,
                          fontSize: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: AppColors.borderColor),
          9.vs(),
          InkWell(
            onTap: (){
              //todo: ask what need to do
             },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: 'View Booking details',
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.green),
              ],
            ),
          ),
          9.vs(),
        ],
      ),
    );
  }
}
