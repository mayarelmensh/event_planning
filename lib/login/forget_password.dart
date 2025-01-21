import 'package:event_planning/login/elevated_button.dart';
import 'package:event_planning/login/login.dart';
import 'package:event_planning/tabs/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ForgetPassword extends StatefulWidget{
  static const String routeName='forget_password';
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forgetPassword,style: TextStyle(color: Colors.black87)),
      iconTheme: IconThemeData(color: Colors.black87),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      ),
       body:  Padding(
         padding:  EdgeInsets.symmetric(vertical:height*0.02 ,horizontal: width*0.05),
         child: SingleChildScrollView(
           child: Column(
             children: [
               Image.asset('assets/images/change-setting.png',
                 // width: width*0.6,
                 // height: height*0.6,
               ),
               CustomTextField(hintText: AppLocalizations.of(context)!.email,
                 prefixIcon: Icon(Icons.email),
               ),
               SizedBox(height: height*0.03,),
               CustomElevatedButton(text: AppLocalizations.of(context)!.resetPassword,
                   onPressed: resetPassword)
             ],
           ),
         ),
       ),
    );
  }

void resetPassword(){
    Navigator.of(context).pushReplacementNamed(Login.routeName);
}
}