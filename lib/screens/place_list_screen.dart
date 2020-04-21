import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_app/screens/place_add_screen.dart';
import 'package:my_app/providers/places.dart';
import './place_detail_screen.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Place App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(PlaceAddScreen.routeName);
              },
            )
          ],
        ),
        body: FutureBuilder(
          future:
              Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
          builder: (ctx, dataSnap) => dataSnap.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Places>(
                  builder: (ctx, places, ch) => places.places.length <= 0
                      ? Center(
                          child: Text('Please add places'),
                        )
                      : ListView.builder(
                          itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(places.places[i].image),
                            ),
                            title: Text(places.places[i].title),
                            subtitle: Text(places.places[i].location.address),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: places.places[i].id);
                            },
                          ),
                          itemCount: places.places.length,
                        ),
                ),
        ));
  }
}
