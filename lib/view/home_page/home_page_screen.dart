import 'package:evencir_task/view/categories_page/categories_page_screen.dart';
import 'package:evencir_task/view/favourite_page/favourite_page_screen.dart';
import 'package:evencir_task/view/mitt_konto_page/mitt_konto_page_screen.dart';
import 'package:evencir_task/view/product_page/product_page_screen.dart';
import 'package:evencir_task/widgets/custom_widgets/custom_tabs.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          const ProductPageScreen(),
          const CategoriesPageScreen(),
          const FavouritePageScreen(),
          const MittKontoPageScreen(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.black,
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: const Color(0x0DF2F2F2),
          ),
          tabs: [
            customTab(0, Icons.shopping_bag, 'Products'),
            customTab(1, Icons.grid_view, 'Categories'),
            customTab(2, Icons.favorite_border, 'Favourites'),
            customTab(3, Icons.person_outline, 'Mitt konto'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.white,
        ),
      ),
    );
  }
}
