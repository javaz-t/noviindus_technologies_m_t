import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/constants/app_color_constant.dart';
import 'package:noviindus_technologies_m_t/core/extensions/sized_box_extension.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_text.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String title;
  final String? hintText;
  final List<T> items;
  final T? value;
  final void Function(T?)? onChanged;
  final String Function(T)? itemLabel;

  const CustomDropdown({
    super.key,
    required this.title,
    required this.items,
    this.hintText,
    this.value,
    this.onChanged,
    this.itemLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title),
        5.vs(),
        DropdownButtonFormField<T>(
          value: value,
          isExpanded: true,
          onChanged: onChanged,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          decoration: InputDecoration(
            hintText: hintText,

            hintStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.w200),
            filled: true,
            fillColor: AppColors.tileBodyFillColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.textFieldBorderColor,
                width: .850,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(8.5),
            ),
          ),
          items: items.map((e) {
            return DropdownMenuItem<T>(
              value: e,
              child: Text(itemLabel?.call(e) ?? e.toString()),
            );
          }).toList(),
        ),
        25.vs(),
      ],
    );
  }
}
