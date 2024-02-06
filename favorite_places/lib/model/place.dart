import 'package:flutter/material.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  Place({required this.title, required this.image})
      : id = uuid.v4(); // v4 creates arandom number, v1 -> time based number
  final String id;
  final String title;
  final File image;
}
