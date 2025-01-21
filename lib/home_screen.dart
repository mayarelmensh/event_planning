import 'package:event_planning/tabs/favorite/favorite_tab.dart';
import 'package:event_planning/tabs/home/create_event.dart';
import 'package:event_planning/tabs/home/home_tab.dart';
import 'package:event_planning/tabs/map/map_tab.dart';
import 'package:event_planning/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeScreen extends StatefulWidget{
  static const String routeName='home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex=0;
  List<Widget>tabs=[
    Hometab(),
    MapTab(),
    FavoriteTab(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     bottomNavigationBar: Theme(
       data: Theme.of(context).copyWith(
         canvasColor: Colors.transparent
       ),
       child: BottomAppBar(
         color: Theme.of(context).primaryColor,
         notchMargin:5,
         shape: CircularNotchedRectangle(),
         child: BottomNavigationBar(
           currentIndex: selectIndex,
           onTap: (index){     // call back function bt return index of the icon that user chosen
             selectIndex= index;
             setState(() {

             });
           },
           items: [
             bottomNavigationBarItem(
               index: 0,
               iconSelected:'assets/images/home_selected.png' ,
               iconName:'assets/images/home_unselected.png' ,
               label:AppLocalizations.of(context)!.home,
             ),
             bottomNavigationBarItem(
                 index: 1,
                 iconSelected:  'assets/images/map_selected.png',
                 iconName: 'assets/images/map_unselected.png',
                 label: AppLocalizations.of(context)!.map
             ),
             bottomNavigationBarItem(
                 index: 2,
                 iconSelected: 'assets/images/favorite_selected.png',
                 iconName: 'assets/images/heart_unselected.png',
                 label: AppLocalizations.of(context)!.favorite
             ),
             bottomNavigationBarItem(
                 index: 3,
                 iconSelected:'assets/images/profile_selected.png' ,
                 iconName: 'assets/images/profile_unselected.png',
                 label: AppLocalizations.of(context)!.profile
             ),
           ],
         ),
       ),
     ),
     floatingActionButton: FloatingActionButton(
       onPressed: (){
         //add event
         //navigate to event screen
         Navigator.of(context).pushNamed(CreateEvent.routeName);

       },
       child: Icon(Icons.add,color: Colors.white,),
     ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

     body: tabs[selectIndex]
   );

  }

BottomNavigationBarItem bottomNavigationBarItem({required String iconName ,required String label,
required String iconSelected,required int index}){
   return BottomNavigationBarItem(
       icon:ImageIcon(AssetImage(selectIndex==index?iconSelected:iconName)),
       label:label ,
   );

}
}




