import 'package:event_planning/providers/event_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_text_field.dart';
import '../home/event_item_widget.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FavoriteTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var  languageProvider=Provider.of<AppLanguageProvider>(context);
    var  themeProvider=Provider.of<ThemeProvider>(context);
    var eventListProvider=Provider.of<EventListProvider>(context);
   if(eventListProvider.favoriteEvent.isEmpty){
     eventListProvider.favoriteEvent;
   }
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.02),
        child: Column(
          children: [
            CustomTextField(
              iconColor: Color(0xff5669FF ),
              prefixIcon: Icon(Icons.search),
              hintText: 'Search For Event',
              hintStyle: TextStyle(color: Color(0xff5669FF )),
              borderColor: Color(0xff5669FF ),
            ),
            Expanded(child:
            eventListProvider.favoriteEvent.isEmpty?
             Center(child: Text('No Favorite Events',style: TextStyle(color: Colors.black),)):
            ListView.builder(itemBuilder: (context,index) {
              return EventItemWidget(
                event: eventListProvider.favoriteEvent[index],
              );
            },
              itemCount: eventListProvider.favoriteEvent.length,
                   ),
                   )
                       ],
        ),
      ),
    );
  }

}