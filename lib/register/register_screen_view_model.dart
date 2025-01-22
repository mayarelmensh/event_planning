import 'package:event_planning/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreenViewModel extends ChangeNotifier{
// hold data - handle logic

 late RegisterNavigator navigator;


void register(String email,String password)async{    // because await
//showLoading
// DialogUtils.showLoading(context: context, msg: 'Loading...');
  navigator.showMyLoading('Loading...');
try {
final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
email: email,
password: password,
);
// MyUser myUser =MyUser(id: credential.user?.uid??"",
//     email: emailController.text,
//     name: nameController.text);
// await FirebaseUtils.addUserToFireStore(myUser);
// var userProvider=Provider.of<UserProvider>(context,listen: false);
// userProvider.updateUser(myUser);
//hide loading
// DialogUtils.hideLoading(context: context);
  navigator.hideMyLoading();
//showMsg
  navigator.showMyMessage('register successfully');
// DialogUtils.showMsg(context: context, msg: 'register successfully',title: 'success',posActionName: 'Ok',posAction: (){
// Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
// });
print('register successfully');
print(credential.user?.uid??'');
} on FirebaseAuthException catch (e) {
if (e.code == 'weak-password') {
//hide loading
navigator.hideMyLoading();
// DialogUtils.hideLoading(context: context);
//showMsg
  navigator.showMyMessage( 'the password provider is too weak');
// DialogUtils.showMsg(context: context,
//     msg: 'the password provider is too weak',title: 'Erorr',posActionName: 'Ok');
print('The password provided is too weak.');
} else if (e.code == 'email-already-in-use') {
//hide loading
navigator.hideMyLoading();

//showMsg
navigator.showMyMessage( 'The account already exists for that email.');
//
// DialogUtils.showMsg(context: context,
//     msg: 'The account already exists for that email.',title: 'success',posActionName: 'Ok');
// print('The account already exists for that email.');
}
} catch (e) {
  navigator.hideMyLoading();
// DialogUtils.hideLoading(context: context);
  navigator.showMyMessage(e.toString());
// DialogUtils.showMsg(context: context, msg: e.toString(),title: 'Erorr',posActionName: 'Ok');
print(e);
}
}
}