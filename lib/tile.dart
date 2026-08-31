import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({super.key,
    this.backgroundColor,
    this.icon,
    this.textColor,
    this.iconColor,
    this.name,
    this.press
  });

  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final IconData? icon;
  final String? name;

  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery
        .of(context)
        .size
        .height;
    double sw = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      margin: EdgeInsets.all(sw * 0.01),
      width: sw * 0.7,
      height: sh * 0.08,
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(sw * 0.02)
      ),
      child: Center(
        child: ListTile(
          onTap: press,
          leading: Icon(icon, color: iconColor ?? Colors.black, size: 30,),
          title: Text(name ?? '', style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
