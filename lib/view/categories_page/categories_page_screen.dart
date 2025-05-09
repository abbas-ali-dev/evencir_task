import 'package:evencir_task/constants/text_styles.dart';
import 'package:evencir_task/provider/categories_page_provider.dart';
import 'package:evencir_task/view/category_products/category_products_screen.dart';
import 'package:evencir_task/widgets/custom_widgets/custom_categories_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPageScreen extends StatefulWidget {
  const CategoriesPageScreen({super.key});

  @override
  State<CategoriesPageScreen> createState() => _CategoriesPageScreenState();
}

class _CategoriesPageScreenState extends State<CategoriesPageScreen> {
  late CategoriesPageProvider _provider;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = CategoriesPageProvider();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.fetchCategories();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Consumer<CategoriesPageProvider>(
        builder: (context, provider, child) {
          debugPrint(
              "Building CategoriesPageScreen with ${provider.categories.length} categories");

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(120.0),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
                child: Column(
                  children: [
                    const Text(
                      'Categories',
                      style: AppTextStyles.headingPlayfair,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search categories',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                  child: Text(
                    '${provider.categories.length} categories found',
                    style: AppTextStyles.bodyPoppins.copyWith(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Expanded(
                  child: provider.categories.isEmpty
                      ? Center(
                          child: Text(
                            'No categories found',
                            style: AppTextStyles.bodyPoppins,
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(16.0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: provider.categories.length,
                          itemBuilder: (context, index) {
                            final category = provider.categories[index];

                            return CustomCategoryCard(
                              imageUrl:
                                  'https://placehold.co/600x400/png?text=${category.name}',
                              label: category.name ?? 'Unknown Category',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryProductsScreen(
                                      categoryName:
                                          category.name ?? 'Unknown Category',
                                      categorySlug: category.slug ?? '',
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
