import 'dart:convert';
import 'package:http/http.dart' as http;

const MAPBOX_API_KEY =
    'https://api.mapbox.com/styles/v1/mylmz/cl6owzo47003415qhret2yjks/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibXlsbXoiLCJhIjoiY2w2b3dzejdoMDBnOTNqazZjangzM3MycSJ9.HdazK2RtDlYDbLk53L7HPw';

const MAPBOX_USER =
    'pk.eyJ1IjoibXlsbXoiLCJhIjoiY2w2b3dzejdoMDBnOTNqazZjangzM3MycSJ9.HdazK2RtDlYDbLk53L7HPw';

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
