import 'package:flutter/material.dart';
import 'package:sneakers_shop/core/theme.dart';
import 'package:sneakers_shop/presentation/screens/widgets/qty_counter.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25.0),
                ),
                color: SneakerShopTheme.inactiveGrey.withOpacity(0.4),
              ),
            ),
            Positioned(
              right: -50,
              top: -40,
              child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/images/sneaker_01.png')),
            ),
          ],
        ),
        const SizedBox(
          width: 60,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AIR-MAX',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              '\$190.00',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
            ),
            const SizedBox(
              height: 15.0,
            ),
            QtyCounter(
              counterCallback: (qty) {},
              increaseCallback: () {},
              decreaseCallback: () {},
            )
          ],
        )
      ],
    );
  }
}
