import 'package:flutter/material.dart';
import 'package:sneakers_shop/core/theme.dart';

class QtyCounter extends StatefulWidget {
  const QtyCounter(
      {this.initNumber = 1,
      required this.counterCallback,
      required this.increaseCallback,
      required this.decreaseCallback,
      this.minNumber = 0,
      super.key});
  final int initNumber;
  final Function(int) counterCallback;
  final Function increaseCallback;
  final Function decreaseCallback;
  final int minNumber;

  @override
  State<QtyCounter> createState() => _QtyCounterState();
}

class _QtyCounterState extends State<QtyCounter> {
  late int _currentCount;
  @override
  void initState() {
    _currentCount = widget.initNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _createIncrementDicrementButton(Icons.remove, () => _dicrement()),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          _currentCount.toString(),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(
          width: 20.0,
        ),
        _createIncrementDicrementButton(Icons.add, () => _increment()),
      ],
    );
  }

  void _increment() {
    setState(() {
      _currentCount++;
      widget.counterCallback(_currentCount);
      widget.increaseCallback();
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > widget.minNumber) {
        _currentCount--;
        widget.counterCallback(_currentCount);
        widget.decreaseCallback();
      }
    });
  }

  Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
    return Container(
      height: 30,
      width: 45,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
        color: SneakerShopTheme.inactiveGrey.withOpacity(0.1),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () => onPressed.call(),
        icon: Icon(
          icon,
          size: 24.0,
        ),
      ),
    );
  }
}
