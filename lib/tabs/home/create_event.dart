import 'package:event_planning/event.dart';
import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/flutter_toast.dart';
import 'package:event_planning/login/elevated_button.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/tabs/custom_text_field.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/tabs/home/event_details.dart';
import 'package:event_planning/tabs/home/home_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class CreateEvent extends StatefulWidget{
  static const String routeName="create_event_screen";
  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  int selectedIndex=0;
  var formKey=GlobalKey<FormState>();
  var titlecontroller=TextEditingController();
  var descriptioncontroller=TextEditingController();
 late EventListProvider eventListProvider;
  DateTime?selectedDate;
  TimeOfDay?selectedTime;
  String formattedTime='';
  String formattedDate='';
  String selectedImage='';
  String selectedEvent='';
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    eventListProvider=Provider.of<EventListProvider>(context);
    Map<String,String>mapOfImages={
      AppLocalizations.of(context)!.sport:'assets/images/sport.png',
      AppLocalizations.of(context)!.birthday:'assets/images/birthday.png',
      AppLocalizations.of(context)!.meeting:'assets/images/meeting.png',
      AppLocalizations.of(context)!.gaming:'assets/images/gaming.png',
      AppLocalizations.of(context)!.workShop:'assets/images/work_shop.png',
      AppLocalizations.of(context)!.bookClub:'assets/images/book_club.png',
      AppLocalizations.of(context)!.exhibition:'assets/images/exh.png',
      AppLocalizations.of(context)!.holiday:'assets/images/holiday.png',
      AppLocalizations.of(context)!.eating:'assets/images/eating.png',
    };


    List<String>eventPlanningTabs=[
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workShop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating
    ];

   selectedImage= mapOfImages[eventPlanningTabs[selectedIndex]]!;
   selectedEvent= eventPlanningTabs[selectedIndex];

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.createEvent,
      style: TextStyle(color: Color(0xff5669FF)),
      ),centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xff5669FF)),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.04),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child:Image.asset(
               mapOfImages[eventPlanningTabs[selectedIndex]]!
                ),
              ),
              SizedBox(height: height*0.02,),
              Container(
                height: height*0.045,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                 return InkWell(
                   onTap: (){
                     selectedIndex=index;
                     setState(() {

                     });
                   },
                   child: HomeTabs(
                    borderColor: Color(0xff5669FF),
                    backgroundOfTab: Color(0xff5669FF),
                    textSelectedStyle:TextStyle(fontSize:16,color:Colors.white ),
                    textUnSelectedStyle: TextStyle(fontSize:16,color: Color(0xff5669FF) ,),
                    eventName: eventPlanningTabs[index],
                    isSelected : selectedIndex==index),
                 );
                },
                    separatorBuilder: (context,index){
                  return SizedBox(width: width*0.02,);
                    },
                    itemCount: eventPlanningTabs.length),
              ),
              SizedBox(height: height*0.02,),
              Form(
                  key: formKey,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                Text(AppLocalizations.of(context)!.title,style: TextStyle(
                    color: Colors.black,fontWeight: FontWeight.w500,
                    fontSize:16
                ),
                ),
                SizedBox(height: height*0.01,),
                CustomTextField(
                  controller: titlecontroller,
                  vaidator: (text){
                    if(text==null||text.isEmpty){
                      return 'Please enter the title of event';   //invalid    return string => false
                    }
                      return null;                               //valid       return null => true
                  },
                  hintText: AppLocalizations.of(context)!.eventTitle,
                  prefixIcon: Icon(Icons.edit),
                  hintStyle: TextStyle(fontSize: 16,color: Color(0xff7B7B7B)),
                ),
                SizedBox(height: height*0.02,),
                Text(AppLocalizations.of(context)!.description,
                  style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),),
                SizedBox(height: height*0.01,),
                CustomTextField(
                  controller: descriptioncontroller,
                  vaidator: (text){
                    if(text==null||text.isEmpty){
                      return 'Please enter the decsription of event';
                    }
                    return null;
                  },
                  hintText: AppLocalizations.of(context)!.eventDescription,
                  maxlines: 4,
                  hintStyle: TextStyle(fontSize: 16,color: Color(0xff7B7B7B)),
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined),
                    SizedBox(width: width*0.02,),
                    Expanded(child: Text(AppLocalizations.of(context)!.eventDate,
                      style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),)),
                    TextButton(onPressed: chooseDate,
                      child:  Text(
                        selectedDate==null?
                        AppLocalizations.of(context)!.chooseDate:
                        DateFormat('dd/MM/yyyy').format(selectedDate!)
                        ,style: TextStyle(
                        color: Color(0xff5669FF),
                        fontSize: 16,
                      ),),)
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time_outlined),
                    SizedBox(width: width*0.02,),
                    Expanded(child: Text(
                      AppLocalizations.of(context)!.eventTime,
                      style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500),)),
                    TextButton(onPressed: chooseTime,
                      child:  Text(
                        selectedTime==null?
                        AppLocalizations.of(context)!.chooseTime
                        :formattedTime
                        ,style: TextStyle(
                        color: Color(0xff5669FF),
                        fontSize: 16,
                      ),),)
                  ],
                ),
                Text(AppLocalizations.of(context)!.location,style:TextStyle(fontSize: 16,
                    color: Colors.black,fontWeight: FontWeight.w500),),
                SizedBox(height: height*0.01,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: height*0.01,
                      horizontal: width*0.02
                  ),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: Color(0xff5669FF),
                          width: 2
                      )
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: height*0.01,
                            horizontal: width*0.02),
                        // width: width*0.1,height: height*0.06,
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(8),
                            color: Color(0xff5669FF)
                        ),
                        child: Icon(Icons.my_location,color: Colors.white,),
                      ),
                      SizedBox(width: width*0.02,),
                      Expanded(child: Text(AppLocalizations.of(context)!.chooseEventLocation,
                        style: TextStyle(color: Color(0xff5669FF),fontSize: 16),)),
                      Icon(Icons.arrow_forward_ios_rounded,color: Color(0xff5669FF),)
                    ],
                  ),
                ),
                SizedBox(height: height*0.01,),
                CustomElevatedButton(text: AppLocalizations.of(context)!.addEvent,
                    onPressed: addEvent)
              ],))
            ],
          ),
        ),
      ),
    );
  }
  void addEvent(){
    if(formKey.currentState?.validate()==true) {
      Event event=Event(dateTime: selectedDate!,
          description: descriptioncontroller.text,
          title: titlecontroller.text,
          eventName: selectedEvent,
          image: selectedImage,
          time: formattedTime);
      var userProvider=Provider.of<UserProvider>(context,listen: false);
      FirebaseUtils.addEventToFireStore(event,userProvider.currentUser!.id)
      .then((value) {
        print('event added successfully');
        ToastMessage.toastMessage(msg: 'Event added Successfully');
        eventListProvider.getAllEvent(userProvider.currentUser!.id);
      }).timeout(Duration(milliseconds: 500),
          onTimeout: (){
        print('event add successfully');
      });
      eventListProvider.getAllEvent(userProvider.currentUser!.id);
      Navigator.pop(context);

    }
  }

  void chooseDate()async{
    var chooseDate=await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now()
        , lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate=chooseDate;
    formattedDate=DateFormat('dd/MM/yyyy').format(selectedDate!);
    setState(() {

    });
  }

  void chooseTime()async{
   var chooseTime=await showTimePicker(
       context: context,
        initialTime: TimeOfDay.now());
   selectedTime=chooseTime;
   formattedTime=selectedTime!.format(context);
   setState(() {

   });
  }
}