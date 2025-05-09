import 'package:evencir_task/constants/text_styles.dart';
import 'package:evencir_task/provider/category_products_provider.dart';
import 'package:evencir_task/widgets/custom_widgets/custom_product_cards.dart';
import 'package:evencir_task/widgets/custom_widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryName;
  final String categorySlug;

  const CategoryProductsScreen({
    super.key,
    required this.categoryName,
    required this.categorySlug,
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  late CategoryProductsProvider _provider;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = CategoryProductsProvider();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.fetchCategoryProducts(widget.categorySlug);
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
      child: Consumer<CategoryProductsProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(120.0),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Text(
                            widget.categoryName,
                            style: AppTextStyles.headingPlayfair.copyWith(
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    CustomSearchBar(
                      hintText: 'Search in ${widget.categoryName}',
                      controller: _searchController,
                      onChanged: (query) {
                        provider.searchProducts(query);
                      },
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
                      const EdgeInsets.only(left: 30.0, top: 5.0, bottom: 10.0),
                  child: Text(
                    '${provider.filteredProducts.length} products found',
                    style: AppTextStyles.bodyPoppins.copyWith(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Expanded(
                  child: provider.filteredProducts.isEmpty
                      ? Center(
                          child: Text(
                            'No products found in this category',
                            style: AppTextStyles.bodyPoppins,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: provider.filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = provider.filteredProducts[index];
                            return CustomProductCards(
                              imageUrl: product.thumbnail ?? '',
                              title: product.title ?? 'Unknown Product',
                              rating: product.rating ?? 0.0,
                              company: product.brand ?? 'Unknown Brand',
                              category: product.category ?? 'Unknown Category',
                              price: product.price?.toInt() ?? 0,
                              product: product,
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
