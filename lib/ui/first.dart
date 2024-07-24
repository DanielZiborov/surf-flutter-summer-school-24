import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/domains/entity/photos.dart';
import 'package:surf_flutter_summer_school_24/data/repository/mockphotorepository.dart';
import 'second.dart';

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
          ),
          body: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
            ]),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Second(selectedIndex: index),
                            ));
                      },
                      child: Image.asset(
                        photos[index].getUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            )
          ]),
        );
      },
    );
  }
}
