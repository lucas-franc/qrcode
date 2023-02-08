import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File? _image;

  Future getImage(bool isCamera) async {
    XFile? image;
    if (isCamera) {
      image = (await ImagePicker().pickImage(source: ImageSource.camera));
    } else {
      image = (await ImagePicker().pickImage(source: ImageSource.gallery));
    }
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    getImage(false);
                  },
                  icon: const Icon(Icons.insert_drive_file),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    getImage(true);
                  },
                  icon: const Icon(Icons.camera_alt),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null
                  ? Container()
                  : Image.file(
                      _image as File,
                      width: 200,
                      height: 300,
                    ),
            ],
          ),
        )
      ],
    );
  }
}
