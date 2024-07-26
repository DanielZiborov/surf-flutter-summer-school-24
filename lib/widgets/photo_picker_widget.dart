import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surf_flutter_summer_school_24/services/image_picker_service.dart';
import 'package:surf_flutter_summer_school_24/services/upload.dart';

class PhotoPickerWidget extends StatefulWidget {
  const PhotoPickerWidget({super.key});

  @override
  _PhotoPickerWidgetState createState() => _PhotoPickerWidgetState();
}

class _PhotoPickerWidgetState extends State<PhotoPickerWidget> {
  final ImagePickerService _imagePickerService = ImagePickerService();
  final ValueNotifier<XFile?> _imageNotifier = ValueNotifier<XFile?>(null);

  Future<void> _pickImageFromGallery() async {
    final image = await _imagePickerService.pickImageFromGallery();
    _imageNotifier.value = image;
  }

  Future<void> _pickImageFromCamera() async {
    final image = await _imagePickerService.pickImageFromCamera();
    _imageNotifier.value = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Photo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ElevatedButton(
                  onPressed: _pickImageFromGallery,
                  child: const Text('Pick from Gallery'),
                ),
                ElevatedButton(
                  onPressed: _pickImageFromCamera,
                  child: const Text('Pick from Camera'),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<XFile?>(
            valueListenable: _imageNotifier,
            builder: (context, image, _) {
              if (image != null) {
                return Column(
                  children: [
                    Image.file(File(image.path)),
                    ElevatedButton(
                      onPressed: () {
                        uploadPhoto(image);
                        Navigator.pop(context, image);
                      },
                      child: const Text('Confirm Selection'),
                    ),
                  ],
                );
              } else {
                return const Text('No image selected');
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _imageNotifier.dispose();
    super.dispose();
  }
}
