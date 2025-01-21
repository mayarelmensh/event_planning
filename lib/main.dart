import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning/app_theme.dart';
import 'package:event_planning/firebase_options.dart';
import 'package:event_planning/home_screen.dart';
import 'package:event_planning/login/forget_password.dart';
import 'package:event_planning/login/login.dart';
import 'package:event_planning/login/register.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/tabs/home/create_event.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/tabs/home/event_details.dart';
import 'package:event_planning/tabs/home/event_edit.dart';
import 'package:event_planning/tabs/profile/profile_tab.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform
  );


  // await FirebaseFirestore.instance.disableNetwork();
runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>AppLanguageProvider()),
      ChangeNotifierProvider(create: (context)=>ThemeProvider(),),
      ChangeNotifierProvider(create: (context)=>EventListProvider(),),
      ChangeNotifierProvider(create: (context)=>UserProvider(),),

    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var ThemingProvider=Provider.of<ThemeProvider>(context);

   return MaterialApp(
     debugShowCheckedModeBanner: false,
     initialRoute:Login.routeName ,
     routes: {
       HomeScreen.routeName:(context)=>HomeScreen(),
       ProfileScreen.routeName:(context)=>ProfileScreen(),
       Login.routeName:(context)=>Login(),
       Register.routeName:(context)=>Register(),
       ForgetPassword.routeName:(context)=>ForgetPassword(),
       CreateEvent.routeName:(context)=>CreateEvent(),
       EditEvent.routeName:(context)=>EditEvent(),
       EventDetails.routeName:(context)=>EventDetails(),
     },
     localizationsDelegates: AppLocalizations.localizationsDelegates,
     supportedLocales: AppLocalizations.supportedLocales,
     locale: Locale(languageProvider.appLanguage),
     theme: AppTheme.lightMode,
     darkTheme: AppTheme.DarkMode,
     themeMode: ThemingProvider.appTheme,

   );

  }

}