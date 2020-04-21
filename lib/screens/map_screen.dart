import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool toSelect;

  MapScreen({
    this.location = const PlaceLocation(latitude: 23, longitude: 72),
    this.toSelect = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _selectedLatLng;

  void tapAndSelect(LatLng selectedLatLong) {
    setState(() {
      _selectedLatLng = selectedLatLong;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        actions: <Widget>[
          if (widget.toSelect)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _selectedLatLng == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_selectedLatLng);
                    },
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.location.latitude,
              widget.location.longitude,
            ),
            zoom: 15),
        onTap: widget.toSelect ? tapAndSelect : null,
        markers: (_selectedLatLng == null && widget.toSelect)
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _selectedLatLng ??
                      LatLng(
                          widget.location.latitude, widget.location.longitude),
                ),
              },
      ),
    );
  }
}
