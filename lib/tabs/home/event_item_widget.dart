import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../event.dart';

class EventItemWidget extends StatelessWidget{
  String?pathImage;
  Event event;

  EventItemWidget({this.pathImage,required this.event});
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    var eventListProvider=Provider.of<EventListProvider>(context);
    var userProvider=Provider.of<UserProvider>(context);
   return Container(
     margin: EdgeInsets.symmetric(vertical: height*0.01),
     height: height*0.31,
     decoration: BoxDecoration(
       border: Border.all(
         color: Color(0xff5669FF),
         width: 2
       ),
       borderRadius: BorderRadius.circular(20),
       image: DecorationImage(image: AssetImage(event.image),fit: BoxFit.fill)
     ),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Container(
           padding: EdgeInsets.symmetric(horizontal: width*0.025,vertical: height*0.01),
           margin: EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.01),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(12),
             color: Colors.white
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(event.dateTime.day.toString(),style: TextStyle(fontSize: 20,color: Color(0xff5669FF),
               fontWeight: FontWeight.bold)),
               Text(DateFormat('MMM').format(event.dateTime),style: TextStyle(fontSize: 20,color: Color(0xff5669FF),
                   fontWeight: FontWeight.bold))
             ],
           ),
         ),
         Container(
           margin: EdgeInsets.symmetric(vertical: height*0.005,horizontal: width*0.02),
           padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.001),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
             color: Colors.white
           ),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(event.title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
               InkWell(
                 onTap: (){
                   eventListProvider.updatefavorite(event,
                   userProvider.currentUser!.id
                   );
                 },
                   child:
                   event.isFavorite==true?
                   Image.asset(pathImage??'assets/images/favorite_selected.png',color: Color(0xff5669FF),):
                   Image.asset(pathImage??'assets/images/heart_unselected.png',color: Color(0xff5669FF),))
             ],
           ),
         )
       ],
     ),
   );
  }

}