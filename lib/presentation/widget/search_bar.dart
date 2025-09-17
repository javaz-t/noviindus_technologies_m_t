import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/core/constants/app_color_constant.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_button.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onChange;
  final Function() onSearchTap;
  const HomeSearchBar({
    super.key,
    required this.onChange,
    required this.onSearchTap,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(

            controller: searchController,
            onChanged: onChange,
            decoration: InputDecoration(
              hintText: 'Search for treatments',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:AppColors.textFieldHintTextColor, // Change to your desired color
                  width: .850,
                ),
              ),
              hintStyle: TextStyle(color: AppColors.borderColor),
              prefixIcon: Icon(Icons.search_sharp,color: AppColors.borderColor,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 26),
            ),
          ),
        ),
        const SizedBox(width: 10),
        CustomButton(title: 'Search', onTap: onSearchTap,width: 100,titleFontWeight: FontWeight.w500,),
      ],
    );
  }
}
