import 'package:event_planning/app_theme.dart';
import 'package:event_planning/login/login.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/theme_botton_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../language_botton_sheet.dart';


class ProfileScreen extends StatefulWidget{
  static const String routeName='profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var userProvider=Provider.of<UserProvider>(context);
    var themeProvider=Provider.of<ThemeProvider>(context);
    var eventProvider=Provider.of<EventListProvider>(context);

    return Scaffold(
     appBar: AppBar(
       backgroundColor: Color(0xff5669FF),
       title:Row(
           children: [
         Image.asset('assets/images/route_logo.png',width: 90,height: 90,),
         SizedBox(width:width*0.02 ,),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(userProvider.currentUser!.name),
             Text(userProvider.currentUser!.email)
           ],
         )
       ]),
       toolbarHeight: 130,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.only(bottomLeft:Radius.circular(40)),
       ),

     ),
     body: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           SizedBox(height: 15,),
           Text(AppLocalizations.of(context)!.language,style: TextStyle(fontSize: 20,
           color: themeProvider.appTheme==ThemeMode.light?
               Colors.black:
               Colors.white
           ),),
           SizedBox(height: 15,),
           InkWell(
             onTap: (){
               showLanguageBottomSheet();
             },
             child: Container(
               padding: EdgeInsets.all(16),
               decoration:BoxDecoration(
                 borderRadius: BorderRadius.circular(16),
                 border: Border.all(
                   color: Color(0xff5669FF)
                 )
               ),
               child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                 Text(languageProvider.appLanguage=='en'?
                   AppLocalizations.of(context)!.english
                     :
                 AppLocalizations.of(context)!.arabic
                   ,style: TextStyle(fontSize: 20,
                       color: themeProvider.appTheme==ThemeMode.light?
                           Colors.black:
                           Colors.white
                   ),),
                 Icon(Icons.arrow_drop_down_outlined,color: Color(0xff5669FF),),
               ]),
             ),
           ),
           SizedBox(height: 20,),
           Text(AppLocalizations.of(context)!.theme,style: TextStyle(fontSize: 20,
           color: themeProvider.appTheme==ThemeMode.light?
           Colors.black:
            Colors.white
           ),),
           SizedBox(height: 15,),
           InkWell(
             onTap: (){
               showThemeBottomSheet();
             },
             child: Container(
               padding: EdgeInsets.all(16),
               decoration:BoxDecoration(
                   borderRadius: BorderRadius.circular(16),
                   border: Border.all(
                       color: Color(0xff5669FF)
                   )
               ),
               child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(themeProvider.appTheme==ThemeMode.dark?
                     AppLocalizations.of(context)!.dark
                         :
                     AppLocalizations.of(context)!.light
                       ,style: TextStyle(fontSize: 20,
                       color: themeProvider.appTheme==ThemeMode.light?
                        Colors.black:
                        Colors.white
                       ),
                     ),
                     Icon(Icons.arrow_drop_down_outlined,color: Color(0xff5669FF)),
                   ]),
             ),
           ),
           SizedBox(height:languageProvider.appLanguage=='en'?
             height*0.29:
             height*0.23
             ,),
           ElevatedButton(onPressed: (){
             eventProvider.filterList=[];
             Navigator.of(context).pushReplacementNamed(Login.routeName);
           },
               child: Padding(
                 padding: const EdgeInsets.symmetric(
                   horizontal: 10,
                   vertical: 10
                 ),
                 child: Row(
             children: [
                 Icon(Icons.logout,color: Colors.white,),
                 SizedBox(width:width*0.02,),
                 Text(AppLocalizations.of(context)!.logout,style: TextStyle(color: Colors.white),),
             ],
           ),
               ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)))
           ),
         ],
       ),
     ),
   );
  }

  void showLanguageBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (context)=>LanguageBottomSheet()
    );
  }

  void showThemeBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (context)=>ThemeBottomSheet()
    );
  }


}