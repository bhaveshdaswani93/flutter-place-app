import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import './map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context).settings.arguments;
    final place = Provider.of<Places>(context).findByid(placeId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Detail'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 180,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            place.location.address,
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text('Show Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    location: place.location,
                    toSelect: false,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
