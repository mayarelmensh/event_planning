import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_language_provider.dart';
import '../../providers/app_theme_provider.dart';

class HomeTabs extends StatelessWidget{
String eventName;
bool isSelected;
Color?backgroundOfTab;
TextStyle?textSelectedStyle;
TextStyle?textUnSelectedStyle;
Color?borderColor;
HomeTabs({required this.eventName,required this.isSelected,
  required this.backgroundOfTab,required this.textSelectedStyle,required this.textUnSelectedStyle,
 this.borderColor
});
  @override
  Widget build(BuildContext context){
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var themeProvider=Provider.of<ThemeProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width*0.02),
        padding: EdgeInsets.symmetric(horizontal:width*0.02,vertical:height*0.006),
      decoration: BoxDecoration(
        color: isSelected?backgroundOfTab :Colors.transparent,
        // (themeProvider.appTheme==ThemeMode.light?Colors.white:Color(0xff5669FF)):
        // (themeProvider.appTheme==ThemeMode.light?Color(0xff5669FF)
        borderRadius: BorderRadius.circular(20),
        border:Border.all(
         color: borderColor??Colors.white,
         // themeProvider.appTheme==ThemeMode.light?

          width: 2
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.02),
        child: Text(
          eventName,
          style:
          isSelected?textSelectedStyle:textUnSelectedStyle,
          // TextStyle(
          //     fontSize: 16,color:themeProvider.appTheme==ThemeMode.light?
          // Color(0xff5669FF):
          // Colors.white
          // ):
          // TextStyle(
             // fontSize: 16,color: Colors.white
          ),
        ),
    );
  }

}