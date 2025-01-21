import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget{

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var themingProvider=Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: themingProvider.appTheme==ThemeMode.light?
        Colors.white:
        Color(0xff101127)
        ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                themingProvider.changeTheme(ThemeMode.dark);
              },
              child:themingProvider.appTheme==ThemeMode.dark ?
                  selectedLanguage(AppLocalizations.of(context)!.dark)
                  :
                  unSelectedLanguage(AppLocalizations.of(context)!.dark)
            ),
            SizedBox(height: height*0.02,),
            InkWell(
                onTap: (){
                  themingProvider.changeTheme(ThemeMode.light);
                },
                child:
                themingProvider.appTheme==ThemeMode.light?
                   selectedLanguage(AppLocalizations.of(context)!.light)
                    :
                unSelectedLanguage(AppLocalizations.of(context)!.light)
            ),
          ],
        ),
      ),
    );
  }

  Widget selectedLanguage(String text){   //tybe of widget because it return widget ex row or text
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,style: TextStyle(fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff5669FF)
        ),),
        Icon(Icons.check,color: Color(0xff5669FF)),
      ],
    );
  }

  Widget unSelectedLanguage(String text){
    return Text(text,
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold));
  }
}