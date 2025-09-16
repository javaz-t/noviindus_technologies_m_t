import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/constants/app_color_constant.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import 'package:noviindus_technologies_m_t/domain/entities/treatment.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_text.dart';


class TreatmentTile extends StatelessWidget {
  final Treatment treatment;
  final int index;
  final Function() onDelete;
  final Function() onEdit;

  const TreatmentTile({
    super.key,
    required this.treatment,
    required this.index,
    required this.onDelete,
    required this.onEdit,
  });

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
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ).copyWith(right: 0, bottom: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                CustomText(
                  text: '$index.',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                14.hs(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: treatment.package,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ],
                    ),
                    6.vs(),
                    Row(
                      children: [
                        _buildCountBox('Male', treatment.male),
                        20.hs(),
                        _buildCountBox('Female', treatment.female),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: onDelete,
                      child: CircleAvatar(
                        maxRadius: 13,
                        backgroundColor: Colors.red,
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                    5.vs(),
                    GestureDetector(
                      onTap: onEdit,
                      child: Icon(
                        Icons.mode_edit_outlined,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          9.vs(),
        ],
      ),
    );
  }

  Widget _buildCountBox(String label, int count) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(color: AppColors.buttonPrimaryColor, fontSize: 16),
        ),
        const SizedBox(width: 4.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              color: AppColors.buttonPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
