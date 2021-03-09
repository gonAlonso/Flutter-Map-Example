import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_four/screens/map_screen.dart';

import '../providers/great_places.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = 'placeDetail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final place = Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
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
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => MapScreen(
                  initialLocation: place.location,
                  isSelecting: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
