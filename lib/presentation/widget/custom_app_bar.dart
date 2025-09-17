import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class CustomAppBar extends StatelessWidget {
  final Function()?onTap;
  const CustomAppBar({super.key,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: (){
          if(onTap!=null){
            onTap!();
            return;
          }
          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back)),
        IconButton(onPressed: (){}, icon:SvgPicture.asset('assets/svgs/notificaiton.svg'))

      ],
    );
  }
}
