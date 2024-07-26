import 'package:surf_flutter_summer_school_24/domains/entity/photos.dart';
import 'package:surf_flutter_summer_school_24/domains/reprository/IPhotoRepository.dart';

DateTime now = DateTime.now();

class MockPhotoRepository implements Iphotorepository {
  @override
  Future<List<PhotoEntity>> getPhotos() async{
    return 
    [
      PhotoEntity(id: '0', url: "https://i.pinimg.com/736x/be/39/7c/be397c91b8026b17f5f8a6ed98e23e9e.jpg", createdAt: now),
      PhotoEntity(id: '1', url: "https://img.freepik.com/free-photo/mountains-lake_1398-1150.jpg?size=626&ext=jpg&ga=GA1.1.1788614524.1719360000&semt=ais_user", createdAt: now),
      PhotoEntity(id: '2', url: "https://twam.ru/wp-content/uploads/2024/02/priroda-solntse-47.webp", createdAt: now),
      PhotoEntity(id: '3', url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyq-7Bj6epqICH7hAh5-Tj68Q1GpjQJ6mfYw&s", createdAt: now),
      PhotoEntity(id: '4', url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwxB-60BJCUb6015xp_GvSxpCNitcumRDZaA&s", createdAt: now),
      PhotoEntity(id: '5', url: "https://bipbap.ru/wp-content/uploads/2017/04/priroda_kartinki_foto_03.jpg", createdAt: now),
      PhotoEntity(id: '6', url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThKp12Y5Y4-MX-maLnjPdikRVn8gNbuCqcdw&s", createdAt: now),
      PhotoEntity(id: '7', url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCLuMqvR7Mnd7agPo0LzjGk8f30z9HMOfBNA&s", createdAt: now),
    ];
  }
}
