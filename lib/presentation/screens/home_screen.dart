import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sneakers_shop/core/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final companyFilterList = [
    'Nike',
    'Addidas',
    'Jordan',
    'Puma',
    'Rebook',
    'NewBalance',
  ];

  final categoryFilterList = ['New', 'Featured', 'Upcoming'];

  late TabController _horizontalTabController;
  late TabController _verticalTabController;
  late PageController _sneakersPageController;
  int _selectedCompanyIndex = 0;
  int _selectedCategoryIndex = 1;

  @override
  void initState() {
    _horizontalTabController =
        TabController(length: companyFilterList.length, vsync: this);
    _verticalTabController = TabController(length: 3, vsync: this);
    _sneakersPageController = PageController(
      initialPage: 0,
      keepPage: false,
      viewportFraction: 0.8,
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
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.pin_drop,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 10), child: _buildBody()),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCards(),
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
            width: 400,
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
            height: 400,
            child: PageView.builder(
              padEnds: false,
              controller: _sneakersPageController,
              itemBuilder: (context, index) {
                return const Card(
                  margin: EdgeInsets.only(left: 30, top: 20, bottom: 20),
                  color: Colors.cyan,
                  child: Text('Sneaker'),
                );
              },
            ),
          ),
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
}
