import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_flutter_summer_school_24/feature/photo/di/photo_inherited.dart';
import 'package:surf_flutter_summer_school_24/feature/photo/domain/photo_controller.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/data/theme_repository.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/di/theme_inherited.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/domain/theme_controller.dart';
import 'package:surf_flutter_summer_school_24/storage/theme/theme_storage.dart';
import 'package:surf_flutter_summer_school_24/uikit/theme/theme_data.dart';
import 'ui/first_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeStorage = ThemeStorage(prefs: prefs);
  final themeRepository = ThemeRepository(themeStorage: themeStorage);
  final themeController = ThemeController(themeRepository: themeRepository);
  final photoController = PhotoController();

  runApp(MainApp(
      themeController: themeController, photoController: photoController));
}

class MainApp extends StatelessWidget {
  final PhotoController photoController;
  final ThemeController themeController;
  const MainApp({
    super.key,
    required this.themeController,
    required this.photoController,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeInherited(
      themeController: themeController,
      child: PhotoInherited(
        photoController: photoController,
        child: ValueListenableBuilder<ThemeMode>(
          valueListenable: themeController.themeMode,
          builder: (context, themeMode, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppThemeData.lightTheme,
              darkTheme: AppThemeData.darkTheme,
              themeMode: themeMode,
              home: const First(),
            );
          },
        ),
      ),
    );
  }
}
