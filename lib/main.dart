import 'package:flutter/material.dart';
import 'package:my_app/screens/place_add_screen.dart';
import 'package:my_app/screens/place_list_screen.dart';
import 'package:provider/provider.dart';

import 'package:my_app/providers/places.dart';
import './screens/place_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlaceListScreen(),
        routes: {
          PlaceAddScreen.routeName: (ctx)=>PlaceAddScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen()
          
        },
      ),
    );
  }
}
