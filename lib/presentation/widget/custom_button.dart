import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_color_constant.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Function() onTap;
   const CustomButton({
    super.key,
    required this.title,
    this.width = double.maxFinite,
    this.height = 50,required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
         onTap:onTap , child:  Container(
      decoration: BoxDecoration(color: AppColors.buttonPrimaryColor),
      width: width,
      height: height,
      child: Center(child: Text(title)),
    ));
  }
}
