import 'dart:io'; // to make file type available
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() {
    return _ImageInput();
  }
}

class _ImageInput extends State<ImageInput> {
  File? _slectedImage; //

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    // we user doesnot take any picture
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _slectedImage = File(pickedImage.path);
      //File(pickedImage.path):-converts XFile to File,
      //path is patch of that image where it is stored.
    });
    widget.onPickImage(_slectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera_alt_outlined),
      label: const Text("Take Picture"),
      onPressed: _takePicture,
    );

    if (_slectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _slectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
