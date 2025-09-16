import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviindus_technologies_m_t/presentation/widget/custom_text.dart';

import '../../core/constants/app_color_constant.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final FontWeight titleFontWeight;
  final Color? titleColor;
  final Function() onTap;
  const CustomButton({
    super.key,
    this.titleColor,
    required this.title,
    this.titleFontWeight = FontWeight.w700,
    this.width = double.maxFinite,
    this.height = 50,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color:titleColor==null? AppColors.buttonPrimaryColor: Colors.green.withOpacity(.5) ,
          borderRadius: BorderRadius.circular(8.5),
        ),
        width: width,
        height: height,
        child: Center(
          child: CustomText(
            text: title,
            color: titleColor ?? Colors.white,
            fontWeight:titleColor==null?  titleFontWeight:FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
