import 'package:flutter/material.dart';

import 'carousel.dart';

class Second extends StatelessWidget {
  final int selectedIndex;
  const Second({super.key, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Postogram",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Carousel(selectedIndex: selectedIndex),
    );
  }
}
