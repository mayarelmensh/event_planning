import 'package:event_planning/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  //hold data- handle logic
  var emailController = TextEditingController(
      text: 'mayar@gmail.com'); //'mayar@gmail.com'
  var passwordController = TextEditingController(text: '123456'); //'123456'
  late LoginNavigator navigator;
  var formKey = GlobalKey<FormState>();

  // hold data - handle logic
  void login() async {
    if (formKey.currentState?.validate() == true) {
      navigator.showMyLoading('waiting...');
      // DialogUtils.showLoading(context: context, msg: 'waiting...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        // var user=await FirebaseUtils.readUserFromFireStore(credential.user?.uid??'');
        // if(user==null){
        //   return;
        // }
        // if (credential.user != null) {
        //   var user = await FirebaseUtils.readUserFromFireStore(credential.user!.uid);
        //   if (user != null) {
        //     Provider.of<UserProvider>(context, listen: false).updateUser(user);
        //   }
        // }

        //hide loading
        navigator.hideMyLoading();
        // DialogUtils.hideLoading(context: context);
        //showMsg
        navigator.showMyMessage('login successfully');
        // DialogUtils.showMsg(context: context,
        //     msg: 'login successfully',title: 'success',posActionName: 'Ok',posAction: (){
        //   Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        // });
        print('login successfully');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //todo:hideLoading
          navigator.hideMyLoading();
          //todo:showMessage
          navigator.showMyMessage('No user found for that email.');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          //todo:hideLoading
          navigator.hideMyLoading();
          //todo:showMessage
          navigator.showMyMessage('Wrong password provided for that user.');
          print('Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          //hide loading
          navigator.hideMyLoading();
          // DialogUtils.hideLoading(context: context);
          //showMsg
          navigator.showMyMessage(
              'The supplied auth credential is incorrect,,,malformed or has expired');
          //   DialogUtils.showMsg(context: context,
          //       msg: 'The supplied auth credential is incorrect,,,malformed or has expired',title: 'Erorr',posActionName: 'Ok');
          //   print('The supplied auth credential is incorrect,,,malformed or has expired');
        }
      } catch (e) {
        navigator.hideMyLoading();
        // DialogUtils.hideLoading(context: context);
        navigator.showMyMessage(e.toString());
        // DialogUtils.showMsg(context: context, msg: e.toString(),title: 'Erorr',posActionName: 'Ok');
        // print(e.toString());
      }
    }
  }
}