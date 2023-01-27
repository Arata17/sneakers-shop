import 'package:flutter/material.dart';
import 'package:sneakers_shop/core/theme.dart';
import 'package:sneakers_shop/domain/snekaer_entity.dart';
import 'package:sneakers_shop/presentation/screens/cart_screen.dart';
import 'package:sneakers_shop/presentation/screens/sneaker_detailed_screen.dart';
import 'package:sneakers_shop/presentation/screens/widgets/carousel_card.dart';
import 'package:sneakers_shop/presentation/screens/widgets/default_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _horizontalTabController;
  late TabController _verticalTabController;
  late PageController _sneakersPageController;
  int _selectedCompanyIndex = 0;
  int _selectedCategoryIndex = 1;
  final companyFilterList = [
    'Nike',
    'Addidas',
    'Jordan',
    'Puma',
    'Rebook',
    'NewBalance',
  ];

  final categoryFilterList = ['New', 'Featured', 'Upcoming'];

  final itemsList = [
    SneakerEntity(
        brandName: 'NIKE',
        modelName: 'EPIC-REACT',
        price: '\$130.00',
        imagePath: 'assets/images/sneaker_01.png',
        backgroundColor: Colors.cyan),
    SneakerEntity(
        brandName: 'NIKE',
        modelName: 'AIR-MAX',
        price: '\$130.00',
        imagePath: 'assets/images/sneaker_02.png',
        backgroundColor: Colors.purple),
    SneakerEntity(
        brandName: 'NIKE',
        modelName: 'AIR-270',
        price: '\$150.00',
        imagePath: 'assets/images/sneaker_03.png',
        backgroundColor: Colors.teal),
    SneakerEntity(
        brandName: 'NIKE',
        modelName: 'AIR-MONARCH',
        price: '\$100.00',
        imagePath: 'assets/images/sneaker_04.png',
        backgroundColor: Colors.redAccent),
  ];

  @override
  void initState() {
    _horizontalTabController =
        TabController(length: companyFilterList.length, vsync: this);
    _verticalTabController = TabController(length: 3, vsync: this);
    _sneakersPageController = PageController(
      initialPage: 0,
      keepPage: false,
      viewportFraction: 0.85,
    );
    _horizontalTabController.addListener(() {
      setState(() {
        _selectedCompanyIndex = _horizontalTabController.index;
      });
    });
    _verticalTabController.addListener(() {
      setState(() {
        _selectedCategoryIndex = _verticalTabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 10,
        title: const Text(
          'Discover',
          style: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 28, color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: SneakerShopTheme.lightGrey,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: SneakerShopTheme.lightGrey,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          padding: const EdgeInsets.only(left: 5.0),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          controller: _horizontalTabController,
          indicatorPadding:
              const EdgeInsets.only(bottom: 25, right: 10, left: 10),
          indicatorColor: Colors.grey.shade300,
          indicatorWeight: 10,
          isScrollable: true,
          tabs: _buildTabs(
              list: companyFilterList, selectedIndex: _selectedCompanyIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: SneakerShopTheme.lightGrey,
        elevation: 0,
        onTap: (value) {
          if (value == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.favorite_outline_outlined,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.pin_drop_outlined,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.person_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCards(),
          const SizedBox(
            height: 20,
          ),
          _buildMoreSection()
        ],
      ),
    );
  }

  _buildCards() {
    return Row(
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: SizedBox(
            width: 330,
            child: TabBar(
              controller: _verticalTabController,
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              indicatorColor: Colors.transparent,
              tabs: _buildTabs(
                  list: categoryFilterList,
                  selectedIndex: _selectedCategoryIndex,
                  fontSize: 13),
            ),
          ),
        ),
        Flexible(
          child: SizedBox(
            height: 380,
            child: PageView.builder(
              padEnds: false,
              controller: _sneakersPageController,
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                return CarouselCard(
                  brandName: itemsList[index].brandName,
                  modelName: itemsList[index].modelName,
                  price: itemsList[index].price,
                  imagePath: itemsList[index].imagePath,
                  backgroundColor: itemsList[index].backgroundColor,
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SneakerDetailedScreen(entity: itemsList[index]),
                      transitionDuration: const Duration(milliseconds: 400),
                      transitionsBuilder: (_, a, __, c) => SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(a),
                        child: FadeTransition(
                          opacity: a,
                          child: c,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _buildMoreSection() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
            width: double.infinity,
            height: 100,
            color: SneakerShopTheme.lightGrey),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: _buildSectionTitle(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: const [
                  Expanded(
                    child: DefaultCard(
                      sneakerName: 'NIKE AIR-MAX',
                      sneakerPrice: '\$170.00',
                      imagePath: 'assets/images/sneaker_05.png',
                    ),
                  ),
                  Expanded(
                    child: DefaultCard(
                      sneakerName: 'NIKE AIR FORCE',
                      sneakerPrice: '\$130.00',
                      imagePath: 'assets/images/sneaker_06.png',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  _buildTabs({
    required List<String> list,
    required int selectedIndex,
    double fontSize = 17,
  }) {
    List<Widget> tabs = [];
    for (var name in list) {
      tabs.add(Tab(
        child: Text(
          name,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: selectedIndex == list.indexOf(name)
                  ? Colors.black
                  : SneakerShopTheme.inactiveGrey),
        ),
      ));
    }
    return tabs;
  }

  _buildSectionTitle() {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'More',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
          ),
          SizedBox(
            height: 28,
            width: 28,
            child: Image.asset(
              'assets/icons/arrow_right_long.png',
              scale: 4,
            ),
          )
        ],
      ),
    );
  }
}
