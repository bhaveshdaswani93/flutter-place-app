import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  Future<void> addPlace(
      String pickedTitle, File pickedImage, PlaceLocation location) async {
    String address = await LocationHelper.getAddressFromLatLng(
        latitude: location.latitude, longitude: location.longitude);
    PlaceLocation updatedLocation = PlaceLocation(
      latitude: location.latitude,
      longitude: location.longitude,
      address: address,
    );

    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: pickedTitle,
        location: updatedLocation);
    _places.add(newPlace);
    notifyListeners();

    DbHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': updatedLocation.latitude,
      'longitude': updatedLocation.longitude,
      'address': updatedLocation.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final listPlace = await DbHelper.getData('user_places');
    _places = listPlace
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            location: PlaceLocation(
              latitude: place['latitude'],
              longitude: place['longitude'],
              address: place['address'],
            ),
            image: File(place['image']),
          ),
        )
        .toList();
    notifyListeners();
  }

  Place findByid(String id)
  {
    return _places.firstWhere((place)=>place.id == id);
  }
}
