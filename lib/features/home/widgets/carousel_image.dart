import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:node/constants/global_variable.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Image.network(
              i,
              fit: BoxFit.cover,
              height: 200,
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 200, // Specify the height of the carousel
        // autoPlay: true, // Add other options as needed
        // enlargeCenterPage: true,
        // aspectRatio: 16 / 9,
        viewportFraction: 1,
      ),
    );
  }
}
