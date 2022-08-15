import 'dart:convert';
import 'package:http/http.dart' as http;

const MAPBOX_API_KEY = 'Your Mapbox API Key Begins With https';

const MAPBOX_USER = 'Your Mapbox User Token Begins with pk...';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPBOX_USER';
  }

  static Future<String> getPlaceAddress(
      double latitude, double longitude) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$MAPBOX_USER');
    final response = await http.get(url);
    return json.decode(response.body)['features'][0]['place_name'];
  }
}
