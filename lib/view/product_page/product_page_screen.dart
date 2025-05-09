import 'package:evencir_task/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evencir_task/provider/product_page_provider.dart';
import 'package:evencir_task/widgets/custom_widgets/custom_product_cards.dart';
import 'package:evencir_task/widgets/custom_widgets/custom_search_bar.dart';

class ProductPageScreen extends StatefulWidget {
  const ProductPageScreen({super.key});

  @override
  State<ProductPageScreen> createState() => _ProductPageScreenState();
}

class _ProductPageScreenState extends State<ProductPageScreen> {
  late ProductPageProvider _provider;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = ProductPageProvider();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.fetchProducts();
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
      child: Consumer<ProductPageProvider>(
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
                    const Text(
                      'Products',
                      style: AppTextStyles.headingPlayfair,
                    ),
                    CustomSearchBar(
                      hintText: 'iphone',
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
                    '${provider.products.length} results found',
                    style: AppTextStyles.bodyPoppins.copyWith(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                // Product list
                Expanded(
                  child: provider.products.isEmpty
                      ? Center(
                          child: Text(
                            provider.isLoading ? '' : 'No products found',
                            style: AppTextStyles.bodyPoppins,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: provider.products.length,
                          itemBuilder: (context, index) {
                            final product = provider.products[index];
                            return CustomProductCards(
                              imageUrl: product.thumbnail ?? '',
                              title: product.title ?? 'Unknown Product',
                              rating: product.rating ?? 0.0,
                              company: product.brand ?? 'Unknown Brand',
                              category: product.category ?? 'Unknown Category',
                              price: product.price?.toInt() ?? 0,
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
