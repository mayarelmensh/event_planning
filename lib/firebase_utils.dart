
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning/event.dart';
import 'package:event_planning/my_user.dart';

class FirebaseUtils{
  static CollectionReference<Event> getEventCollection(String uid){
   return getUserCollection().doc(uid).collection(Event.collectionName)
        .withConverter<Event>(                                    //when i have more than one function in fuction the type = thye last function i used
        fromFirestore: (snapshot,options){
        if(snapshot.exists&&snapshot.data()!=null){
          return Event.fromFireBase(snapshot.data()!);
        }else{
          return Event(dateTime: DateTime.now(),
            description: 'description',
            title: 'title',
            eventName: 'eventName',
            image: 'image',
            time: 'time');}
          },  //snapshot object from document
        toFirestore: (event,_)=> event.toFireStore()
    );
  }

  static CollectionReference<MyUser> getUserCollection(){
   return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
        fromFirestore: (snapshot,option)=>  MyUser.fromFireStore(snapshot.data()!),
        toFirestore: (user,options)=>user.toFireStore());
  }
  static Future<void> addUserToFireStore(MyUser myUser){
    return getUserCollection().doc(myUser.id).set(myUser);


  }

 static Future<MyUser?> readUserFromFireStore(String id)async{
    var querySnapShot =await getUserCollection().doc(id).get();
    return querySnapShot.data();
  }

  static Future<void> addEventToFireStore(Event event,String uid){
    CollectionReference<Event> collectionRef=  getEventCollection(uid);
    DocumentReference<Event> docRef= collectionRef.doc();
    event.id= docRef.id;   //auto id
    //getEventCollection().doc().set(event);
    return docRef.set(event);

  }

  static Future<void> updateEventInFireStore(Event event, String userId) async {
    try {
      DocumentReference eventRef = getEventCollection(userId).doc(userId);
      await eventRef.update({
        'title': event.title,
        'description': event.description,
        'dateTime': event.dateTime,
        'time': event.time,
        'eventName': event.eventName,
        'image': event.image,
      });
      print("Event updated successfully.");
    } catch (e) {
      print("Error updating event: $e");
    }
  }

  static Future<void> deleteEventFromFirestore(String eventId) async {
    try {
      await FirebaseFirestore.instance.collection(Event.collectionName).doc(eventId).delete();
    } catch (e) {
      print("Error deleting event: $e");
      throw e;
    }
  }

}

