import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning/event.dart';
import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/tabs/home/event_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../flutter_toast.dart';


class EventDetails extends StatefulWidget {
  static const String routeName = 'event_details';

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context){
    var eventProvider=Provider.of<EventListProvider>(context);
    final List<dynamic> eventData = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    var eventImage=eventData[0];
    var eventId=eventData[5];
    var eventTitle=eventData[1];
    var eventDate=eventData[2];
    var eventTime=eventData[3];
    var eventDescription=eventData[4];

    // Event? event=eventProvider.selectedEvent;
    // final eventData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    // if (eventData == null) {
    //   return Center(child: Text('No event data available'));
    // }
    // DateTime eventDateTime = DateTime.fromMillisecondsSinceEpoch(eventData['eventDate']);
    // String formattedDate = "${eventDateTime.year}-${eventDateTime.month}-${eventDateTime.day}";

    // if (event == null) {
    //   return Scaffold(
    //     body: Center(
    //       child: Text("No event selected"),
    //     ),
    //   );
    // }
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.eventDetails,
          style: TextStyle(color: Color(0xff5669FF)),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xff5669FF)),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(EditEvent.routeName,
            arguments: [
              eventImage,
              eventTitle,
              eventDate,
              eventTime,
              eventDescription,
              eventId
            ]
            );
          }, icon: Icon(Icons.edit)),
          IconButton(
            onPressed: () async {
              try {
                await FirebaseUtils.deleteEventFromFirestore(eventId);
                print(eventId);
                ToastMessage.toastMessage(msg: 'Event deleted successfully');
                Navigator.pop(context);
                eventProvider.removeEventById(eventId);
              } catch (error) {
                ToastMessage.toastMessage(msg: 'Error deleting event');
                print(error);
              }
              setState(() {

              });
            },
            icon: Icon(
              CupertinoIcons.delete_simple,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(eventImage)
              ),
              SizedBox(height: height*0.01,),
              Text(eventTitle,style: TextStyle(fontSize: 25,color: Color(0xff5669FF)),),
              SizedBox(height: height*0.01,),
              Container(
                padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xff5669FF), width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.02),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xff5669FF)),
                      child: Icon(Icons.calendar_month_outlined, color: Colors.white),
                    ),
                    SizedBox(width: width * 0.02),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                          DateFormat('dd/MMM/yyyy').format(eventDate!),
                      style: TextStyle(color: Color(0xff5669FF), fontSize: 16),
                          ),
                          Text(
                          eventTime.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.02,),
                  ],
                ),
              ),
              SizedBox(height: height*0.01,),
              Container(
                padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.02),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Color(0xff5669FF), width: 2)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.02),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xff5669FF)),
                      child: Icon(Icons.my_location, color: Colors.white),
                    ),
                    SizedBox(width: width * 0.02),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.cairoEgypt,
                        style: TextStyle(color: Color(0xff5669FF), fontSize: 16),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, color: Color(0xff5669FF)),
                  ],
                ),
              ),
              SizedBox(height: height*0.01,),
              Image.asset('assets/images/map.png'),
              SizedBox(height: height*0.01,),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppLocalizations.of(context)!.description),
                  Text(eventDescription)

                ],
              ),
            ]
          ),
        )
      ),
    );
  }
}
