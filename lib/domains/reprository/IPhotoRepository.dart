import 'package:surf_flutter_summer_school_24/domains/entity/photos.dart';

abstract interface class Iphotorepository {
  Future<List<PhotoEntity>> getPhotos();
}
