import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});
  final name = null;

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      Navigator.pop(context, pickedFile);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор изображения'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:250),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => _pickImage(context, ImageSource.gallery),
                child: const Text('Выбрать из галереи'),
              ),
              ElevatedButton(
                onPressed: () => _pickImage(context, ImageSource.camera),
                child: const Text('Сделать фото'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
