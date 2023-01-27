import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneakers_shop/presentation/cubit/cart_cubit.dart';
import 'package:sneakers_shop/presentation/screens/widgets/cart_item.dart';
import 'package:sneakers_shop/presentation/screens/widgets/sneaker_shop_elevated_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // final CartCubit _cartCubit = CartCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leadingWidth: 34,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(
              'assets/icons/arrow_left_long.png',
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Container(
            alignment: Alignment.centerLeft,
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'My Bag',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 36),
                ),
                Text(
                  'Total n items',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    print(context.read<CartCubit>().cartList);
    print(context.read<CartCubit>().bufferList);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                child: CartItem(),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              right: 10.0, left: 10.0, top: 20.0, bottom: 30.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Text(
                    '\$510.40',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: SneakerShopElevatedButton(
                  text: 'NEXT',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
