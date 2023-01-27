import 'package:flutter/material.dart';

class SneakerEntity {
  final String brandName;
  final String modelName;
  final String price;
  final String imagePath;
  final Color backgroundColor;

  SneakerEntity(
      {required this.brandName,
      required this.modelName,
      required this.price,
      required this.imagePath,
      required this.backgroundColor});
}
