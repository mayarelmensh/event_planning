class Event{
  static const String collectionName='Events';

  String? id;    //to access the event by its id
  String title;
  String description;
  String image;
  String? eventName;
  DateTime dateTime;
  String? time;
  bool isFavorite;


  Event({this.id='',required this.dateTime,required this.description,required this.title,required this.eventName,
  required this.image,required this.time,this.isFavorite=false
  });

  //from firebase
  //json  to object
  //json : map of String, dynamic
  Event.fromFireBase(Map<String,dynamic>?data):this(
    id: data!['id'],
    title: data['title'],
    image: data['image'],
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']) ,
    description: data['description'],
    eventName: data['eventName'],
    time: data['time'],
    isFavorite: data['isFavorite']
  );



  //to firebase
  //object to  json
Map<String,dynamic>toFireStore(){
  return {
    'id':id,
    'title':title,
    'description':description,
    'image':image,
    'eventName':eventName,
    'dateTime':dateTime.millisecondsSinceEpoch,  // the time as int not date time
    'time':time,
    'isFavorite':isFavorite
  };
}



// any model in firebase
//class --attributes-- constructor-- function object to json -- function json to object
}