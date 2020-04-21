import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInout extends StatefulWidget {
  final Function saveLocation;

  LocationInout(this.saveLocation);

  @override
  _LocationInoutState createState() => _LocationInoutState();
}

class _LocationInoutState extends State<LocationInout> {
  String _capturedImageUrl;

  Future<void> _seleclLocactionOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          toSelect: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    print(selectedLocation.latitude);
    setStaticImage(selectedLocation.latitude, selectedLocation.longitude);
    widget.saveLocation(selectedLocation.latitude, selectedLocation.longitude);
  }

  void setStaticImage(double latitude, double longitude) {
    var imgUrl = LocationHelper.getMapImageFromLatLong(
        latitude: latitude, longitude: longitude);
    setState(() {
      _capturedImageUrl = imgUrl;
    });
  }

  Future<void> _getUserLocation() async {
    var location = await Location().getLocation();
    print(location.latitude);
    print(location.longitude);
    setStaticImage(location.latitude, location.longitude);
    widget.saveLocation(location.latitude, location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 180,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _capturedImageUrl == null
              ? Text(
                  'Please select location',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _capturedImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _seleclLocactionOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on map.'),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
