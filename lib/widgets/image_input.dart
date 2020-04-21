import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;



class ImageInput extends StatefulWidget {
  final Function _saveImage;

  ImageInput(this._saveImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _capturedImage;

  Future<void> captureImage() async {
    
    var _capturedImage = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if(_capturedImage == null) {
      return;
    }
    setState(() {
      this._capturedImage = _capturedImage;
    });
    var appDir = await path_provider.getApplicationDocumentsDirectory();
    var fileName = path.basename(_capturedImage.path);
    var _savedFile = await _capturedImage.copy('${appDir.path}/$fileName');
    widget._saveImage(_savedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _capturedImage == null
              ? Text('No Image')
              : Image.file(_capturedImage),
              alignment: Alignment.center,
        ),
        SizedBox(width: 10,),
        Expanded(
          child: FlatButton.icon(
            textColor: Theme.of(context).primaryColor,
              onPressed: captureImage,
              icon: Icon(Icons.camera,color: Theme.of(context).primaryColor,),
              label: Text('Capture',)),
        )
      ],
    );
  }
}
