class MyUser{
  static const String collectionName='Users';
  String id;
  String name;
  String email;
  MyUser({required this.id,required this.email,required this.name});

  //json==> object

  MyUser.fromFireStore(Map<String,dynamic>data):this(
    id: data['id'],
    email: data['email'],
    name: data['name']
  );
  //object==> json
 Map<String,dynamic> toFireStore(){
   return{
     'id':id,
     'name':name,
     'email':email
   };
 }

  }