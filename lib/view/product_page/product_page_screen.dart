import 'package:evencir_task/constants/text_styles.dart';
import 'package:evencir_task/widgets/custom_widgets/custom_product_cards.dart';
import 'package:flutter/material.dart';

class ProductPageScreen extends StatelessWidget {
  const ProductPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
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
      body: ListView(
        children: [
          CustomProductCards(
            imageUrl:
                'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
            title: 'Iphone 14',
            rating: 4.9,
            company: 'Apple',
            category: 'smartphones',
            price: 60,
          ),
          CustomProductCards(
            imageUrl:
                'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
            title: 'Samsung Galaxy Book',
            rating: 4.9,
            company: 'Samsung',
            category: 'laptops',
            price: 60,
          ),
        ],
      ),
    );
  }
}
