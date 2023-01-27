import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard(
      {required this.brandName,
      required this.modelName,
      required this.price,
      required this.imagePath,
      required this.progress,
      this.backgroundColor = Colors.teal,
      this.onTap,
      super.key});
  final String brandName;
  final String modelName;
  final String price;
  final String imagePath;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Stack(
        children: [
          Hero(
            tag: '$backgroundColor',
            child: Card(
              margin: const EdgeInsets.only(
                  left: 5, right: 30, top: 20, bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTopContent(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 28,
                      width: 28,
                      child: Image.asset(
                        'assets/icons/arrow_right_long.png',
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: 10,
            left: 10,
            right: -10,
            child: Transform(
              transform: Matrix4.rotationZ(
                progress * 2,
              )..translate(0.0, -progress / 4),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 270,
                  child: Hero(tag: imagePath, child: Image.asset(imagePath)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildTopContent() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                brandName,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
              const Icon(
                Icons.favorite_outline,
                color: Colors.white,
              ),
            ],
          ),
          Text(
            modelName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            price,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
