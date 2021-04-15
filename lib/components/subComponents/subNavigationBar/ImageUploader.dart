import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_epicturee/Views/UploaderView.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpdater extends StatefulWidget {
  @override
  _ImageUpdaterState createState() => _ImageUpdaterState();
}

class _ImageUpdaterState extends State<ImageUpdater> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      marginRight: 18,
      marginBottom: 20,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      backgroundColor: Colors.lightBlueAccent,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
            child: Icon(Icons.camera_alt),
            backgroundColor: Colors.lightBlueAccent,
            onTap: () async {
              var image = await ImagePicker.platform.pickImage(source: ImageSource.camera, imageQuality: 50);

              Navigator.push(context, MaterialPageRoute(
                builder: (context) => UploaderView(imageData: File(image.path)),
              ));
            }
        ),
        SpeedDialChild(
            child: Icon(Icons.image),
            backgroundColor: Colors.lightBlueAccent,
            onTap: () async {
              var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery, imageQuality: 50);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => UploaderView(imageData: File(image.path)),
                // builder: (context) => NewView(imageData: image)
              ));
            }
        )
      ],
    );
  }
}
