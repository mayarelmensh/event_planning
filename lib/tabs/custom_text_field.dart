import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  Color ? borderColor;
  String? hintText;
  TextStyle? hintStyle;
  Widget?prefixIcon;
  Widget?suffixIcon;
  int?maxlines;
  Color? iconColor;
  bool obscureText;
  TextInputType? keyboardType;
  String? Function(String?)? vaidator;
  TextEditingController?controller;
  CustomTextField({this.obscureText=false,this.borderColor,required this.hintText, this.hintStyle,
    this.prefixIcon,this.suffixIcon,this.iconColor,this.maxlines,this.vaidator,this.controller,this.keyboardType=TextInputType.text});
  @override
  Widget build(BuildContext context) {
   return TextFormField(
     obscureText:obscureText ,
     keyboardType: keyboardType,
     controller: controller,
     validator: vaidator,
     maxLines: maxlines?? 1,
     decoration: InputDecoration(
       hintText: hintText,
       hintStyle: hintStyle,
       prefixIcon: prefixIcon,
       prefixIconColor: iconColor,
       suffixIcon: suffixIcon,
       enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(16),
         borderSide: BorderSide(color: borderColor??Color(0xff7B7B7B))
       ),
       focusedBorder:OutlineInputBorder(
           borderRadius: BorderRadius.circular(16),
           borderSide: BorderSide(color: borderColor??Color(0xff7B7B7B))
       ),
       errorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(16),
           borderSide: BorderSide(color: Colors.red)
       ),
       focusedErrorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(16),
           borderSide: BorderSide(color:Colors.red)
       ),
     ),

   );
  }

}