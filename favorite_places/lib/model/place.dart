import 'package:flutter/material.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

// class PlaceLocation{ for saving a location
//   const PlaceLocation({super.key, required this.latitude, required this.longitute, required this.address });
// final double latitude;
// final double longitute;
// final String address;
// }

class Place {
  Place({
    required this.title,
    required this.image,
  }) // after image add required this.location
  : id = uuid.v4(); // v4 creates arandom number, v1 -> time based number
  final String id;
  final String title;
  final File image;
  // final PlaceLocation location;
}
