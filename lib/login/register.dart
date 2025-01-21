import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/home_screen.dart';
import 'package:event_planning/my_user.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/tabs/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../dialog_utils.dart';
import 'elevated_button.dart';
import 'login.dart';


class Register extends StatefulWidget{
  static const String routeName='register_screen';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var nameController=TextEditingController(text: 'mayar');
  var emailController=TextEditingController(text: 'mayar@gmail.com');
  var passwordController=TextEditingController(text: '123456');
  var rePasswordController=TextEditingController(text: '123456');
  var foemKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var languageProvider=Provider.of<AppLanguageProvider>(context);
    var themeProvider=Provider.of<ThemeProvider>(context);

  return  Scaffold(
    appBar: AppBar(title: Text('Register',style: TextStyle(color: Colors.black),),
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true),
    body: Padding(
      padding:  EdgeInsets.symmetric(horizontal:width*0.03,vertical:height*0.01 ),
      child: SingleChildScrollView(
        child: Form(
          key: foemKey,
          child: Column(
            children: [
              Image.asset('assets/images/logo.png'),
              SizedBox(height: height*0.02,),
              CustomTextField(
                controller: nameController,
                vaidator: (text){
                  if(text==null||text.trim().isEmpty){
                    return 'Please Enter your name';
                  }
                  return null;
                },
                hintText:AppLocalizations.of(context)!.name,
                prefixIcon: Icon(Icons.person),
                iconColor: Colors.grey,
              ),
              SizedBox(height: height*0.02,),
              CustomTextField(
                controller: emailController,
                vaidator: (text){
                  if(text==null||text.trim().isEmpty){
                    return 'Please Enter your email';
                  }
                  final bool emailValid =
                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text);
                  if(!emailValid){
                    return 'Please Enter valid email';
                  }
                  return null;
                } ,
                hintText: AppLocalizations.of(context)!.email,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email),
                iconColor: Colors.grey,
              ),
              SizedBox(height: height*0.02,),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.password,
                obscureText: true,
                keyboardType: TextInputType.number,
                controller: passwordController,
                vaidator: (text){
                  if(text==null||text.trim().isEmpty){
                    return 'Please Enter your Password';
                  }
                  if(text.length<6){
                    return 'Password should be at least 6 chars';
                  }
                  return null;
                },
                prefixIcon: Icon(Icons.lock),
                iconColor: Colors.grey,
                suffixIcon: Icon(Icons.visibility_off),
              ),
              SizedBox(height: height*0.02,),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.rePassword,
                obscureText: true,
                keyboardType: TextInputType.number,
                controller: rePasswordController,
                vaidator: (text){
                  if(text==null||text.trim().isEmpty){
                    return 'Please Enter your Re-Password';
                  }
                  if(text.length<6){
                    return 'Password should be at least 6 chars';
                  }
                  if(text!=passwordController.text){
                    return "Re-password doesn't match password";
                  }
                  return null;
                },
                prefixIcon: Icon(Icons.lock),
                iconColor: Colors.grey,
                suffixIcon: Icon(Icons.visibility_off),
              ),
              SizedBox(height: height*0.02,),
              Row(
                children: [
                  Expanded(
                      child: CustomElevatedButton(
                        onPressed: (){
                          register();
                        },
                        text: AppLocalizations.of(context)!.register,
                      )
                  ),
                ],
              ),
              SizedBox(height: height*0.001,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text(AppLocalizations.of(context)!.alreadyHaveAccount,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17
                      ),),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushNamed(Login.routeName);

                    }, child: Text(
                      AppLocalizations.of(context)!.login,
                      style: TextStyle(fontSize: 17,color: Color(0xff5669FF)),
                    )),
                  ]
              ),
              Container(
                width: width*0.17,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xff5669FF),width: 2,)
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/LR.png'),
                      SizedBox(width: width*0.02),
                      Image.asset('assets/images/EG.png')
                    ]),
              ),
            ],
          ),
        ),
      ),
    ),

  );

  }

  void register()async{
   if(foemKey.currentState?.validate()==true){
     //showLoading
     DialogUtils.showLoading(context: context, msg: 'Loading...');
     try {
       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: emailController.text,
         password: passwordController.text,
       );
       MyUser myUser =MyUser(id: credential.user?.uid??"", email: emailController.text, name: nameController.text);
      await FirebaseUtils.addUserToFireStore(myUser);

      var userProvider=Provider.of<UserProvider>(context,listen: false);
      userProvider.updateUser(myUser);
       //hide loading
       DialogUtils.hideLoading(context: context);
       //showMsg
       DialogUtils.showMsg(context: context, msg: 'register successfully',title: 'success',posActionName: 'Ok',posAction: (){
         Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
       });
       print('register successfully');
       print(credential.user?.uid??'');
     } on FirebaseAuthException catch (e) {
       if (e.code == 'weak-password') {
         //hide loading
         DialogUtils.hideLoading(context: context);
         //showMsg
         DialogUtils.showMsg(context: context, msg: 'the password provider is too weak',title: 'Erorr',posActionName: 'Ok');
         print('The password provided is too weak.');
       } else if (e.code == 'email-already-in-use') {
         //hide loading
         DialogUtils.hideLoading(context: context);
         //showMsg
         DialogUtils.showMsg(context: context, msg: 'The account already exists for that email.',title: 'success',posActionName: 'Ok');
         print('The account already exists for that email.');
       }
     } catch (e) {
       DialogUtils.hideLoading(context: context);
       DialogUtils.showMsg(context: context, msg: e.toString(),title: 'Erorr',posActionName: 'Ok');
       print(e);
     }
   }
  }
}