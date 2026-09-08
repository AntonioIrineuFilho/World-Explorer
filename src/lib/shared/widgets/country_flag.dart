import 'package:flutter/material.dart';
import '../models/country.dart';

class CountryFlag extends StatelessWidget {
  final Country country;
  final double width;
  final double height;

  const CountryFlag({
    super.key,
    required this.country,
    this.width = 28,
    this.height = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Text(
          country.flagEmoji,
          style: TextStyle(fontSize: height),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
