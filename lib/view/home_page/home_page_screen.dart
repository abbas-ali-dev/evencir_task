import 'package:evencir_task/constants/text_styles.dart';
import 'package:evencir_task/view/categories_page/categories_page_screen.dart';
import 'package:evencir_task/view/favourite_page/favourite_page_screen.dart';
import 'package:evencir_task/view/mitt_konto_page/mitt_konto_page_screen.dart';
import 'package:evencir_task/view/product_page/product_page_screen.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              const Text(
                'Products',
                style: AppTextStyles.headingPlayfair,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'iphone',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('234 results found'),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const ProductPageScreen(),
                const CategoriesPageScreen(),
                const FavouritePageScreen(),
                const MittKontoPageScreen(),
              ],
            ),
          ),
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
            _buildTab(0, Icons.shopping_bag, 'Products'),
            _buildTab(1, Icons.grid_view, 'Categories'),
            _buildTab(2, Icons.favorite_border, 'Favourites'),
            _buildTab(3, Icons.person_outline, 'Mitt konto'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.white,
        ),
      ),
    );
  }

  // Helper method to build tabs with consistent styling
  Widget _buildTab(int index, IconData icon, String text) {
    return Tab(
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      text: text,
    );
  }
}
