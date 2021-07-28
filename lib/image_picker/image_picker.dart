import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image = null;
  final picker = ImagePicker();

  getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    File? cropedImage = await ImageCropper.cropImage(
      sourcePath: pickedFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square
      ],
      compressQuality: 60,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: androidUiSettingsLoked(),
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(cropedImage!.path);
        if (_image == null) {
          print("null image");
        }
      } else {
        print('No image selected.');
      }
      Navigator.of(context).pop();
    });
  }

  Future<File?> cropImage(File image) async => await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
        compressQuality: 60,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: androidUiSettingsLoked(),
      );

  AndroidUiSettings androidUiSettingsLoked() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
        hideBottomControls: true,
        lockAspectRatio: false,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child:
            _image == null ? Text('No image selected.') : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Add a Photo'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
              onTap: () {
                getImage(ImageSource.camera);
              },
              child: Text("Take photo")),
          SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                getImage(ImageSource.gallery);
              },
              child: Text("Choose from gallery")),
        ],
      ),
    );
  }
}
