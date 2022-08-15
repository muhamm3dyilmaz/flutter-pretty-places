import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/add_place_screen.dart';
import '../providers/pretty_places.dart';
import '../screens/place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  static const routeName = '/places-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pretty Places"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PrettyPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PrettyPlaces>(
                child: Center(
                  child: const Text("No places added yet,start adding some!"),
                ),
                builder: (ctx, prettyPlaces, ch) =>
                    prettyPlaces.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: prettyPlaces.items.length,
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(prettyPlaces.items[i].image),
                              ),
                              title: Text(prettyPlaces.items[i].title),
                              subtitle:
                                  Text(prettyPlaces.items[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: prettyPlaces.items[i].id,
                                );
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
