

import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/tabs/home/event_details.dart';
import 'package:event_planning/tabs/home/event_edit.dart';
import 'package:event_planning/tabs/home/event_item_widget.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/tabs/home/home_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../providers/app_language_provider.dart';
import '../../providers/app_theme_provider.dart';


class Hometab extends StatefulWidget{
  @override
  State<Hometab> createState() => _HometabState();
}

class _HometabState extends State<Hometab> {
// @override
// void initState() {
//   super.initState();
//   var eventListProvider = Provider.of<EventListProvider>(context, listen: false);
//   var userProvider=Provider.of<UserProvider>(context,listen: false);
//   if (eventListProvider.filterList.isEmpty && eventListProvider.selectedIndex == 0) {
//     eventListProvider.getAllEvent(userProvider.currentUser!.id);
//   }
// }

  @override
  Widget build(BuildContext context) {
    var eventListProvider=Provider.of<EventListProvider>(context);
    var userProvider=Provider.of<UserProvider>(context);
    eventListProvider.getEventNameList(context);
    if(eventListProvider.eventList.isEmpty){
     eventListProvider.getAllEvent(userProvider.currentUser!.id);
   }
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    var themeProvider=Provider.of<ThemeProvider>(context);
    var languageProvider=Provider.of<AppLanguageProvider>(context);


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:Padding(
          padding:  EdgeInsets.symmetric(vertical: height*0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text(AppLocalizations.of(context)!.welcomeBack,style:TextStyle(
                            fontSize: 14,
                          )
                          ),
                          Text(userProvider.currentUser!.name),
                        ]
                    ),
                    Row(
                      children: [
                        Icon(themeProvider.appTheme==ThemeMode.light?
                        Icons.wb_sunny_outlined:
                        Icons.dark_mode_outlined
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child:Padding(
                            padding:EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.01),
                            child:Text(languageProvider.appLanguage=='en'?
                                AppLocalizations.of(context)!.en:
                                AppLocalizations.of(context)!.ar
                            ,
                              style:TextStyle(color: themeProvider.appTheme==ThemeMode.light?
                                  Color(0xff5669FF):
                                  Color(0xff101127)
                                  ,fontSize: 14),),
                          ),
                        )
                      ],
                    )
                  ]
              ),
              SizedBox(height: height*0.01),
              Row(children: [
                Icon(Icons.location_on_outlined,),
                Text(AppLocalizations.of(context)!.cairoEgypt,
                style:TextStyle(fontSize: 14),)],)
            ],
          ),
        ),
        toolbarHeight: 110,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: height*0.08,
            decoration: BoxDecoration(
                color: themeProvider.appTheme==ThemeMode.light?
            Color(0xff5669FF):
          Colors.transparent,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
            ),
           child: DefaultTabController(
             length: eventListProvider.evenPlanningTabs.length,
             child:  TabBar(
               onTap: (index){
                eventListProvider.changeSelectedIndex(index,userProvider.currentUser!.id);
               },
               indicatorColor: Colors.transparent,
               dividerColor: Colors.transparent,
               tabAlignment: TabAlignment.start,
               labelPadding: EdgeInsets.symmetric(vertical: height*0.01),
               isScrollable: true,
               tabs:eventListProvider.evenPlanningTabs.map((eventName) {
                 return HomeTabs(
                     backgroundOfTab: Colors.white,
                     textSelectedStyle:TextStyle(fontSize:16,color: Color(0xff5669FF) ),
                     textUnSelectedStyle: TextStyle(fontSize:16,color: Colors.white ,),
                     eventName: eventName,
                     isSelected : eventListProvider.selectedIndex==eventListProvider.evenPlanningTabs.indexOf(eventName));
                }
               ).toList()
             ) ,
           ),
            ),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.03),
              child:
                eventListProvider.filterList.isEmpty&& eventListProvider.selectedIndex==0||eventListProvider.selectedIndex!=0&&eventListProvider.filterList.isEmpty?
          Center(child: Text("No items Found",style: TextStyle(color: Colors.black87),))
          :
              ListView.builder(itemBuilder: (context,index){
               var event=eventListProvider.filterList[index];
                return InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(EventDetails.routeName,
                      arguments:
                      [
                        event.image,
                        event.title,
                        event.dateTime,
                        event.time,
                        event.description,
                        event.id,
                      ]
                      );

                    },
                    child: EventItemWidget(event: event));
              },
                itemCount: eventListProvider.filterList.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  // void getAllEvent()async{
  //   QuerySnapshot<Event> querySnapshot=await FirebaseUtils.getEventCollection().get();
  //   eventList=querySnapshot.docs.map((doc) {
  //     return doc.data();
  //   }).toList();
  //   setState(() {
  //
  //   });
  // }





}