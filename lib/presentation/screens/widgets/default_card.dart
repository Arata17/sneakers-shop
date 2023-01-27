import 'package:flutter/material.dart';
import 'package:sneakers_shop/core/theme.dart';

class DefaultCard extends StatelessWidget {
  const DefaultCard({
    required this.sneakerName,
    required this.sneakerPrice,
    required this.imagePath,
    super.key,
  });
  final String sneakerName;
  final String sneakerPrice;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCardTopContent(),
                  _buildCardBottomContent(),
                ],
              ),
              Positioned(
                left: 35,
                right: 20,
                child: SizedBox(
                  height: 120,
                  width: 150,
                  child: Image.asset(
                    imagePath,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildCardTopContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 13.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RotatedBox(
            quarterTurns: 3,
            child: Container(
              width: 60,
              height: 20,
              decoration: BoxDecoration(color: SneakerShopTheme.mainRedColor),
              child: const Center(
                child: Text(
                  'NEW',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ),
          const Icon(
            Icons.favorite_outline,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  _buildCardBottomContent() {
    return Column(
      children: [
        Text(
          sneakerName,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          sneakerPrice,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
