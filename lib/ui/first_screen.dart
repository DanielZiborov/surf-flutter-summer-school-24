import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:surf_flutter_summer_school_24/domains/entity/photos.dart';
import 'package:surf_flutter_summer_school_24/data/repository/mockphotorepository.dart';
import 'package:surf_flutter_summer_school_24/feature/photo/di/photo_inherited.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/di/theme_inherited.dart';
import 'package:surf_flutter_summer_school_24/widgets/photo_picker_widget.dart';
import 'second_screen.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  late Future<List<PhotoEntity>> futurePhotos;
  final List<XFile> _selectedImages = [];
  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    futurePhotos = MockPhotoRepository().getPhotos();
  }

  Future<void> _navigateToPhotoPicker(BuildContext context) async {
    final result = await Navigator.push<XFile>(
      context,
      MaterialPageRoute(
        builder: (context) => const PhotoPickerWidget(),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedImages.add(result);
      });
    }
  }

  List<PhotoEntity> _createPhotoEntitiesFromFiles(List<XFile> files) {
    return files.map((file) {
      return PhotoEntity(
        id: _uuid.v4(),
        url: file.path,
        createdAt: DateTime.now(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeInherited.of(context);
    final photoController = PhotoInherited.of(context);

    return FutureBuilder<List<PhotoEntity>>(
      future: futurePhotos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Нет доступных фотографий'));
        }

        List<PhotoEntity> photos = snapshot.data!;

        if (_selectedImages.isNotEmpty) {
          photos = _createPhotoEntitiesFromFiles(_selectedImages) + photos;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Postogram",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              ValueListenableBuilder<ThemeMode>(
                valueListenable: themeController.themeMode,
                builder: (context, themeMode, _) {
                  return IconButton(
                    icon: Icon(themeMode == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode),
                    onPressed: () => themeController.switchThemeMode(),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Second(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => _navigateToPhotoPicker(context),
                child: const Text('Pick a Photo'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            photoController.setCurrentIndex(index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Second(selectedIndex: index),
                              ),
                            );
                          },
                          child: 
                          Image.asset(
                            photos[index].getUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
