import 'package:flutter/material.dart';
import '../../core/constants/app_color_constant.dart';
import 'custom_text.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: 'Sort by:'),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(24),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: 'Date',
              items: const [
                DropdownMenuItem(
                  value: 'Date',
                  child: SizedBox(
                    width: 100,
                    height: 30,
                    child: CustomText(
                      text: 'Date',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // Add more sort options if needed
              ],
              onChanged: (value) {
                if (value != null) {

                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
