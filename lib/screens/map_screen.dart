import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import '../models/place.dart';

const MAPBOX_API_KEY =
    'https://api.mapbox.com/styles/v1/mylmz/cl6owzo47003415qhret2yjks/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibXlsbXoiLCJhIjoiY2w2b3dzejdoMDBnOTNqazZjangzM3MycSJ9.HdazK2RtDlYDbLk53L7HPw';

const MAPBOX_USER =
    'pk.eyJ1IjoibXlsbXoiLCJhIjoiY2w2b3dzejdoMDBnOTNqazZjangzM3MycSJ9.HdazK2RtDlYDbLk53L7HPw';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 37.422, longitude: -122.084),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check, color: Colors.white),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 16.0,
          onLongPress: widget.isSelecting
              ? (tapPosition, point) {
                  setState(() {
                    _pickedLocation = point;
                    print(_pickedLocation.latitude);
                    print(_pickedLocation.longitude);
                  });
                }
              : null,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: MAPBOX_API_KEY,
            additionalOptions: {
              'accessToken': MAPBOX_USER,
              'id': 'mapbox.mapbox-streets-v8',
            },
          ),
          MarkerLayerOptions(
            markers: (_pickedLocation == null && widget.isSelecting)
                ? []
                : [
                    Marker(
                      point: _pickedLocation ??
                          LatLng(
                            widget.initialLocation.latitude,
                            widget.initialLocation.longitude,
                          ),
                      builder: (ctx) => Icon(
                        Icons.location_on_sharp,
                        size: 50,
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
