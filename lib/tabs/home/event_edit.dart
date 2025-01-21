
import 'package:event_planning/event.dart';
import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/flutter_toast.dart';
import 'package:event_planning/login/elevated_button.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/tabs/custom_text_field.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/tabs/home/home_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class EditEvent extends StatefulWidget {
  static const String routeName = "edit_event_screen";

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  late EventListProvider eventListProvider;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String formattedTime = '';
  String formattedDate = '';
  String selectedImage = '';
  String selectedEvent = '';
  int selectedIndex=0;
  late var eventId;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    eventListProvider = Provider.of<EventListProvider>(context);
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

    final List<dynamic> eventData =
    ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    titleController.text = eventData[1];
    descriptionController.text = eventData[4];
    selectedDate = eventData[2];
    formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    formattedTime = eventData[3];
    selectedImage = eventData[0];
    selectedEvent= eventPlanningTabs[selectedIndex];
    eventId=eventData[5];
    selectedIndex = mapOfImages.values.toList().indexOf(eventData[0]);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editEvent,
            style: TextStyle(color: Color(0xff5669FF))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xff5669FF)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.04),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Image.asset(
                    mapOfImages[eventPlanningTabs[selectedIndex]]!
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                height: height * 0.045,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        setState(() {
                          selectedIndex=index;
                          selectedImage = mapOfImages.values.toList()[selectedIndex];
                          selectedEvent = eventPlanningTabs[selectedIndex];
                        });
                      },
                      child: HomeTabs(
                        borderColor: Color(0xff5669FF),
                        backgroundOfTab: Color(0xff5669FF),
                        textSelectedStyle: TextStyle(fontSize: 16, color: Colors.white),
                        textUnSelectedStyle: TextStyle(fontSize: 16, color: Color(0xff5669FF)),
                        eventName: eventPlanningTabs[index],
                        isSelected: selectedIndex==index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: width * 0.02);
                  },
                  itemCount: eventPlanningTabs.length,
                ),
              ),
              SizedBox(height: height * 0.02),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppLocalizations.of(context)!.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16)),
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                      controller: titleController,
                      vaidator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter the title of event';
                        }
                        return null;
                      },
                      hintText: AppLocalizations.of(context)!.eventTitle,
                      prefixIcon: Icon(Icons.edit),
                      hintStyle: TextStyle(fontSize: 16, color: Color(0xff7B7B7B)),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(AppLocalizations.of(context)!.description, style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)),
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                      controller: descriptionController,
                      vaidator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter the description of event';
                        }
                        return null;
                      },
                      hintText: AppLocalizations.of(context)!.eventDescription,
                      maxlines: 4,
                      hintStyle: TextStyle(fontSize: 16, color: Color(0xff7B7B7B)),
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_month_outlined),
                        SizedBox(width: width * 0.02),
                        Expanded(child: Text(AppLocalizations.of(context)!.eventDate, style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500))),
                        TextButton(onPressed: chooseDate, child: Text(selectedDate == null ? AppLocalizations.of(context)!.chooseDate : DateFormat('dd/MM/yyyy').format(selectedDate!), style: TextStyle(color: Color(0xff5669FF), fontSize: 16))),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time_outlined),
                        SizedBox(width: width * 0.02),
                        Expanded(child: Text(AppLocalizations.of(context)!.eventTime, style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500))),
                        TextButton(onPressed: chooseTime, child: Text(formattedTime == null ? AppLocalizations.of(context)!.chooseTime : formattedTime, style: TextStyle(color: Color(0xff5669FF), fontSize: 16))),
                      ],
                    ),
                    CustomElevatedButton(text: AppLocalizations.of(context)!.updateEvent,
                        onPressed: saveEvent)
                    // CustomElevatedButton(text: AppLocalizations.of(context)!.editEvent, onPressed: updateEvent),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveEvent() {
    if (formKey.currentState?.validate() ?? false) {
      Event updatedEvent = Event(
        id: eventId,
        title: titleController.text,
        description: descriptionController.text,
        image: selectedImage,
        eventName: selectedEvent,
        dateTime: selectedDate!,
        time: formattedTime,
        isFavorite: false,
      );

      FirebaseUtils.updateEventInFireStore(updatedEvent, eventId)
          .then((value) {
        ToastMessage.toastMessage(msg: 'Event updated Successfully');
        Navigator.pop(context);
      }).catchError((error) {
        print('Error: $error');
        ToastMessage.toastMessage(msg: 'Error updating event');
      });
    }
  }



  //
  // void updateEvent(){
  //   if (formKey.currentState?.validate() == true) {
  //     Event event = Event(
  //       dateTime: selectedDate!,
  //       description: descriptionController.text,
  //       title: titleController.text,
  //       eventName: selectedEvent,
  //       image: selectedImage,
  //       time: formattedTime,
  //     );
  //     var userProvider = Provider.of<UserProvider>(context, listen: false);
  //     FirebaseUtils.updateEventInFireStore(event, userProvider.currentUser!.id)
  //         .then((value) {
  //       ToastMessage.toastMessage(msg: 'Event updated Successfully');
  //       Navigator.pop(context);
  //     });
  //   }
  // }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chooseDate;
    formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    selectedTime = chooseTime;
    formattedTime = selectedTime!.format(context);
    setState(() {});
  }
}
