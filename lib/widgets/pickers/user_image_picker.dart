import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
        ),
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.image),
          label: Text('Set Profile Picture'),
        ),
      ],
    );
  }
}
