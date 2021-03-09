import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function _selectImageFunction;

  ImageInput(this._selectImageFunction);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final imageFile = await imagePicker.getImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );
    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();

    final fileName = path.basename(imageFile.path);

    final savedImage = await _storedImage.copy('${appDir.path}/${fileName}');

    widget._selectImageFunction(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          width: 100,
          height: 100,
          alignment: Alignment.center,
          child: _storedImage == null
              ? Text('No Image Taken', textAlign: TextAlign.center)
              : Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
