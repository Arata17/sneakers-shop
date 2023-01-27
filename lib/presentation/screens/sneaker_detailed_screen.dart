import 'package:flutter/material.dart';
import 'package:sneakers_shop/core/theme.dart';
import 'package:sneakers_shop/domain/cart_entity.dart';
import 'package:sneakers_shop/domain/snekaer_entity.dart';
import 'package:sneakers_shop/presentation/cubit/cart_cubit.dart';
import 'package:sneakers_shop/presentation/screens/widgets/sneaker_shop_elevated_button.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SneakerDetailedScreen extends StatefulWidget {
  const SneakerDetailedScreen({required this.entity, super.key});
  final SneakerEntity entity;

  @override
  State<SneakerDetailedScreen> createState() => _SneakerDetailedScreenState();
}

class _SneakerDetailedScreenState extends State<SneakerDetailedScreen> {
  // final CartCubit _cartCubit = CartCubit();
  final List<bool> _selectedContry = [true, false];
  final List<String> _sizes = [
    '7.5',
    '8',
    '9.5',
    '10',
    '10.5',
    '11',
    '11.5',
    '12'
  ];
  var _selectedIndex = -1;
  var hasAppBar = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var route = ModalRoute.of(context);
    route?.animation?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          hasAppBar = true;
        });
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: hasAppBar
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 34,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      hasAppBar = false;
                    });
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/icons/arrow_left_long.png',
                    color: Colors.white,
                  ),
                ),
              ),
              title: const Text(
                'NIKE',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                    height: 38,
                    width: 38,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: kElevationToShadow[2],
                        color: widget.entity.backgroundColor.withOpacity(0.8),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_outline_outlined,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          : null,
      body: Stack(
        children: [
          Positioned(
            right: -200,
            top: -300,
            child: Hero(
              tag: '${widget.entity.backgroundColor}',
              child: Container(
                height: 600,
                width: 600,
                decoration: BoxDecoration(
                    color: widget.entity.backgroundColor,
                    shape: BoxShape.circle),
              ),
            ),
          ),
          _buildBody()
        ],
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 20, left: 20),
            child: Hero(
              tag: widget.entity.imagePath,
              child: Image.asset(
                widget.entity.imagePath,
              ),
            ),
          ),
          _buildPreview(),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 2,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(
            height: 5,
          ),
          _buildDescription(),
          _buildSizeSection(),
          Padding(
            padding: const EdgeInsets.only(
                right: 20.0, left: 20.0, top: 30.0, bottom: 20),
            child: SneakerShopElevatedButton(
              text: 'ADD TO BAG',
              onPressed: () {
                context.read<CartCubit>().addToCart(
                    CartEntity(
                      modelName: widget.entity.modelName,
                      price: widget.entity.price,
                      imagePath: widget.entity.imagePath,
                    ),
                    1);
                context.read<CartCubit>().getCartBufferItems();
                context.read<CartCubit>().getCartItems();
                print(context.read<CartCubit>().bufferList);
                print(context.read<CartCubit>().cartList);
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildPreview() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: index + 1 == 4
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(widget.entity.imagePath),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.play_circle_fill_outlined,
                        size: 36,
                        color: Colors.white,
                      ),
                    ],
                  )
                : Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: SneakerShopTheme.lightGrey,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Image.asset(widget.entity.imagePath),
                  ),
          );
        },
      ),
    );
  }

  _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescriptionTopContent(),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 2,
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: const Text(
              'MORE DETAILS',
              style: TextStyle(
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(0, -3),
                  ),
                ],
                decoration: TextDecoration.underline,
                decorationColor: Colors.black,
                color: Colors.transparent,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildDescriptionTopContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.entity.modelName,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 10,
              width: 80,
              color: Colors.red.shade100.withOpacity(0.5),
            ),
            Text(
              widget.entity.price,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 18),
            ),
          ],
        )
      ],
    );
  }

  _buildSizeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          _buildSizeSectionTopContent(),
          _buildSizeSectionBottomContent()
        ],
      ),
    );
  }

  _buildSizeSectionTopContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Size',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
        ToggleButtons(
          renderBorder: false,
          isSelected: _selectedContry,
          fillColor: Colors.transparent,
          splashColor: Colors.transparent,
          constraints: const BoxConstraints(
            minWidth: 36,
          ),
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < _selectedContry.length; i++) {
                _selectedContry[i] = i == index;
              }
            });
          },
          children: [
            Text(
              'UK',
              style: TextStyle(
                  color: _selectedContry[0] ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'USA',
              style: TextStyle(
                  color: _selectedContry[1] ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }

  _buildSizeSectionBottomContent() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _sizes.length + 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                if (index != 0) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
              },
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: _selectedIndex == index
                      ? Colors.black
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: index == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Try it',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                                height: 24,
                                width: 24,
                                child:
                                    Image.asset('assets/icons/footprints.png'))
                          ],
                        )
                      : Text(
                          _sizes[index - 1],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: _selectedIndex == index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
