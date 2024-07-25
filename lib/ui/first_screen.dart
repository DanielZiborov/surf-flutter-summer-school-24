import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surf_flutter_summer_school_24/domains/entity/photos.dart';
import 'package:surf_flutter_summer_school_24/data/repository/mockphotorepository.dart';
import 'package:surf_flutter_summer_school_24/feature/photo/di/photo_inherited.dart';
import 'package:surf_flutter_summer_school_24/feature/photo/photo_service/uploadImageToYandexCloud.dart';
import 'package:surf_flutter_summer_school_24/feature/photo/widgets/ImagePickerWidget.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/di/theme_inherited.dart';
import 'second_screen.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  late Future<List<PhotoEntity>> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = MockPhotoRepository().getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeInherited.of(context);
    final photoController = PhotoInherited.of(context);

    String name='';
    String path='';

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
              IconButton(
                onPressed: () async{
                  final file = await Navigator.push<XFile>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImagePickerWidget(),
                    ),
                  );
                  name = file!.name;
                  path = file.path;
                  uploadImageToYandexCloud(name,path);
                },
                icon: const Icon(Icons.add),
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
              SizedBox(
                width: 600,
                height: 600,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        child: Image.asset(
                          photos[index].getUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
