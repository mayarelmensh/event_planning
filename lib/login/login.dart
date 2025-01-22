import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/home_screen.dart';
import 'package:event_planning/login/elevated_button.dart';
import 'package:event_planning/login/forget_password.dart';
import 'package:event_planning/login/login_navigator.dart';
import 'package:event_planning/login/login_view_model.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/register/register.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/tabs/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../dialog_utils.dart';


class Login extends StatefulWidget{
  static const String routeName='login_screen';



  @override
  State<Login> createState() => _LoginState();

}

class _LoginState extends State<Login> implements LoginNavigator {
  LoginViewModel viewModel = LoginViewModel();

  @override
  void initState(){
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.069),
          child: SingleChildScrollView(
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png'),
                  SizedBox(height: height * 0.02,),
                  CustomTextField(
                    controller: viewModel.emailController,
                    hintText: AppLocalizations.of(context)!.email,
                    vaidator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return 'Please Enter your email';
                      }
                      final bool emailValid =
                      RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return 'Please Enter valid email';
                      }
                      return null;
                    },
                    prefixIcon: Icon(Icons.email),
                    iconColor: Colors.grey,
                  ),
                  SizedBox(height: height * 0.02,),
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.password,
                    obscureText: true,
                    vaidator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return 'Please Enter your Password';
                      }
                      if (text.length < 6) {
                        return 'Password should be at least 6 chars';
                      }
                      return null;
                    },
                    controller: viewModel.passwordController,
                    prefixIcon: Icon(Icons.email),
                    iconColor: Colors.grey,
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(ForgetPassword
                                .routeName);
                          }, child: Text(
                        AppLocalizations.of(context)!.forgetPassword,
                        style: TextStyle(
                          color: Color(0xff5669FF),
                          fontSize: 16,
                        ),
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomElevatedButton(
                            onPressed: viewModel.login,
                            text: AppLocalizations.of(context)!.login,
                          )
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.dontHaveAccount,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                          ),),
                        TextButton(onPressed: () {
                          Navigator.of(context).pushNamed(Register.routeName);
                        }, child: Text(
                          AppLocalizations.of(context)!.createAccount,
                          style: TextStyle(fontSize: 16,
                              color: Color(0xff5669FF)),
                        ))
                      ]
                  ),
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 1.5, color: Color(
                          0xff5669FF), indent: 20, endIndent: 20,)),
                      Text(AppLocalizations.of(context)!.or,
                        style: TextStyle(color: Color(0xff5669FF)),),
                      Expanded(child: Divider(thickness: 1.5, color: Color(
                          0xff5669FF), indent: 20, endIndent: 20,)),
                    ],
                  ),
                  SizedBox(height: height * 0.03,),
                  CustomElevatedButton(
                    text: AppLocalizations.of(context)!.loginWithGoogle,
                    onPressed: () {},
                    colorOfText: Color(0xff5669FF),
                    icon: Image.asset('assets/images/google.png'),
                    colorOfButton: Colors.transparent,
                  ),
                  SizedBox(height: height * 0.02,),
                  Container(
                    width: width * 0.17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xff5669FF), width: 2,)
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/LR.png'),
                          SizedBox(width: width * 0.02),
                          Image.asset('assets/images/EG.png')
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



    @override
    void hideMyLoading(){
      DialogUtils.hideLoading(context: context);
    }

    @override
    void showMyLoading(String message) {
      DialogUtils.showLoading(context: context, msg: message);
    }

    @override
    void showMyMessage(String message) {
      DialogUtils.showMsg(context: context, msg: message, posActionName: 'Ok');
    }
  }
