import 'package:surf_flutter_summer_school_24/domains/entity/photos.dart';
import 'package:surf_flutter_summer_school_24/domains/reprository/IPhotoRepository.dart';

DateTime now = DateTime.now();

class MockPhotoRepository implements Iphotorepository {
  @override
  Future<List<PhotoEntity>> getPhotos() async{
    return 
    [
      PhotoEntity(id: '0', url: "assets/images/image1.jpg", createdAt: now),
      PhotoEntity(id: '1', url: "assets/images/image2.jpg", createdAt: now),
      PhotoEntity(id: '2', url: "assets/images/image3.jpg", createdAt: now),
      PhotoEntity(id: '3', url: "assets/images/image4.jpg", createdAt: now),
      PhotoEntity(id: '4', url: "assets/images/image5.jpg", createdAt: now),
      PhotoEntity(id: '5', url: "assets/images/image6.jpg", createdAt: now),
      PhotoEntity(id: '6', url: "assets/images/image7.jpg", createdAt: now),
      PhotoEntity(id: '7', url: "assets/images/image8.jpg", createdAt: now),
      PhotoEntity(id: '8', url: "assets/images/image9.jpg", createdAt: now),
    ];
  }
}
