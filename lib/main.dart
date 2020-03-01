import 'package:flutter/material.dart';
import 'view/view_home/list.dart';

void main() async {
  CustomImageCache();
  runApp(RootWidget());
}

class CustomImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    ImageCache imageCache = super.createImageCache();
    // Set your image cache size
    imageCache.maximumSizeBytes = 1024 * 1024 * 800;
    return imageCache;
  }
}

class RootWidget extends StatelessWidget {
  final boyColor = const Color(0xFF047A3F);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListState(),
      theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: boyColor,
          accentColor: boyColor),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
    );
  }
}

