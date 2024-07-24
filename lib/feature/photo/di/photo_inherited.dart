import 'package:flutter/widgets.dart';
import 'package:surf_flutter_summer_school_24/feature/photo/domain/photo_controller.dart';

class PhotoInherited extends InheritedWidget {
  final PhotoController photoController;

  const PhotoInherited({
    super.key,
    required super.child,
    required this.photoController,
  });

  static PhotoController of(BuildContext context) {
    final PhotoInherited? result = context.dependOnInheritedWidgetOfExactType<PhotoInherited>();
    assert(result != null, 'No PhotoInherited found in context');
    return result!.photoController;
  }

  @override
  bool updateShouldNotify(PhotoInherited oldWidget) {
    return oldWidget.photoController != photoController;
  }
}
