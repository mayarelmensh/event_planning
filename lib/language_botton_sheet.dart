import 'package:event_planning/providers/app_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget{

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              languageProvider.changeAppLanguage('en');
            },
            child:languageProvider.appLanguage=='en' ?
                selectedLanguage(AppLocalizations.of(context)!.english)
                :
                unSelectedLanguage(AppLocalizations.of(context)!.english)
          ),
          SizedBox(height: height*0.02,),
          InkWell(
              onTap: (){
                languageProvider.changeAppLanguage('ar');
              },
              child:
              languageProvider.appLanguage=='ar'?
                 selectedLanguage(AppLocalizations.of(context)!.arabic)
                  :
              unSelectedLanguage(AppLocalizations.of(context)!.arabic)



          ),
        ],
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