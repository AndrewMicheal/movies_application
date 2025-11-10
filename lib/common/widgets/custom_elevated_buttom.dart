import 'package:flutter/material.dart';
import 'package:movies/core/app_colors.dart';

class CustomElevatedButtom extends StatelessWidget {
  final VoidCallback onPressed;
  String text;
  Color? backgroundColor;
  Color borderColor;
  final TextStyle? textStyle;
  bool hasIcon;
  final Widget? childIconWidget;

  CustomElevatedButtom({super.key , 
    required this.onPressed ,
    required this.text ,
    this.backgroundColor = AppColors.yellow ,
    this.borderColor = AppColors.transparentColor ,
    this.textStyle ,
    this.hasIcon = false ,
    this.childIconWidget
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        onPressed();
    }, child: hasIcon? childIconWidget
   :  Text(text?? '',style: textStyle) ,

    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02
      ),
      elevation: 0,
      backgroundColor: backgroundColor ,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16) ,
        side: BorderSide(
          width: 2 ,
          color: borderColor
        )
      )
    ),

    );
  }
}
