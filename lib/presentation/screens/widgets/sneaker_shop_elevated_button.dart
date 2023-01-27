import 'package:flutter/material.dart';
import 'package:sneakers_shop/core/theme.dart';

class SneakerShopElevatedButton extends StatefulWidget {
  const SneakerShopElevatedButton(
      {required this.text, required this.onPressed, super.key});
  final String text;
  final VoidCallback onPressed;

  @override
  State<SneakerShopElevatedButton> createState() =>
      _SneakerShopElevatedButtonState();
}

class _SneakerShopElevatedButtonState extends State<SneakerShopElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: () => widget.onPressed.call(),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(SneakerShopTheme.mainRedColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
