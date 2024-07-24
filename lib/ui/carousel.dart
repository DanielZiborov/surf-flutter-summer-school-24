import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/domains/entity/photos.dart';
import 'package:surf_flutter_summer_school_24/data/repository/mockphotorepository.dart';
import 'package:surf_flutter_summer_school_24/feature/photo/di/photo_inherited.dart';

class Carousel extends StatefulWidget {
  final int selectedIndex;
  const Carousel({super.key, this.selectedIndex = 0});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late Future<List<PhotoEntity>> futurePhotos;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedIndex;
    futurePhotos = MockPhotoRepository().getPhotos();
  }

  @override
  Widget build(BuildContext context) {
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
        return Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              ValueListenableBuilder<int>(
                valueListenable: photoController.currentIndex,
                builder: (context, currentIndex, _) {
                  return Text(
                    photos[currentIndex].formattedCreatedAt,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 96, 96, 96),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ValueListenableBuilder<int>(
                  valueListenable: photoController.currentIndex,
                  builder: (context, currentIndex, _) {
                    return Text("${currentIndex + 1}/${photos.length}");
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            width: 500,
            height: 500,
            child: ValueListenableBuilder<int>(
              valueListenable: photoController.currentIndex,
              builder: (context, currentIndex, _) {
                return PageView.builder(
                  onPageChanged: (newIndex) {
                    photoController.setCurrentIndex(newIndex);
                  },
                  itemCount: photos.length,
                  controller: PageController(initialPage: currentIndex),
                  pageSnapping: true,
                  itemBuilder: (context, pagePosition) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        photos[pagePosition].getUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]);
      },
    );
  }
}
