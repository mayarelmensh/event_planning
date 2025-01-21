
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning/event.dart';
import 'package:event_planning/flutter_toast.dart';
import 'package:flutter/widgets.dart';
import '../firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class EventListProvider extends ChangeNotifier{
  List<Event>eventList=[];
  List<Event>filterList=[];
  int selectedIndex=0;
  List evenPlanningTabs=[];
  List<Event>favoriteEvent=[];
  Event? selectedEvent;




  getEventNameList(BuildContext context){
    evenPlanningTabs=[
    AppLocalizations.of(context)!.all,
    AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workShop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
  }

  // List<String>evenPlanningTabs=[
  //   "All",
  //   "Sport",
  //   "Birthday",
  //   "Meeting",
  //   "Gaming",
  //   "WorkShop",
  //   "BookClub",
  //   "Exhibition",
  //   "Holiday",
  //   "Eating"
  // ];
  // void getAllEvent() {
  //   FirebaseUtils.getEventCollection().snapshots().listen((QuerySnapshot<Event> querySnapshot) {
  //       eventList = querySnapshot.docs.map((doc) {
  //         return doc.data();
  //       }).toList();
  //   });
  //     filterList=eventList;
  //   notifyListeners();
  // }
  void setSelectedEvent(Event event){
    selectedEvent=event;
    notifyListeners();
  }


  void getAllEvent(String uid)async{
    FirebaseUtils.getEventCollection(uid).snapshots().listen((
        QuerySnapshot<Event> querySnapshot){
      eventList = querySnapshot.docs.map((doc){
       return doc.data();
      }).toList();
      if (selectedIndex == 0){
        filterList = eventList;
      } else {
        getFilterEvent(uid);
      }
      eventList.sort((Event event1,Event event2){
        return event1.dateTime.compareTo(event2.dateTime);
      });
      notifyListeners();
    });
  //  QuerySnapshot<Event>querySnapshot=await FirebaseUtils.getEventCollection(uid).get();
  //  eventList=querySnapshot.docs.map((doc) {
  //    return doc.data();
  //  }).toList();
  // notifyListeners();
  }

  void getFilterEvent(String uid)async{
  QuerySnapshot<Event>querySnapshot=
  await FirebaseUtils.getEventCollection(uid).where('eventName',isEqualTo: evenPlanningTabs[selectedIndex]).get();
  filterList=querySnapshot.docs.map((doc) {
    return doc.data() ;
  }).toList();
  filterList.sort((Event event1,Event event2){
    return event1.dateTime.compareTo(event2.dateTime);
  });
  notifyListeners();
  }

  void changeSelectedIndex(int newIndex,String uid) {
    selectedIndex = newIndex;
    if (selectedIndex == 0) {
      if (filterList.isEmpty||eventList.isEmpty) {
        getAllEvent(uid);
      } else {
        filterList = eventList;
      }
    } else {
      getFilterEvent(uid);
    }
    notifyListeners();
  }
  void updatefavorite(Event event,String uid){
    FirebaseUtils.getEventCollection(uid).doc(event.id).update(
        {'isFavorite':!event.isFavorite}
    ).timeout(Duration(milliseconds: 500),onTimeout: (){
      print('Event updated successfully');
      ToastMessage.toastMessage(msg: 'Event updated successfully');
      selectedIndex==0?getAllEvent(uid):getFilterEvent(uid);
      getFavoriteEvents(uid);
    });
    notifyListeners();
  }


  void updateEvent(Event event,String uid){
    FirebaseUtils.getEventCollection(uid).doc(event.id).update(
        {'title':event.title,
        'description':event.description,
          'image':event.image,
          'dateTime':event.dateTime,
          "time":event.time
        }
    ).timeout(Duration(milliseconds: 500),onTimeout: (){
      print('Event updated successfully');
      ToastMessage.toastMessage(msg: 'Event updated successfully');
      // selectedIndex==0?getAllEvent(uid):getFilterEvent(uid);
      getFavoriteEvents(uid);
    });
    notifyListeners();
  }

  void getFavoriteEvents(String uid)async{
  var querySanpshots=await FirebaseUtils.getEventCollection(uid).orderBy('dateTime').where('isFavorite',isEqualTo:true ).get();
  favoriteEvent= querySanpshots.docs.map((doc){
    return doc.data();
  }).toList();
notifyListeners();
  }

  void removeEventById(String eventId) {
    FirebaseUtils.deleteEventFromFirestore(eventId);
    eventList.removeWhere((event) => event.id == eventId);
    notifyListeners();
  }
}
