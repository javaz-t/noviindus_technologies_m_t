import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noviindus_technologies_m_t/core/constants/app_constant.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_text.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String? hintText;
  final bool isNumbersOnlyAllowed;
  final void Function(String)? onChanged;
  const CustomTextField({
    super.key,
    required this.title,
    this.isNumbersOnlyAllowed = false,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title),
        5.vs(),
        TextField(
          inputFormatters: isNumbersOnlyAllowed
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          onChanged: onChanged,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppConstants.textFieldHintTextColor),
            filled: true,
            fillColor: AppConstants.tileBodyFillColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppConstants
                    .textFieldBorderColor, // Change to your desired color
                width: .850,
              ),
            ), // background like your screenshot
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
