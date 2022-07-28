import 'package:flutter/material.dart';
import 'package:todo/presentation/style/colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color background;
  final double height;
  final double width;
  final double radius;
  final VoidCallback onClick;
  final BuildContext? context;

  const AppButton({Key? key,
    required this.text,
    required this.onClick,
    this.textColor = Colors.white,
    this.background = AppColors.green,
    this.height = 52,
    this.width = double.infinity,
    this.radius = 15,
    this.context,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: onClick,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              color: textColor,
                fontFamily: 'Edu',
                fontWeight: FontWeight.w600
            ),
          ),
        ),
      ),
    );
  }}