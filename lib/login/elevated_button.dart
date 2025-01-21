import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../home_screen.dart';
import '../providers/app_language_provider.dart';
import '../providers/app_theme_provider.dart';


class CustomElevatedButton extends StatelessWidget{
  String text;
  Color? colorOfButton;
  Color?colorOfText;
  TextStyle?textStyle;
  Widget? icon;
  Function?onPressed;
  CustomElevatedButton({required this.text, this.colorOfButton,this.icon,this.textStyle,
    this.colorOfText,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var themeProvider=Provider.of<ThemeProvider>(context);
    return  ElevatedButton(
        onPressed: (){
          onPressed!();

        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon??SizedBox(),
              SizedBox(width: width*0.02,),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: height*0.0062,),
                child: Text(text,style: TextStyle(color:colorOfText??Colors.white,fontSize: 20),),
              ),
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: colorOfButton??Color(0xff5669FF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
            side: BorderSide(
              color: Color(0xff5669FF),
              width: 1,
            )
            ))
    );
  }

}