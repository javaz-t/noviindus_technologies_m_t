import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/constants/app_color_constant.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_text.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String? hintText;
  final void Function(String)? onChanged;
  const CustomTextField({super.key,required this.title, this.onChanged, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title),
        5.vs(),
        TextField(
          onChanged: onChanged,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.textFieldHintTextColor),
            filled: true,
            fillColor: AppColors.tileBodyFillColor ,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:AppColors.textFieldBorderColor, // Change to your desired color
                width: .850,
              ),
            ),// background like your screenshot
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
             ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(8.5),
            ),
          ),
        ),
        25.vs(),
      ],
    );
  }
}
