import 'package:evencir_task/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evencir_task/provider/product_page_provider.dart';
import 'package:evencir_task/widgets/custom_widgets/custom_product_cards.dart';

class ProductPageScreen extends StatefulWidget {
  const ProductPageScreen({super.key});

  @override
  State<ProductPageScreen> createState() => _ProductPageScreenState();
}

class _ProductPageScreenState extends State<ProductPageScreen> {
  late ProductPageProvider _provider;

  @override
  void initState() {
    super.initState();
    // Initialize the provider
    _provider = ProductPageProvider();
    // Fetch products after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Provide the provider to the widget tree
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
            body: ListView.builder(
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
          );
        },
      ),
    );
  }
}
