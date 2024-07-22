import 'package:flutter/material.dart';

final List<String> images = [
  "assets/image1.jpg",
  "assets/image2.jpg",
  "assets/image3.jpg",
  "assets/image4.jpg",
  "assets/image5.jpg",
  "assets/image6.jpg",
  "assets/image7.jpg",
  "assets/image8.jpg",
  "assets/image9.jpg",
];

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var currentIndex = 0;
  void counter(newIndex){
    setState(() {
      currentIndex= newIndex;
    }); 
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
          Align(
            alignment: const Alignment(0.78, 1.0),
            child: Text("${currentIndex + 1}/${images.length}")
          ),
          SizedBox(
            width:500,
            height:500,
            child: PageView.builder(
                onPageChanged: counter,
                itemCount: images.length,
                pageSnapping: true,
                itemBuilder: (context, pagePosition) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      images[pagePosition],
                      fit:BoxFit.cover,
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
