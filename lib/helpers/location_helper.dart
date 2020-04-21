import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = '';

class LocationHelper
{
  static String getMapImageFromLatLong({double latitude, double longitude})
  {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=18&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAddressFromLatLng({double latitude,double longitude}) async
  {
      final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY';
      var response  = await http.get(url);
      return json.decode(response.body)['results'][0]['formatted_address'];
  }
}