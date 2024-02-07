import 'package:flutter/material.dart';
import 'package:location/location.dart';

//for location
// import 'package:http/http.dart' as http;
// import 'package:favorite_places/model/place.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInput();
  }
}

class _LocationInput extends State<LocationInput> {
  Location? _pickedLoaction;
  //(PlaceLoaction? _pickedLoaction)

  var _isGettingLocation = false;

  void _getCurrentLoaction() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    // final lat = locationData.latitude;
    // final lng = locationData.longitude;

    // if (lat == null || lng == null) {
    //   return;
    // }

    // final url = Uri.parse(// google geolocation api);
    // final response = await http.get(url);

    // the longitude by accessing locationData.longitude.
    // And then we can replace this part here,
    // 40 dot something in front of the comma,
    // but without replacing the comma with $
    // and then lat and then the -73 part here
    // in my case with $lng
    // and the comma between the two must stay there
    // don't delete that accidentally.
    // And then for API key, you can plug in your API key(google map api).

    // final resData=json.decode(response.data);
    // final address = resData['results'][0]['formatted_address'];

    // Go to in place.dart
    setState(() {
      // _pickedLoaction =
      //     PlaceLocation(latitude: lat, longitude: lng, address: address,);
      _isGettingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No loaction chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_isGettingLocation = true) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
              onPressed: _getCurrentLoaction,
            ),
            const SizedBox(width: 5),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
            ),
          ],
        ),
      ],
    );
  }
}
