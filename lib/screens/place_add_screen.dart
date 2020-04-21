import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/models/place.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/places.dart';
import '../widgets/location_input.dart';

class PlaceAddScreen extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _PlaceAddScreenState createState() => _PlaceAddScreenState();
}

class _PlaceAddScreenState extends State<PlaceAddScreen> {
  File _capturedImage;
  PlaceLocation _location;

  void _saveImage(File capturedImage) {
    _capturedImage = capturedImage;
  }

  void _saveLocation(double latitute, double longitude) {
    _location = PlaceLocation(latitude: latitute, longitude: longitude);
  }

  void _addPlace() {
    if (_titleController.text.isEmpty ||
        _capturedImage == null ||
        _location == null) {
      return;
    }

    Provider.of<Places>(context, listen: false)
        .addPlace(_titleController.text, _capturedImage, _location);
    Navigator.of(context).pop();
  }

  var _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ImageInput(_saveImage),
                      SizedBox(
                        height: 10,
                      ),
                      LocationInout(_saveLocation)
                    ],
                  ),
                ),
              ),
            ),
            RaisedButton.icon(
              onPressed: _addPlace,
              icon: Icon(Icons.add),
              label: Text('Add Place'),
              color: Theme.of(context).accentColor,
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            )
          ],
        ),
      ),
    );
  }
}
