import 'package:flutter/material.dart';
import 'Images.dart';

DateTime now = DateTime.now();

class Carousel extends StatefulWidget {
  final int selectedIndex;
  const Carousel({super.key, this.selectedIndex = 0});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedIndex;
  }

  void counter(newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          Text(
              "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}",
              style: const TextStyle(
                color: Colors.black,
              )),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text("${currentIndex + 1}/${images.length}"),
          ),
        ],
      ),
      SizedBox(
        width: 500,
        height: 500,
        child: PageView.builder(
            onPageChanged: counter,
            itemCount: images.length,
            controller: PageController(initialPage: currentIndex),
            pageSnapping: true,
            itemBuilder: (context, pagePosition) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  images[pagePosition],
                  fit: BoxFit.cover,
                ),
              );
            }),
      ),
    ]);
  }
}
