import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickedFn;

  UserImagePicker(this.imagePickedFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.getImage(source: ImageSource.camera, imageQuality: 70, maxHeight: 400, maxWidth: 400);
    final imageFile = File(image!.path);

    setState(() {
      _pickedImage = imageFile;
    });
    widget.imagePickedFn(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Set Profile Picture'),
        ),
      ],
    );
  }
}
