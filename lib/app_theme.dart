import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme{

  static final ThemeData lightMode=ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white
    ),
      appBarTheme: AppBarTheme(
        elevation: 0,
      backgroundColor: Color(0xff5669FF),
    ),
    primaryColor: AppColors.primaryColorLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showUnselectedLabels: true,
        elevation: 0,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(fontWeight:FontWeight.bold ,fontSize: 12)
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
       backgroundColor: AppColors.primaryColorLight,
       shape: RoundedRectangleBorder(
         side: BorderSide(color: Colors.white,width: 4),
         borderRadius: BorderRadius.circular(35)
       )
    )
  );
  static final ThemeData DarkMode=ThemeData(
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Color(0xff101127)
  ),
    scaffoldBackgroundColor:Color(0xff101127) ,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Color(0xff101127)
    ),
    primaryColor: AppColors.primaryColorDark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: true,
          elevation: 0,
          showSelectedLabels: true,
          selectedLabelStyle: TextStyle(fontWeight:FontWeight.bold ,fontSize: 12)
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColorDark,
       shape: RoundedRectangleBorder(
       side: BorderSide(color: Colors.white,width: 4),
   borderRadius: BorderRadius.circular(35)
      )
  )
  );
}